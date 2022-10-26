class CustomerResponse {
  bool? status;
  String? message;
  CustomerDetail? data;

  CustomerResponse({this.status, this.message, this.data});

  CustomerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CustomerDetail.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CustomerDetail {
  int? id;
  String? firstName;
  String? lastName;
  String? number;
  bool? numberVerification;
  String? countryId;
  String? email;
  String? role;
  String? status;
  String? imageUrl;
  String? name;

  CustomerDetail(
      {this.id,
      this.firstName,
      this.lastName,
      this.number,
      this.numberVerification,
      this.countryId,
      this.email,
      this.role,
      this.status,
      this.imageUrl,
      this.name});

  CustomerDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    number = json['number'];
    numberVerification = json['number_verification'];
    countryId = json['country_id'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
    imageUrl = json['image_url'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['number'] = number;
    data['number_verification'] = numberVerification;
    data['country_id'] = countryId;
    data['email'] = email;
    data['role'] = role;
    data['status'] = status;
    data['image_url'] = imageUrl;
    data['name'] = name;
    return data;
  }
}
