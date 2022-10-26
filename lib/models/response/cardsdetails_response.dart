class CardsDetailsResponse {
  String? message;
  bool? status;
  List<CardDetails>? data;

  CardsDetailsResponse({this.message, this.status, this.data});

  CardsDetailsResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    if (json['data'] != null) {
      data = <CardDetails>[];
      json['data'].forEach((v) {
        data!.add(CardDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CardDetails {
  String? cardNumber;
  String? expiry;
  String? cardCvv;
  String? name;

  CardDetails({this.cardNumber, this.expiry, this.cardCvv, this.name});

  CardDetails.fromJson(Map<String, dynamic> json) {
    cardNumber = json['card_number'];
    expiry = json['expiry'];
    cardCvv = json['card_cvv'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_number'] = cardNumber;
    data['expiry'] = expiry;
    data['card_cvv'] = cardCvv;
    data['name'] = name;
    return data;
  }
}
