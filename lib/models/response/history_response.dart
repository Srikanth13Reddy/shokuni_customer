class HistoryResponse {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;
  int? totalSpend;
  int? serviceCount;
  bool? status;

  HistoryResponse(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total,
      this.totalSpend,
      this.serviceCount,
      this.status});

  HistoryResponse.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
    totalSpend = json['total_spend'];
    serviceCount = json['service_count'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    data['total_spend'] = totalSpend;
    data['service_count'] = serviceCount;
    data['status'] = status;
    return data;
  }
}

class Data {
  int? id;
  String? chairId;
  String? customerId;
  String? customerName;
  String? startTime;
  String? endTime;
  String? date;
  String? totalTime;
  String? state;
  String? viewedBy;
  AttendedBy? attendedBy;
  String? registeredBy;
  String? comment;
  String? transactionId;
  int? createdAt;
  String? deletedAt;
  String? saloonName;
  String? saloonLogo;
  String? headerImage;
  String? barberName;
  bool? bothServices;
  List<CustomerServices>? customerServices;
  bool? showTitle;
  Transaction? transaction;
  Customer? customer;

  Data(
      {this.id,
      this.chairId,
      this.customerId,
      this.customerName,
      this.startTime,
      this.endTime,
      this.date,
      this.totalTime,
      this.state,
      this.viewedBy,
      this.attendedBy,
      this.registeredBy,
      this.comment,
      this.transactionId,
      this.createdAt,
      this.deletedAt,
      this.saloonName,
      this.saloonLogo,
      this.headerImage,
      this.barberName,
      this.bothServices,
      this.customerServices,
      this.showTitle,
      this.transaction,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    chairId = json['chair_id'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    date = json['date'];
    totalTime = json['total_time'];
    state = json['state'];
    viewedBy = json['viewed_by'];
    attendedBy = json['attended_by'] != null
        ? AttendedBy.fromJson(json['attended_by'])
        : null;
    registeredBy = json['registered_by'];
    comment = json['comment'];
    transactionId = json['transaction_id'];
    createdAt = json['created_at'];
    deletedAt = json['deleted_at'];
    saloonName = json['saloon_name'];
    saloonLogo = json['saloon_logo'];
    headerImage = json['header_image'];
    barberName = json['barber_name'];
    bothServices = json['both_services'];
    if (json['customer_services'] != null) {
      customerServices = <CustomerServices>[];
      json['customer_services'].forEach((v) {
        customerServices!.add(CustomerServices.fromJson(v));
      });
    }
    showTitle = json['show_title'];
    transaction = json['transaction'] != null
        ? Transaction.fromJson(json['transaction'])
        : null;
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['chair_id'] = chairId;
    data['customer_id'] = customerId;
    data['customer_name'] = customerName;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['date'] = date;
    data['total_time'] = totalTime;
    data['state'] = state;
    data['viewed_by'] = viewedBy;
    if (attendedBy != null) {
      data['attended_by'] = attendedBy!.toJson();
    }
    data['registered_by'] = registeredBy;
    data['comment'] = comment;
    data['transaction_id'] = transactionId;
    data['created_at'] = createdAt;
    data['deleted_at'] = deletedAt;
    data['saloon_name'] = saloonName;
    data['saloon_logo'] = saloonLogo;
    data['header_image'] = headerImage;
    data['barber_name'] = barberName;
    data['both_services'] = bothServices;
    if (customerServices != null) {
      data['customer_services'] =
          customerServices!.map((v) => v.toJson()).toList();
    }
    data['show_title'] = showTitle;
    if (transaction != null) {
      data['transaction'] = transaction!.toJson();
    }
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class AttendedBy {
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

  AttendedBy(
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

  AttendedBy.fromJson(Map<String, dynamic> json) {
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

class CustomerServices {
  int? id;
  String? name;
  String? serviceType;
  String? amount;
  String? time;

  CustomerServices(
      {this.id, this.name, this.serviceType, this.amount, this.time});

  CustomerServices.fromJson(Map<String, dynamic> json) {
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

class Transaction {
  int? id;
  String? paymentMode;
  String? discount;
  String? totalAmount;
  String? finalAmount;
  String? discountType;
  String? createdAt;
  String? adminFee;

  Transaction(
      {this.id,
      this.paymentMode,
      this.discount,
      this.totalAmount,
      this.finalAmount,
      this.discountType,
      this.createdAt,
      this.adminFee});

  Transaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentMode = json['payment_mode'];
    discount = json['discount'];
    totalAmount = json['total_amount'];
    finalAmount = json['final_amount'];
    discountType = json['discount_type'];
    createdAt = json['created_at'];
    adminFee = json['admin_fee'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['payment_mode'] = paymentMode;
    data['discount'] = discount;
    data['total_amount'] = totalAmount;
    data['final_amount'] = finalAmount;
    data['discount_type'] = discountType;
    data['created_at'] = createdAt;
    data['admin_fee'] = adminFee;
    return data;
  }
}

class Customer {
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

  Customer(
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

  Customer.fromJson(Map<String, dynamic> json) {
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
