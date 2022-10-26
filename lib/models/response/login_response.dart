class LoginResponse {
  LoginData? data;
  String? message;
  bool? status;

  LoginResponse({this.data, this.message, this.status});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? LoginData.fromJson(json['data']) : null;
    message = json['message'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    data['status'] = status;
    return data;
  }
}

class LoginData {
  String? tokenType;
  int? expiresIn;
  String? accessToken;
  String? refreshToken;
  Users? user;
  String? deviceToken;
  String? deviceType;
  String? fcmToken;

  LoginData(
      {this.tokenType,
      this.expiresIn,
      this.accessToken,
      this.refreshToken,
      this.user,
      this.deviceToken,
      this.deviceType,
      this.fcmToken});

  LoginData.fromJson(Map<String, dynamic> json) {
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    user = json['user'] != null ? Users.fromJson(json['user']) : null;
    deviceToken = json['device_token'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['device_token'] = deviceToken;
    data['device_type'] = deviceType;
    data['fcm_token'] = fcmToken;
    return data;
  }
}

class Users {
  int? id;
  String? firstName;
  String? lastName;
  String? number;
  String? email;
  String? role;
  String? name;
  String? imageUrl;
  String? saloonId;
  String? saloonName;

  Users(
      {this.id,
      this.firstName,
      this.lastName,
      this.number,
      this.email,
      this.role,
      this.name,
      this.imageUrl,
      this.saloonId,
      this.saloonName});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    number = json['number'];
    email = json['email'];
    role = json['role'];
    name = json['name'];
    imageUrl = json['image_url'];
    saloonId = json['saloon_id'];
    saloonName = json['saloon_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['number'] = number;
    data['email'] = email;
    data['role'] = role;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['saloon_id'] = saloonId;
    data['saloon_name'] = saloonName;
    return data;
  }
}
