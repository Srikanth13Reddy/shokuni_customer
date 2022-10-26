class ChangePasswordResponse {
  List<String>? errors;
  String? message;
  bool? status;

  ChangePasswordResponse({this.errors, this.message, this.status});

  ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['errors'] != null) {
      errors = <String>[];
      if (json['errors'] != []) {
        json['errors'].forEach((v) {
          errors!.add(v.toString());
        });
      }
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['errors'] = errors;
    return data;
  }
}
