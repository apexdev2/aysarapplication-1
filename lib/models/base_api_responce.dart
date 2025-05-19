class BaseApiResponce {
  bool? status;
  String? message;
  // String? data;

  BaseApiResponce({
    this.status,
    this.message,
  });

  BaseApiResponce.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    // data = json['data'];
  }
}
