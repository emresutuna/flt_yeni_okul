class DeleteAccountResponse {
  bool? status;
  List<dynamic>? data;
  String? message;

  DeleteAccountResponse({this.status, this.data, this.message});

  DeleteAccountResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] ?? [];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'data': data,
      'message': message,
    };
  }
}
