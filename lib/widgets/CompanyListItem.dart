import 'package:flutter/material.dart';
import '../util/HexColor.dart';
import '../util/HexColor.dart';
import '../util/YOColors.dart';
import 'YOText.dart';
class CompanyListItem extends StatelessWidget {
  final String icon;
  final String name;
  final bool isFavorite;
  final String province;
  final String city;

  const CompanyListItem(
      {super.key,
      required this.icon,
      required this.name,
      required this.isFavorite,
      required this.province,
      required this.city});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xFFF6F6F6),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 0.5,
            color: HexColor("#80333333"),
          )),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150,
                decoration: const ShapeDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/company_logo2.png"),
                    fit: BoxFit.fill,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Icon(
                  Icons.favorite_outline,
                  color: color1,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: styleBlack14Bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: SizedBox(
              child: Text(
                "$province/$city",
                textAlign: TextAlign.center,
                style: styleGray12Bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
