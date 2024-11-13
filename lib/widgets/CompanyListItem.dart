import 'package:cached_network_image/cached_network_image.dart';
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
  final VoidCallback onFavoriteClick;

  const CompanyListItem(
      {super.key,
      required this.icon,
      required this.name,
      required this.isFavorite,
      required this.province,
      required this.city,
      required this.onFavoriteClick});

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
                width: double.maxFinite,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                  ),
                ),
                child: CachedNetworkImage(
                  imageUrl: icon,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => Image.asset(
                    "assets/placeholder.png",
                    fit: BoxFit.fill,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    "assets/placeholder.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                right: 3,
                top: 3,
                child: InkWell(
                  onTap: onFavoriteClick,
                  child: Icon(
                    !isFavorite ? Icons.favorite_outline : Icons.favorite,
                    color: color5,
                  ),
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
