

class FAQsModel {
  int? id;
  String? title;
  String? content;

  FAQsModel({this.id, this.title, this.content});

  FAQsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
  }


}
