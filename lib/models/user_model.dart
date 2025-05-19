

class AuthModel {
  User? user;
  String? token;

  AuthModel({this.user, this.token});

  AuthModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ?  User.fromJson(json['user']) : null;
    token = json['token'];
  }

  
}

class User {
  int? id;
  String? name;
  String? email;
  String? mobile;
  String? mobileCountryCode;
  String? dialCode;
  String? image;

  User(
      {this.id,
      this.name,
      this.email,
      this.mobile,
      this.mobileCountryCode,
      this.dialCode,
      this.image});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    mobile = json['mobile'];
    mobileCountryCode = json['mobile_country_code'];
    dialCode = json['dial_code'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['mobile'] = mobile;
    data['mobile_country_code'] = mobileCountryCode;
    data['dial_code'] = dialCode;
    data['image'] = image;
    return data;
  }
}
