import 'package:baykurs/util/YOColors.dart';
import 'package:baykurs/widgets/PrimaryButton.dart';
import 'package:flutter/material.dart';

class BkErrorWidget extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback? onPress;

  const BkErrorWidget({
    super.key,
    this.title = "Bir Hata Oluştu",
    this.description = "Şuanda İşlem Yapılamıyor.",
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, left: 16, right: 16),
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 2,
            ),
          ),
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: color5,
                size: 50,
              ),
              const SizedBox(height: 16),
              Text(title, style: styleBlack16Bold),
              const SizedBox(height: 8),
              Text(description, style: styleBlack14Regular,textAlign: TextAlign.center,),
              if (onPress != null) ...[
                const SizedBox(height: 16),
                PrimaryButton(
                  text: "Geri Dön",
                  onPress: onPress!,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
