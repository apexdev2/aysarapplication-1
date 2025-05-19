class UnReadNotifcation {
  int? count;

  UnReadNotifcation({this.count});

  UnReadNotifcation.fromJson(Map<String, dynamic> json) {
    count = json['count'];
  }
}
