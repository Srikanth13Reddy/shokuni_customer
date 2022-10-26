class UpdateUserRequest {
  String? firstName;
  String? lastName;
  String? number;
  String? email;

  UpdateUserRequest({this.firstName, this.lastName, this.number, this.email});

  UpdateUserRequest.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    number = json['number'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['number'] = number;
    data['email'] = email;
    return data;
  }
}
