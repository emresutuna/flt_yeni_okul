import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yeni_okul/util/HexColor.dart';
import 'package:yeni_okul/widgets/YOText.dart';

String? selectedValue;

final townList = [
  "Adalar",
  "Bağcılar",
  "Bahçelievler",
  "Bakırköy",
  "Beşiktaş",
  "Beykoz",
  "Beyoğlu",
  "Büyükçekmece",
  "Çatalca",
  "Eminönü",
  "Esenler",
  "Eyüp",
  "Fatih",
  "Gaziosmanpaşa",
  "Güngören",
  "Kadıköy",
  "Kağıthane",
  "Kartal",
  "Küçükçekmece",
  "Maltepe",
  "Pendik",
  "Sarıyer",
  "Silivri",
  "Şile",
  "Şişli",
  "Sultanbeyli",
  "Tuzla",
  "Ümraniye",
  "Üsküdar",
  "Zeytinburnu"
];

showCompanyFilterBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16),topRight: Radius.circular(16))
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 16),
                        height: 4,
                        width: 50,
                        decoration: BoxDecoration(color: HexColor("#DEDEDE")),
                      ),
                      const YoText(
                        text: "Filtrele",
                        size: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 0.75,
                        decoration: BoxDecoration(color: HexColor("#333333")),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 16,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: YoText(
                  text: "Konuma Göre Filtrele",
                  size: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButtonFormField2<String>(
                  isExpanded: true,
                  decoration: InputDecoration(filled: true,
                    fillColor: Colors.white,
                    // Add Horizontal padding using menuItemStyleData.padding so it matches
                    // the menu padding when button's width is not specified.
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: HexColor("#F0F1FA"), width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // Add more decoration..
                  ),
                  hint:  Text(
                    'İlçe Seç',
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                  items: townList
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select gender.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    //Do something when selected item is changed.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                  buttonStyleData: const ButtonStyleData(
                    padding: EdgeInsets.only(right: 8),
                  ),
                  iconStyleData: const IconStyleData(
                    icon: Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 24,
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  menuItemStyleData: const MenuItemStyleData(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0,left: 8,right: 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: HexColor("#1A1348"),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 18),
                        textStyle: GoogleFonts.montserrat(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const YoText(
                        text: "Tamam",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                ),
              )
            ],
          ),
        );
      });
}
