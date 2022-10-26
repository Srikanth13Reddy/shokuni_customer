class AlreadyInQueueResponse {
  String? message;
  bool? status;
  AlreadyInQueueData? data;

  AlreadyInQueueResponse({this.message, this.status, this.data});

  AlreadyInQueueResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];

    data =
        json['data'] != null ? AlreadyInQueueData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AlreadyInQueueData {
  int? id;
  String? saloonId;
  String? barberId;
  String? state;

  AlreadyInQueueData({this.id, this.saloonId, this.barberId, this.state});

  AlreadyInQueueData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    saloonId = json['saloon_id'] ?? "";
    barberId = json['barber_id'] ?? "";
    state = json['state'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['saloon_id'] = saloonId;
    data['barber_id'] = barberId;
    data['state'] = state;
    return data;
  }
}
