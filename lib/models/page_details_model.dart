class PageDetailsModel {
  int? id;
  String? image;
  String? title;
  String? content;

  PageDetailsModel({this.id, this.image, this.title, this.content});

  PageDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    content = json['content'];
  }

  
}
