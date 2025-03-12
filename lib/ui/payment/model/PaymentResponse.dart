class PaymentResponse {
  bool? status;
  String? message;
  Payment? data;

  PaymentResponse({this.status, this.message, this.data});

  PaymentResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Payment.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Payment {
  int? studentId;
  int? courseId;
  String? updatedAt;
  String? createdAt;
  int? id;

  Payment(
      {this.studentId, this.courseId, this.updatedAt, this.createdAt, this.id});

  Payment.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    courseId = json['course_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['course_id'] = courseId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}