class CompanyModel {
  int? id;
  String? image;
  String? name;
  String? companyName;
  String? email;
  bool? showmobile;
  String? mobile;
  String? url;
  String? description;

  CompanyModel(
      {this.id,
      this.image,
      this.name,
      this.companyName,
      this.email,
      this.mobile,
      this.showmobile,
      this.description,
      this.url});

  CompanyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    showmobile = json['show_mobile'];
    url = json['url'];
    description = json["description"];
    companyName = json['company_name'];
  }
}
