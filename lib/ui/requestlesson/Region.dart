import 'package:flutter/material.dart';

class Region {
  final int id;
  final String name;

  Region({required this.id, required this.name});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
      id: json['id'],
      name: json['name'] ?? '',
    );
  }

  DropdownMenuItem<Region> toDropdownItem() {
    return DropdownMenuItem<Region>(
      value: this,
      child: Text(this.name),
    );
  }
}
class Province {
  final int id;
  final String name;

  Province({required this.id, required this.name});

  factory Province.fromJson(Map<String, dynamic> json) {
    return Province(
      id: json['city_id'],
      name: json['name'] ?? '',
    );
  }

  DropdownMenuItem<Province> toDropdownItem() {
    return DropdownMenuItem<Province>(
      value: this,
      child: Text(this.name),
    );
  }
}