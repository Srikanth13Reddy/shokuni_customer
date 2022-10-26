class ForgotPasswordRequest {
  String? email;
  String? hostname;

  ForgotPasswordRequest({this.email, this.hostname});

  ForgotPasswordRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    hostname = json['hostname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['hostname'] = hostname;
    return data;
  }
}
