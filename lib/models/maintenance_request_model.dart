import 'package:aysar_app/models/id_name_model.dart';
import 'package:aysar_app/models/properties_stages_model.dart';


class MaintenanceRequestModel {
  int? id;
  IdNameModel? property;
  IdNameModel? issue;
  String? issueDescription;
  Status? status;
  List<Attachments>? attachments;

  MaintenanceRequestModel(
      {this.id,
      this.property,
      this.issue,
      this.issueDescription,
      this.status,
      this.attachments});

  MaintenanceRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    property = json['property'] != null
        ? new IdNameModel.fromJson(json['property'])
        : null;
    issue = json['issue'] != null ? new IdNameModel.fromJson(json['issue']) : null;
    issueDescription = json['issue_description'];
    status =
        json['status'] != null ? new Status.fromJson(json['status']) : null;
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
  }

}

class Attachments {
  int? id;
  String? url;

  Attachments({this.id, this.url});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    return data;
  }
}
