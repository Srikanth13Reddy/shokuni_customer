class NotificationResponse {
  List<Notifications>? data;
  String? message;
  bool? status;

  NotificationResponse({this.data, this.message, this.status});

  NotificationResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Notifications>[];
      json['data'].forEach((v) {
        data!.add(Notifications.fromJson(v));
      });
    }
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class Notifications {
  int? id;
  String? title;
  String? message;
  bool? showTitle;
  int? dateTime;

  Notifications(
      {this.id, this.title, this.message, this.showTitle, this.dateTime});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    message = json['message'];
    showTitle = json['show_title'];
    dateTime = json['date_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['message'] = message;
    data['show_title'] = showTitle;
    data['date_time'] = dateTime;
    return data;
  }
}
