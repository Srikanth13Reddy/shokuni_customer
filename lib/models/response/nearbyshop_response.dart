class NearByShopResponse {
  String? message;
  bool? status;
  NearByShopData? data;

  NearByShopResponse({this.message, this.status, this.data});

  NearByShopResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? NearByShopData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class NearByShopData {
  List<Open>? open;
  List<Pending>? pending;
  List<Pending>? closed;
  List<Pending>? comingsoon;
  List<Promotionss>? promotion;

  NearByShopData({this.open, this.pending, this.closed, this.comingsoon});

  NearByShopData.fromJson(Map<String, dynamic> json) {
    if (json['open'] != null) {
      open = <Open>[];
      json['open'].forEach((v) {
        open!.add(Open.fromJson(v));
      });
    }
    if (json['pending'] != null) {
      pending = <Pending>[];
      json['pending'].forEach((v) {
        pending!.add(Pending.fromJson(v));
      });
    }
    if (json['closed'] != null) {
      closed = <Pending>[];
      json['closed'].forEach((v) {
        closed!.add(Pending.fromJson(v));
      });
    }
    if (json['comingsoon'] != null) {
      comingsoon = <Pending>[];
      json['comingsoon'].forEach((v) {
        comingsoon!.add(Pending.fromJson(v));
      });
    }
    if (json["permotions"] != null) {
      promotion = <Promotionss>[];
      json["permotions"].forEach((v) {
        promotion!.add(Promotionss.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (open != null) {
      data['open'] = open!.map((v) => v.toJson()).toList();
    }
    if (pending != null) {
      data['pending'] = pending!.map((v) => v.toJson()).toList();
    }
    if (closed != null) {
      data['closed'] = closed!.map((v) => v.toJson()).toList();
    }
    if (comingsoon != null) {
      data['comingsoon'] = comingsoon!.map((v) => v.toJson()).toList();
    }
    if (promotion != null) {
      data["permotions"] = promotion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Open {
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
  String? distance;
  int? priceRange;
  int? waitTime;
  String? headerImage;
  String? saloonLogo;
  List<CutType>? cutType;
  List<CutExtras>? cutExtras;

  Open(
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
      this.distance,
      this.priceRange,
      this.waitTime,
      this.headerImage,
      this.saloonLogo,
      this.cutType,
      this.cutExtras});

  Open.fromJson(Map<String, dynamic> json) {
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
    distance = json['distance'];
    priceRange = json['price_range'];
    waitTime = json['wait_time'];
    headerImage = json['header_image'];
    saloonLogo = json['saloon_logo'];
    if (json['cut_type'] != null) {
      cutType = <CutType>[];
      json['cut_type'].forEach((v) {
        cutType!.add(CutType.fromJson(v));
      });
    }
    if (json['cut_extras'] != null) {
      cutExtras = <CutExtras>[];
      json['cut_extras'].forEach((v) {
        cutExtras!.add(CutExtras.fromJson(v));
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
    data['distance'] = distance;
    data['price_range'] = priceRange;
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

class CutType {
  int? id;
  String? name;
  String? serviceType;
  String? amount;
  String? time;
  bool? isSelect = false;

  CutType(
      {this.id,
      this.name,
      this.serviceType,
      this.amount,
      this.time,
      this.isSelect});

  CutType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceType = json['service_type'];
    amount = json['amount'];
    time = json['time'];
    isSelect = json['isSelect'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['service_type'] = serviceType;
    data['amount'] = amount;
    data['time'] = time;
    data['isSelect'] = isSelect;
    return data;
  }
}

class CutExtras {
  int? id;
  String? name;
  String? serviceType;
  String? amount;
  String? time;
  bool? isSelect = false;
  CutExtras(
      {this.id,
      this.name,
      this.serviceType,
      this.amount,
      this.time,
      this.isSelect});

  CutExtras.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serviceType = json['service_type'];
    amount = json['amount'];
    time = json['time'];
    isSelect = json['isSelect'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['service_type'] = serviceType;
    data['amount'] = amount;
    data['time'] = time;
    data['isSelect'] = isSelect;
    return data;
  }
}

class Pending {
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
  String? distance;
  int? priceRange;
  int? waitTime;
  String? headerImage;
  String? saloonLogo;
  List<CutType>? cutType;
  List<CutExtras>? cutExtras;

  Pending(
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
      this.distance,
      this.priceRange,
      this.waitTime,
      this.headerImage,
      this.saloonLogo,
      this.cutType,
      this.cutExtras});

  Pending.fromJson(Map<String, dynamic> json) {
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
    distance = json['distance'];
    priceRange = json['price_range'];
    waitTime = json['wait_time'];
    headerImage = json['header_image'];
    saloonLogo = json['saloon_logo'];
    if (json['cut_type'] != null) {
      cutType = <CutType>[];
      json['cut_type'].forEach((v) {
        cutType!.add(CutType.fromJson(v));
      });
    }
    if (json['cut_extras'] != null) {
      cutExtras = <CutExtras>[];
      json['cut_extras'].forEach((v) {
        cutExtras!.add(CutExtras.fromJson(v));
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
    data['distance'] = distance;
    data['price_range'] = priceRange;
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

class Promotionss {
  int? id;
  String? title;
  String? image;
  String? content;
  String? shortDescription;
  String? createdAt;
  int? date;

  Promotionss(
      {this.id,
      this.title,
      this.image,
      this.content,
      this.shortDescription,
      this.createdAt,
      this.date});

  Promotionss.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    content = json['content'];
    shortDescription = json['short_description'];
    createdAt = json['created_at'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['content'] = content;
    data['short_description'] = shortDescription;
    data['created_at'] = createdAt;
    data['date'] = date;
    return data;
  }
}
