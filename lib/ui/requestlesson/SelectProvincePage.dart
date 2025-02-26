import 'package:flutter/material.dart';
import '../../util/YOColors.dart';
import 'Region.dart';

class SelectProvincePage extends StatelessWidget {
  final List<Province> provinces;

  const SelectProvincePage({required this.provinces, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("İlçe Seç")),
      body: ListView.builder(
        itemCount: provinces.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(provinces[index].name, style: styleBlack14Bold),
            trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),
            onTap: () {
              Navigator.pop(context, provinces[index]);
            },
          );
        },
      ),
    );
  }
}
