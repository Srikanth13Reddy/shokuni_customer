class CardResponse {
  String? message;
  bool? status;
  Cards? card;

  CardResponse({this.message, this.status, this.card});

  CardResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    card = json['card'] != null ? Cards.fromJson(json['card']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    data['status'] = status;
    if (card != null) {
      data['card'] = card!.toJson();
    }
    return data;
  }
}

class Cards {
  String? nonce;
  int? userId;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? expiryDate;
  String? cardNo;
  String? cardCvv;

  Cards(
      {this.nonce,
      this.userId,
      this.updatedAt,
      this.createdAt,
      this.id,
      this.expiryDate,
      this.cardNo,
      this.cardCvv});

  Cards.fromJson(Map<String, dynamic> json) {
    nonce = json['nonce'];
    userId = json['user_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    expiryDate = json['expiry_date'];
    cardNo = json['card_no'];
    cardCvv = json['card_cvv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nonce'] = nonce;
    data['user_id'] = userId;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    data['expiry_date'] = expiryDate;
    data['card_no'] = cardNo;
    data['card_cvv'] = cardCvv;
    return data;
  }
}
