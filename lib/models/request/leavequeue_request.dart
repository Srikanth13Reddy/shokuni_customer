class LeaveQueueRequest {
  String? queueId;
  String? comment;

  LeaveQueueRequest({this.queueId, this.comment});

  LeaveQueueRequest.fromJson(Map<String, dynamic> json) {
    queueId = json['queue_id'];
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['queue_id'] = queueId;
    data['comment'] = comment;
    return data;
  }
}
