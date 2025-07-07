import 'package:aysar_app/models/company_model.dart';

class PropertiesModel {
  int? id;
  String? uuid;
  String? floorNumber;
  String? image;
  String? name;
  CompanyModel? company;
  // String? price;
  String? type;
  dynamic completionpercentage;

  PropertiesModel({
    this.id,
    this.uuid,
    this.floorNumber,
    this.image,
    this.name,
    this.company,
    // this.price,
    this.completionpercentage,
    this.type,
  });

  PropertiesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    floorNumber = json['floor_number'];
    image = json['image'];
    name = json['name'];
    company =
        json['company'] != null ? CompanyModel.fromJson(json['company']) : null;
    // price = json['price'];
    type = json['type'];
    completionpercentage = json['completion_percentage'];

  }
}
