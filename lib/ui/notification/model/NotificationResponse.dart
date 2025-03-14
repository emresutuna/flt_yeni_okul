import 'package:intl/intl.dart';

class NotificationResponse {
  bool? status;
  List<NotificationModel>? data;

  NotificationResponse({
    this.status,
    this.data,
  });

  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      status: json['status'],
      data: json['data'] != null
          ? List<NotificationModel>.from(
        json['data'].map((item) => NotificationModel.fromJson(item)),
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data?.map((e) => e.toJson()).toList(),
    };
  }
}

class NotificationModel {
  int? id;
  String? title;
  String? description;
  int? userId;
  bool? isSeen;
  String? createdAt;
  String? updatedAt;

  NotificationModel({
    this.id,
    this.title,
    this.description,
    this.userId,
    this.isSeen,
    this.createdAt,
    this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      userId: json['user_id'],
      isSeen: json['is_seen'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'user_id': userId,
      'is_seen': isSeen,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  /// Formatlanmış tarih döndüren getter
  String get formattedDate {
    if (createdAt == null) return '';
    try {
      DateTime parsedDate = DateTime.parse(createdAt!);
      String time = DateFormat('HH:mm').format(parsedDate);
      String date = DateFormat('dd.MM.yyyy').format(parsedDate);
      return '$time - $date'; // örnek: 14:00 - 21.04.2025
    } catch (e) {
      return '';
    }
  }
}
