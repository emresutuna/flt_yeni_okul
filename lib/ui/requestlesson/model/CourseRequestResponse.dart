class RequestCourseResponseModel {
  final bool status;
  final String message;

  RequestCourseResponseModel({
    required this.status,
    required this.message,
  });

  factory RequestCourseResponseModel.fromJson(Map<String, dynamic> json) {
    return RequestCourseResponseModel(
      status: json['status'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }
}