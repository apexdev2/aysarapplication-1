

class NotifcationData {
  String? id;
  String? type;
  String? subType;
  int? typeId;
  String? title;
  String? content;
  String? createdAt;

  NotifcationData(
      {this.id,
      this.type,
      this.subType,
      this.typeId,
      this.title,
      this.content,
      this.createdAt});

  NotifcationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    subType = json['sub_type'];
    typeId = json['type_id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
  }
}
