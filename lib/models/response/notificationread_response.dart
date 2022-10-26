class NotificationReadResponse {
  String? message;
  bool? status;

  NotificationReadResponse({this.message, this.status});

  NotificationReadResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}
