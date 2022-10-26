class JoinQueueRequest {
  String? shopId;
  String? cutType;
  String? customerId;
  List<int>? cutExtras;
  String? customerName;
  String? details;

  JoinQueueRequest(
      {this.shopId,
      this.cutType,
      this.customerId,
      this.cutExtras,
      this.customerName,
      this.details});

  JoinQueueRequest.fromJson(Map<String, dynamic> json) {
    shopId = json['shop_id'];
    cutType = json['cut_type'];
    customerId = json['customer_id'];
    cutExtras = json['cut_extras'].cast<int>();
    customerName = json['customer_name'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shop_id'] = shopId;
    data['cut_type'] = cutType;
    data['customer_id'] = customerId;
    data['cut_extras'] = cutExtras;
    data['customer_name'] = customerName;
    data['details'] = details;
    return data;
  }
}
