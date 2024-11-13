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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['favstate'] = this.favstate;
    return data;
  }
}
