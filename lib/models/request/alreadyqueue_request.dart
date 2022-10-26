class AlreadyInQueueRequest {
  String? customerId;

  AlreadyInQueueRequest({this.customerId});

  AlreadyInQueueRequest.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['customer_id'] = customerId;
    return data;
  }
}
