import 'package:baykurs/util/SharedPrefHelper.dart';
import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  State<AttendancePage> createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage>
    with SingleTickerProviderStateMixin {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isPermissionGranted = false;

  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  void showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  void hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.camera.status;

    if (!status.isGranted) {
      status = await Permission.camera.request();
    }

    setState(() {
      isPermissionGranted = status.isGranted;
    });
  }

  void _goToAppSettings() async {
    bool opened = await openAppSettings();

    if (!opened) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Ayarlar açılamadı. Lütfen manuel olarak izin verin."),
        ),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    controller?.dispose();
    super.dispose();
  }

  Future<void> postAttendance(String url) async {
    try {
      showLoading(); // Yükleme başlıyor

      final dio = Dio();
      final token = await getToken();

      final response = await dio.post(
        url,
        data: {}, // Eğer veri gönderiyorsan
        options: Options(
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            "X-Requested-From": "baykursmobileapp",
            "Authorization": "Bearer $token",
          },
        ),
      );

      debugPrint("Post Başarılı => ${response.data}");

      if (response.statusCode == 200) {
        Get.snackbar(
          "Başarılı",
          "Yoklama alındı!",
          colorText: Colors.white,
          backgroundColor: Colors.green,
        );
        Future.delayed(const Duration(milliseconds: 1200), () {
          Navigator.pop(context, true);
        });
      } else {
        Get.snackbar(
          "Başarısız",
          "Yoklama alınamadı!",
          colorText: Colors.white,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      debugPrint("Hata: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bir hata oluştu. ❌")),
      );
    } finally {
      hideLoading(); // Yükleme bitti
    }
  }

  // --- BURASI QR OKUMA VE URL YÖNLENDİRME ---
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();

      String? code = scanData.code?.trim();

      debugPrint('QR CODE: $code');

      if (code == null || code.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Geçerli bir QR kod değil!")),
        );
        controller.resumeCamera();
        return;
      }

      // Eğer URL ise post isteği at!
      if (!code.startsWith('http')) {
        code = 'https://$code';
      }

      // POST isteği gönderiyoruz
      await postAttendance(code);

      await Future.delayed(const Duration(seconds: 2));
      controller.resumeCamera();
    });
  }

  bool isURL(String? code) {
    if (code == null) return false;

    final urlPattern = r'^(http|https):\/\/([\w-]+(\.[\w-]+))+(:\d+)?(\/\S*)?$';

    final regExp = RegExp(urlPattern);

    return regExp.hasMatch(code.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Yoklama Al'),
        ),
        body: Stack(
          children: [
            isPermissionGranted
                ? Stack(
                    children: [
                      QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        overlay: QrScannerOverlayShape(
                          borderColor: color5,
                          borderRadius: 12,
                          borderLength: 30,
                          borderWidth: 10,
                          cutOutSize: MediaQuery.of(context).size.width * 0.7,
                        ),
                      ),
                      Center(
                        child: AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) {
                            return CustomPaint(
                              painter: ScannerOverlayPainter(
                                  animationValue: _animation.value),
                              child: const SizedBox.expand(),
                            );
                          },
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'QR Kodunu kare içine hizala',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Kamera izni vermek istemiyorsan , yoklama kağıdına imza at.',
                                style: styleBlack16Bold.copyWith(
                                  decorationColor: color5,
                                  color: color5,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Card(
                      color: colorLightGray2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.camera_alt_outlined,
                                size: 64, color: Colors.grey),
                            const SizedBox(height: 16),
                            Text(
                              'Yoklama almak için\nkamera izni gerekiyor.',
                              textAlign: TextAlign.center,
                              style: styleBlack18Bold,
                            ),
                            const SizedBox(height: 24),
                            SizedBox(
                              width: double.infinity,
                              child: PrimaryButton(
                                text: "Ayarları Aç ve İzin Ver",
                                onPress: _goToAppSettings,
                              ),
                            ),
                            const SizedBox(height: 12),
                            TextButton(
                              onPressed: () {},
                              child: Text(
                                'Kamera izni vermek istemiyorsan , yoklama kağıdına imza at.',
                                style: styleBlack14Bold.copyWith(
                                  color: color5,
                                  decoration: TextDecoration.underline,
                                  decorationColor: color5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

            // 🔥 Loading Overlay (Tüm sayfanın üstünde)
            if (isLoading)
              Container(
                color: Colors.black.withOpacity(0.4),
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white, // veya color5
                  ),
                ),
              ),
          ],
        ));
  }
}

class ScannerOverlayPainter extends CustomPainter {
  final double animationValue;

  ScannerOverlayPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final double overlayWidth = size.width * 0.7;
    final double overlayHeight = overlayWidth;

    final Offset center = Offset(size.width / 2, size.height / 2);

    final Rect scanRect = Rect.fromCenter(
      center: center,
      width: overlayWidth,
      height: overlayHeight,
    );

    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
        Path()..addRect(scanRect),
      ),
      paint,
    );

    final Paint linePaint = Paint()
      ..color = color5
      ..strokeWidth = 3;

    final double lineY = scanRect.top + (scanRect.height * animationValue);

    canvas.drawLine(
      Offset(scanRect.left, lineY),
      Offset(scanRect.right, lineY),
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant ScannerOverlayPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue;
  }
}
