class PagesModel {
  String? type;
  String? title;
  String? icon;

  PagesModel({this.type, this.title, this.icon});

  PagesModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    title = json['title'];
    icon = json['icon'];
  }
}
