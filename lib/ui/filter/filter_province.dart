import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../service/api_urls.dart';
import '../../util/YOColors.dart';
import '../../widgets/WhiteAppBar.dart';
import '../requestlesson/region.dart';

class FilterProvince extends StatefulWidget {
  final int selectedCityId;
  final Province? initialSelectedProvince;
  const FilterProvince({
    super.key,
    required this.selectedCityId,
    this.initialSelectedProvince,
  });

  @override
  State<FilterProvince> createState() => _FilterProvinceState();
}

class _FilterProvinceState extends State<FilterProvince> {
  Province? selectedProvince;
  List<Province> provinces = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedProvince = widget.initialSelectedProvince;
    fetchProvince(widget.selectedCityId);
  }

  Future<void> fetchProvince(int cityId) async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.getAllDistricts(cityId)));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['status'] == true) {
          final List<dynamic> districtsData = responseData['data'];
          final List<Province> provinceList = districtsData.map((districtJson) {
            return Province.fromJson(districtJson);
          }).toList();

          setState(() {
            provinces = provinceList;
            isLoading = false;
          });
        } else {
          throw Exception('Invalid response data');
        }
      } else {
        throw Exception('Failed to load districts');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      rethrow;
    }
  }

  void selectProvince(Province province) {
    setState(() {
      selectedProvince = province;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: WhiteAppBar(
        "İlçe Seç",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: isLoading
          ?  Center(child: CircularProgressIndicator(color: color5,))
          : Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: provinces.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final province = provinces[index];
                return ListTile(
                  title: Text(province.name),
                  trailing: selectedProvince?.name == province.name
                      ? Icon(Icons.check, color: greenButton)
                      : null,
                  onTap: () {
                    selectProvince(province);
                  },
                );
              },
            ),
          ),
          _buildFilterButton(() {
            Navigator.of(context).pop(selectedProvince);
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
