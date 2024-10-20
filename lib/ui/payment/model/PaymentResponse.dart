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
    data['status'] = this.status;
    data['message'] = this.message;
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
    data['student_id'] = this.studentId;
    data['course_id'] = this.courseId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}