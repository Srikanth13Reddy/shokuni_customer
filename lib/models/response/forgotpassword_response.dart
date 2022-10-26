class ForgotPasswordResponse {
  bool? status;
  String? message;
  List<String>? data;

  ForgotPasswordResponse({this.status, this.message, this.data});

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = json['data'].cast<String>();
    }
  }
}
