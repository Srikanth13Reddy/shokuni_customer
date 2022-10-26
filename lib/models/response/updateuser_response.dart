class UpdateUserResponse {
  bool? status;
  String? message;
  List<String>? data;

  UpdateUserResponse({this.status, this.message, this.data});

  UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['data'] = data;
    return data;
  }
}
