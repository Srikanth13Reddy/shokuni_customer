class LeaveQueueResponse {
  String? message;
  bool? status;

  LeaveQueueResponse({this.message, this.status});

  LeaveQueueResponse.fromJson(Map<String, dynamic> json) {
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
