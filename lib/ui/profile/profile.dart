import 'package:baykurs/ui/login/UnLoginPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../util/HexColor.dart';
import '../../util/SharedPrefHelper.dart';
import '../../util/YOColors.dart';
import '../../widgets/YOText.dart';
import '../dashboard/model/mobile_home_response.dart';
import '../webViewPage/WebViewPage.dart';
import 'bloc/ProfileBloc.dart';
import 'bloc/ProfileEvent.dart';
import 'bloc/ProfileState.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Notifications? notifications;
  ProfileSuccess? lastProfileState; // Store last successful profile state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      notifications = await getNotification();
    });

    context.read<ProfileBloc>().add(FetchUserProfile());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            clearSharedPreferences();
            refreshApp();
          } else if (state is LogoutError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }

          if (state is DeleteAccountSuccess) {
            clearSharedPreferences();
            refreshApp();
          } else if (state is DeleteAccountError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading && lastProfileState == null) {
              return profileShimmer();
            }

            if (state is ProfileSuccess) {
              lastProfileState = state; // Store last successful profile state
            }

            if (lastProfileState != null) {
              final userData = lastProfileState!.profileResponse.user;

              return SafeArea(
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 1.05,
                        width: MediaQuery.of(context).size.width,
                        color: color5,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16.0, top: 8, bottom: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Profil",
                                    style: styleWhite16Bold,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pushNamed("/notificationPage");
                                      },
                                      icon: Icon(
                                        (notifications != null &&
                                            (notifications?.count ?? 0) > 0)
                                            ? Icons.notifications_active
                                            : Icons.notifications,
                                        size: 22,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                        child: Text(
                                          "${userData?.name?.characters.first.capitalize ?? ""}${userData?.name?.characters.first.capitalize ?? ""}",
                                          style: styleBlack16Bold,
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userData?.name ?? "",
                                          style: styleWhite14Regular,
                                        ),
                                        Text(
                                          userData?.phone ?? "",
                                          style: styleWhite14Regular,
                                        ),
                                        Text(
                                          userData?.email ?? "",
                                          style: styleWhite14Regular,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context,
                                            rootNavigator: true)
                                            .pushNamed("/userEditSelection");
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        size: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 160,
                        left: 0,
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 1.2,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: Column(
                              children: [
                                profileItem("Satın Alma Geçmişi", onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/paymentHistoryPage");
                                }),
                                profileItem("Ders Programı", onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/timeSheetPage");
                                }),
                                profileItem("Kullanıcı Bilgileri", onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/userEditSelection");
                                }),
                                profileItem("Favorilerim", onTap: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamed("/favoriteSchool");
                                }),
                                profileItem("SSS", onTap: () {
                                  openWebView('https://www.bykurs.com.tr',
                                      'Sıkça Sorulan Sorular');
                                }),
                                profileItem("İletişim", onTap: () {
                                  openWebView(
                                      'https://www.bykurs.com.tr', 'İletişim');
                                }),
                                profileItem("Hesabımı Sil", onTap: () {
                                  showDeleteAccountDialog(context);
                                }),
                                profileItem(
                                  "Çıkış Yap",
                                  onTap: () {
                                    context
                                        .read<ProfileBloc>()
                                        .add(ProfileLogoutRequested());
                                  },
                                  color: color6,
                                  isLastItem: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is ProfileError) {
              return const UnLoginPage();
            }

            return const Center(); // Default state if nothing is available
          },
        ),
      ),
    );
  }
  void showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            "Hesabını Silmek İstiyor musun?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color5,
            ),
          ),
          content: Text(
              "Hesabını silerek Baykurs uygulaması içindeki bütün verilerin kaybolacaktır. Onaylıyor musun?",
              style: styleBlack14Regular.copyWith(color: Colors.black87)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                "Vazgeç",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.read<ProfileBloc>().add(DeleteAccount());

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: color5,
              ),
              child: Text(
                "Hesabımı Sil",
                style: styleBlack14Bold.copyWith(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget profileShimmer() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 1.2,
              width: MediaQuery.of(context).size.width,
              color: color5,
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16, bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100,
                        height: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 120,
                                  height: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 100,
                                  height: 14,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: 150,
                                  height: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 1.2,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children:
                    List.generate(8, (index) => profileItemSkeleton()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileItemSkeleton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget profileItem(String title,
      {Color color = const Color(0xFF222831),
        bool isLastItem = false,
        VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16.0,
          right: 16,
          top: 32,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: styleBlack14Bold.copyWith(color: color),
                ),
                isLastItem
                    ? const SizedBox.shrink()
                    : const Icon(Icons.chevron_right)
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            isLastItem
                ? const SizedBox.shrink()
                : Divider(
              height: 1,
              color: color.withAlpha(50),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileCircleWithTitle(
      String title, IconData icons, HexColor bgColor) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(top: 16),
              alignment: Alignment.center,
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: bgColor,
              ),
              child: Icon(icons)),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 16),
            child: YoText(
              text: title,
              fontWeight: FontWeight.w600,
              size: 12,
            ),
          ),
        ],
      );
}
