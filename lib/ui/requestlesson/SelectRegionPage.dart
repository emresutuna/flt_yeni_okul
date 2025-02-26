import 'package:flutter/material.dart';

import '../../util/YOColors.dart';
import 'Region.dart';

class SelectRegionPage extends StatelessWidget {
  final List<Region> regions;

  const SelectRegionPage({required this.regions, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("İl Seç")),
      body: ListView.separated(
        itemCount: regions.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(regions[index].name, style: styleBlack14Bold),
            trailing: Icon(Icons.arrow_forward_ios, color: color5, size: 16),

            onTap: () {
              Navigator.pop(context, regions[index]);
            },
          );
        },
      ),
    );
  }
}
