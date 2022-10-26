class RegisterRequest {
  String? email;
  String? password;
  String? number;
  String? role;
  String? firstName;

  RegisterRequest(
      {this.email, this.password, this.number, this.role, this.firstName});

  RegisterRequest.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    number = json['number'];
    role = json['role'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['number'] = number;
    data['role'] = role;
    data['first_name'] = firstName;
    return data;
  }
}
