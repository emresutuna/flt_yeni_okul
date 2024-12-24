class NotificationResponse {
  bool? status;
  List<Notification>? data;

  NotificationResponse({this.status, this.data});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Notification>[];
      json['data'].forEach((v) {
        data!.add(Notification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notification {
  String? title;
  String? desc;
  String? dateTime;

  Notification({this.title, this.desc, this.dateTime});

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    desc = json['desc'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['desc'] = desc;
    data['dateTime'] = dateTime;
    return data;
  }
}
