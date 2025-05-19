class PropertiesStagesModel {
  int? id;
  String? name;
  String? rate;
  double? ratePercentage;
  Status? status;
  dynamic startDate;
  dynamic endDate;
  dynamic reason;
  dynamic delayReason;
  List<Images>? images;

  PropertiesStagesModel(
      {this.id,
      this.name,
      this.rate,
      this.ratePercentage,
      this.status,
      this.startDate,
      this.endDate,
      this.reason,
      this.delayReason,
      this.images});

  PropertiesStagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
    ratePercentage = json['rate_percentage'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    startDate = json['start_date'];
    endDate = json['end_date'];
    reason = json['reason'];
    delayReason = json['delay_reason'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
  }
}

class Images {
  int? id;
  String? url;

  Images({this.id, this.url});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }
}

class Status {
  String? key;
  String? name;
  String? color;

  Status({this.key, this.name, this.color});

  Status.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    name = json['name'];
    color = json['color'];
  }
}
