import 'package:aysar_app/models/company_model.dart';

class PropertiesDetailsModel {
  int? id;
  String? uuid;
  String? floorNumber;
  String? image;
  String? name;
  CompanyModel? company;
  // String? price;
  String? type;
  dynamic bedrooms;
  dynamic area;
  dynamic masterBedrooms;
  dynamic bathrooms;
  dynamic totalRooms;
  dynamic driverRooms;
  dynamic livingRooms;
  String? description;
  String? address;
  num? completionPercentage;
  List<Specifications>? specifications;
  List<PropertyImages>? propertyImages;

  PropertiesDetailsModel(
      {this.id,
      this.uuid,
      this.floorNumber,
      this.image,
      this.name,
      this.company,
      // this.price,
      this.type,
      this.bedrooms,
      this.area,
      this.masterBedrooms,
      this.bathrooms,
      this.totalRooms,
      this.driverRooms,
      this.livingRooms,
      this.description,
      this.address,
      this.completionPercentage,
      this.specifications,
      this.propertyImages});

  PropertiesDetailsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uuid = json['uuid'];
    floorNumber = json['floor_number'];
    image = json['image'];
    name = json['name'];
    company =
        json['company'] != null ? CompanyModel.fromJson(json['company']) : null;
    // price = json['price'];
    type = json['type'];
    bedrooms = json['bedrooms'];
    area = json['area'];
    masterBedrooms = json['master_bedrooms'];
    bathrooms = json['bathrooms'];
    totalRooms = json['total_rooms'];
    driverRooms = json['driver_rooms'];
    livingRooms = json['living_rooms'];
    description = json['description'];
    address = json['address'];
    completionPercentage = json['completion_percentage'];
    if (json['specifications'] != null) {
      specifications = <Specifications>[];
      json['specifications'].forEach((v) {
        specifications!.add( Specifications.fromJson(v));
      });
    }
    if (json['property_images'] != null) {
      propertyImages = <PropertyImages>[];
      json['property_images'].forEach((v) {
        propertyImages!.add( PropertyImages.fromJson(v));
      });
    }
  }
}

class Specifications {
  int? id;
  String? name;
  String? description;

  Specifications({this.id, this.name, this.description});

  Specifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
  }

}

class PropertyImages {
  int? id;
  String? url;

  PropertyImages({this.id, this.url});

  PropertyImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['url'] = url;
    return data;
  }
}
