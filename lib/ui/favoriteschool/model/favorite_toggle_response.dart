class FavoriteToggleResponse {
  bool? status;
  String? message;
  bool? favstate;

  FavoriteToggleResponse({this.status, this.message, this.favstate});

  FavoriteToggleResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    favstate = json['favstate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['favstate'] = favstate;
    return data;
  }
}
