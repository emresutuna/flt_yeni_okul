class SliderModel {
  int? id;
  String? title;
  String? desc;
  String? clickablePart;
  String? route;

  SliderModel({this.id, this.title, this.desc, this.clickablePart, this.route});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    desc = json['desc'];
    clickablePart = json['clickable_part'];
    route = json['route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['desc'] = this.desc;
    data['clickable_part'] = this.clickablePart;
    data['route'] = this.route;
    return data;
  }
}
