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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['desc'] = desc;
    data['clickable_part'] = clickablePart;
    data['route'] = route;
    return data;
  }
}
