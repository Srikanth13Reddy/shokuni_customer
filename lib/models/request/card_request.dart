class CardRequest {
  String? cardNumber;
  String? cvv;
  String? expiryDate;
  String? nonce;

  CardRequest({this.cardNumber, this.cvv, this.expiryDate, this.nonce});

  CardRequest.fromJson(Map<String, dynamic> json) {
    cardNumber = json['card_number'];
    cvv = json['cvv'];
    expiryDate = json['expiry_date'];
    nonce = json['nonce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['card_number'] = cardNumber;
    data['cvv'] = cvv;
    data['expiry_date'] = expiryDate;
    data['nonce'] = nonce;
    return data;
  }
}
