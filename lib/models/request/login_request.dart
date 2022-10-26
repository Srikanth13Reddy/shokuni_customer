class LoginRequest {
  String? username;
  String? password;
  String? role;
  String? deviceType;
  String? deviceToken;
  String? fcmToken;
  String? clientSecret;
  String? grantType;
  String? clientId;

  LoginRequest(
      {this.username,
      this.password,
      this.role,
      this.deviceType,
      this.deviceToken,
      this.fcmToken,
      this.clientSecret,
      this.grantType,
      this.clientId});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    role = json['role'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    fcmToken = json['fcm_token'];
    clientSecret = json['client_secret'];
    grantType = json['grant_type'];
    clientId = json['client_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    data['role'] = role;
    data['device_type'] = deviceType;
    data['device_token'] = deviceToken;
    data['fcm_token'] = fcmToken;
    data['client_secret'] = clientSecret;
    data['grant_type'] = grantType;
    data['client_id'] = clientId;
    return data;
  }
}
