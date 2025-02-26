import 'package:baykurs/ui/requestlesson/AllCities.dart';
import 'package:flutter/material.dart';



class SelectAllCitiesPage extends StatelessWidget {
  final List<AllCities> provinces;

  const SelectAllCitiesPage({required this.provinces, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("İlçe Seç")),
      body: ListView.separated(
        itemCount: provinces.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(provinces[index].name??"", style: const TextStyle(fontSize: 16)),
            onTap: () {
              Navigator.pop(context, provinces[index]);
            },
          );
        },
      ),
    );
  }
}