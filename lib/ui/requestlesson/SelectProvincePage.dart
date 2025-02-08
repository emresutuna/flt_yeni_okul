import 'package:flutter/material.dart';

import 'Region.dart';


class SelectProvincePage extends StatelessWidget {
  final List<Province> provinces;

  const SelectProvincePage({required this.provinces, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("İlçe Seç")),
      body: ListView.separated(
        itemCount: provinces.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(provinces[index].name, style: const TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context, provinces[index]);
            },
          );
        },
      ),
    );
  }
}
