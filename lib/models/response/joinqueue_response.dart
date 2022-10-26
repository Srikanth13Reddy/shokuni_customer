class JoinQueueResponse {
  JoinQueueData? data;
  String? message;
  bool? status;

  JoinQueueResponse({this.data, this.message, this.status});

  JoinQueueResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? JoinQueueData.fromJson(json['data']) : null;
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

class JoinQueueData {
  String? saloonId;
  int? serviceTime;
  int? waitTime;
  int? priority;
  String? customerId;
  int? id;
  String? customerName;
  int? cutTime;
  String? customerImage;
  String? viewerName;
  String? viewerImage;
  bool? viewingSomeone;
  bool? attendingSomeone;
  bool? showtitle;
  String? customerWaitTimeStatus;
  bool? cutCompleted;
  List<CustomerCutType>? customerCutType;
  List<CustomerCutType>? customerCutExtras;
  int? currentBarber;
  int? waitingInMinuits;
  Shop? shop;
  Customers? customer;
  String? shopName;
  String? shopFlag;
  String? shopAddress;
  String? shopLat;
  String? shopLng;
  String? shopHeaderImage;
  String? shopLogo;
  List<CustomerCutType>? shopCutType;
  List<CustomerCutType>? shopCutExtras;
  String? shopContactNumber;
  String? shopPostalCode;
  String? shopDistance;

  JoinQueueData({
    this.saloonId,
    this.serviceTime,
    this.waitTime,
    this.priority,
    this.customerId,
    this.id,
    this.customerName,
    this.cutTime,
    this.customerImage,
    this.viewerName,
    this.viewerImage,
    this.viewingSomeone,
    this.attendingSomeone,
    this.showtitle,
    this.customerWaitTimeStatus,
    this.cutCompleted,
    this.customerCutType,
    this.customerCutExtras,
    this.currentBarber,
    this.waitingInMinuits,
    this.shop,
    this.customer,
    this.shopName,
    this.shopFlag,
    this.shopAddress,
    this.shopLat,
    this.shopLng,
    this.shopHeaderImage,
    this.shopLogo,
    this.shopCutType,
    this.shopCutExtras,
    this.shopContactNumber,
    this.shopPostalCode,
    this.shopDistance,
  });

  JoinQueueData.fromJson(Map<String, dynamic> json) {
    saloonId = json['saloon_id'];
    serviceTime = json['service_time'];
    waitTime = json['wait_time'];
    priority = json['priority'];
    customerId = json['customer_id'];
    id = json['id'];
    customerName = json['customer_name'];
    cutTime = json['cut_time'];
    customerImage = json['customer_image'];
    viewerName = json['viewer_name'];
    viewerImage = json['viewer_image'];
    viewingSomeone = json['viewing_someone'];
    attendingSomeone = json['attending_someone'];
    showtitle = json['showtitle'];
    customerWaitTimeStatus = json['customer_wait_time_status'];
    cutCompleted = json['cut_completed'];
    if (json['customer_cut_type'] != null) {
      customerCutType = <CustomerCutType>[];
      json['customer_cut_type'].forEach((v) {
        customerCutType!.add(CustomerCutType.fromJson(v));
      });
    }
    if (json['customer_cut_extras'] != null) {
      customerCutExtras = <CustomerCutType>[];
      json['customer_cut_extras'].forEach((v) {
        customerCutExtras!.add(CustomerCutType.fromJson(v));
      });
    }
    currentBarber = json['current_barber'];
    waitingInMinuits = json['waiting_in_minuits'];
    shop = json['shop'] != null ? Shop.fromJson(json['shop']) : null;
    customer =
        json['customer'] != null ? Customers.fromJson(json['customer']) : null;
    shopName = json['shop_name'];
    shopFlag = json['shop_flag'];
    shopAddress = json['shop_address'];
    shopLat = json['shop_lat'];
    shopLng = json['shop_lng'];
    shopHeaderImage = json['shop_header_image'];
    shopLogo = json['shop_logo'];
    if (json['shop_cut_type'] != null) {
      shopCutType = <CustomerCutType>[];
      json['shop_cut_type'].forEach((v) {
        shopCutType!.add(CustomerCutType.fromJson(v));
      });
    }
    if (json['shop_cut_extras'] != null) {
      shopCutExtras = <CustomerCutType>[];
      json['shop_cut_extras'].forEach((v) {
        shopCutExtras!.add(CustomerCutType.fromJson(v));
      });
    }
    shopContactNumber = json['shop_contact_number'];
    shopPostalCode = json['shop_postal_code'];
    shopDistance = json['shop_distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['saloon_id'] = saloonId;
    data['service_time'] = serviceTime;
    data['wait_time'] = waitTime;
    data['priority'] = priority;
    data['customer_id'] = customerId;
    data['id'] = id;
    data['customer_name'] = customerName;
    data['cut_time'] = cutTime;
    data['customer_image'] = customerImage;
    data['viewer_name'] = viewerName;
    data['viewer_image'] = viewerImage;
    data['viewing_someone'] = viewingSomeone;
    data['attending_someone'] = attendingSomeone;
    data['showtitle'] = showtitle;
    data['customer_wait_time_status'] = customerWaitTimeStatus;
    data['cut_completed'] = cutCompleted;
    if (customerCutType != null) {
      data['customer_cut_type'] =
          customerCutType!.map((v) => v.toJson()).toList();
    }
    if (customerCutExtras != null) {
      data['customer_cut_extras'] =
          customerCutExtras!.map((v) => v.toJson()).toList();
    }
    data['current_barber'] = currentBarber;
    data['waiting_in_minuits'] = waitingInMinuits;
    if (shop != null) {
      data['shop'] = shop!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['shop_name'] = shopName;
    data['shop_flag'] = shopFlag;
    data['shop_address'] = shopAddress;
    data['shop_lat'] = shopLat;
    data['shop_lng'] = shopLng;
    data['shop_header_image'] = shopHeaderImage;
    data['shop_logo'] = shopLogo;
    if (shopCutType != null) {
      data['shop_cut_type'] = shopCutType!.map((v) => v.toJson()).toList();
    }
    if (shopCutExtras != null) {
      data['shop_cut_extras'] = shopCutExtras!.map((v) => v.toJson()).toList();
    }
    data['shop_contact_number'] = shopContactNumber;
    data['shop_postal_code'] = shopPostalCode;
    data['shop_distance'] = shopDistance;
    return data;
  }
}

class CustomerCutType {
  int? id;
  String? name;
  String? serviceType;
  String? amount;
  String? time;

  CustomerCutType(
      {this.id, this.name, this.serviceType, this.amount, this.time});

  CustomerCutType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceType = json['service_type'];
    amount = json['amount'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['service_type'] = serviceType;
    data['amount'] = amount;
    data['time'] = time;
    return data;
  }
}

class Shop {
  int? id;
  String? name;
  String? standardPrice;
  String? shopFlag;
  String? address;
  String? postalCode;
  String? contactNumber;
  String? userId;
  String? countryId;
  String? lat;
  String? lng;
  String? status;
  String? createdAt;
  String? waitTime;
  String? headerImage;
  String? saloonLogo;
  List<CustomerCutType>? cutType;
  List<CustomerCutType>? cutExtras;

  Shop(
      {this.id,
      this.name,
      this.standardPrice,
      this.shopFlag,
      this.address,
      this.postalCode,
      this.contactNumber,
      this.userId,
      this.countryId,
      this.lat,
      this.lng,
      this.status,
      this.createdAt,
      this.waitTime,
      this.headerImage,
      this.saloonLogo,
      this.cutType,
      this.cutExtras});

  Shop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    standardPrice = json['standard_price'];
    shopFlag = json['shop_flag'];
    address = json['address'];
    postalCode = json['postal_code'];
    contactNumber = json['contact_number'];
    userId = json['user_id'];
    countryId = json['country_id'];
    lat = json['lat'];
    lng = json['lng'];
    status = json['status'];
    createdAt = json['created_at'];
    waitTime = json['wait_time'];
    headerImage = json['header_image'];
    saloonLogo = json['saloon_logo'];
    if (json['cut_type'] != null) {
      cutType = <CustomerCutType>[];
      json['cut_type'].forEach((v) {
        cutType!.add(CustomerCutType.fromJson(v));
      });
    }
    if (json['cut_extras'] != null) {
      cutExtras = <CustomerCutType>[];
      json['cut_extras'].forEach((v) {
        cutExtras!.add(CustomerCutType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['standard_price'] = standardPrice;
    data['shop_flag'] = shopFlag;
    data['address'] = address;
    data['postal_code'] = postalCode;
    data['contact_number'] = contactNumber;
    data['user_id'] = userId;
    data['country_id'] = countryId;
    data['lat'] = lat;
    data['lng'] = lng;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['wait_time'] = waitTime;
    data['header_image'] = headerImage;
    data['saloon_logo'] = saloonLogo;
    if (cutType != null) {
      data['cut_type'] = cutType!.map((v) => v.toJson()).toList();
    }
    if (cutExtras != null) {
      data['cut_extras'] = cutExtras!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  int? id;
  String? publicId;
  String? firstName;
  String? lastName;
  String? number;
  String? numberVerification;
  String? countryId;
  String? email;
  String? role;
  String? status;
  String? braintreeToken;
  String? deletedAt;
  int? createdAt;
  int? updatedAt;
  String? name;
  String? imageUrl;
  String? saloonId;
  String? saloonName;

  Customers(
      {this.id,
      this.publicId,
      this.firstName,
      this.lastName,
      this.number,
      this.numberVerification,
      this.countryId,
      this.email,
      this.role,
      this.status,
      this.braintreeToken,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.imageUrl,
      this.saloonId,
      this.saloonName});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    publicId = json['public_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    number = json['number'];
    numberVerification = json['number_verification'];
    countryId = json['country_id'];
    email = json['email'];
    role = json['role'];
    status = json['status'];
    braintreeToken = json['braintree_token'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    imageUrl = json['image_url'];
    saloonId = json['saloon_id'];
    saloonName = json['saloon_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['public_id'] = publicId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['number'] = number;
    data['number_verification'] = numberVerification;
    data['country_id'] = countryId;
    data['email'] = email;
    data['role'] = role;
    data['status'] = status;
    data['braintree_token'] = braintreeToken;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['name'] = name;
    data['image_url'] = imageUrl;
    data['saloon_id'] = saloonId;
    data['saloon_name'] = saloonName;
    return data;
  }
}
