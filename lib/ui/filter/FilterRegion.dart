import 'package:baykurs/widgets/WhiteAppBar.dart';
import 'package:flutter/material.dart';
import '../../service/apiUrls.dart';
import '../../util/YOColors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../requestlesson/Region.dart';

class FilterRegion extends StatefulWidget {
  final Region? initialSelectedCity;
  const FilterRegion({super.key, this.initialSelectedCity});

  @override
  State<FilterRegion> createState() => _FilterRegionState();
}

class _FilterRegionState extends State<FilterRegion> {
  Region? selectedCity;
  List<Region> regions = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedCity = widget.initialSelectedCity;
    fetchRegions();
  }

  Future<void> fetchRegions() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.getProvinceAllURL));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          final List<dynamic> regionsData = responseData['data'];
          final List<Region> regionList = regionsData.map((regionJson) {
            return Region.fromJson(regionJson);
          }).toList();

          setState(() {
            regions = regionList;
            isLoading = false; // Veri yüklendi
          });
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to load regions');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      rethrow;
    }
  }

  void selectCity(Region city) {
    setState(() {
      selectedCity = city;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar(
        "İl Seç",
        onTap: () {
          Navigator.pop(context, selectedCity);
        },
      ),
      body: isLoading
          ?  Center(child: CircularProgressIndicator(color: color5,))
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: regions.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final city = regions[index].name;
                return ListTile(
                  title: Text(city),
                  trailing: selectedCity?.name == city
                      ? Icon(Icons.check, color: greenButton)
                      : null,
                  onTap: () {
                    selectCity(regions[index]);
                  },
                );
              },
            ),
          ),
          _buildFilterButton(() {
            Navigator.of(context).pop(selectedCity);
          }),
        ],
      ),
    );
  }

  Widget _buildFilterButton(VoidCallback callback) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: callback,
        style: ElevatedButton.styleFrom(
          backgroundColor: color5,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              topRight: Radius.circular(8),
            ),
          ),
        ),
        child: Text(
          "Tamam",
          style: styleWhite14Bold,
        ),
      ),
    );
  }
}
