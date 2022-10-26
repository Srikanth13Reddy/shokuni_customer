class NotificationReadRequest {
  int? customerId;
  int? id;

  NotificationReadRequest({this.customerId, this.id});

  NotificationReadRequest.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    data['id'] = id;
    return data;
  }
}
