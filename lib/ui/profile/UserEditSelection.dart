import 'package:baykurs/ui/profile/model/UserEditSelectionItem.dart';
import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';

import '../../util/HexColor.dart';
import '../../util/YOColors.dart';

class UserEditSelection extends StatefulWidget {
  const UserEditSelection({super.key});

  @override
  State<UserEditSelection> createState() => _UserEditSelectionState();
}

class _UserEditSelectionState extends State<UserEditSelection> {
  @override
  Widget build(BuildContext context) {
    final List<UserEditSelectionItem> userEditSelectionItems = [
      UserEditSelectionItem(name: "Eğitim Bilgileri", route: "/profileInfo"),
      UserEditSelectionItem(name: "Email Değiştir", route: "/mailUpdate"),
      UserEditSelectionItem(name: "Şifre Değiştir", route: "/passwordUpdate"),
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar("Kullanıcı Bilgileri"),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(
                height: 24,
              ),
              Text(
                'Lorem ipsum dolar sit amet amet lorem ipsum dolar amet lorem ipsum amet dolar sit amet.',
                style: styleBlack12Regular,
              ),
              const SizedBox(
                height: 24,
              ),
              ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: userEditSelectionItems.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = userEditSelectionItems[index];
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, item.route);
                    },
                    child: userEditSelection(item),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userEditSelection(UserEditSelectionItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.5,
            color: HexColor("#393E46"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.name,
                style: styleBlack14Bold,
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
