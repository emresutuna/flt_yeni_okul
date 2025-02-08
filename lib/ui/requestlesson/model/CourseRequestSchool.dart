import 'package:flutter/material.dart';

class CourseRequestSchool {
  final int id;
  final int userId;
  final String userName;

  CourseRequestSchool({required this.id, required this.userId, required this.userName});

  factory CourseRequestSchool.fromJson(Map<String, dynamic> json) {
    return CourseRequestSchool(
      id: json['id'],
      userId: json['user_id'],
      userName: json['user']['name'],
    );
  }
  DropdownMenuItem<CourseRequestSchool> toDropdownItem() {
    return DropdownMenuItem<CourseRequestSchool>(
      value: this,
      child: Text(this.userName),
    );
  }
}