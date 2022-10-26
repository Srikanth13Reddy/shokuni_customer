class NearByShopRequest {
  String? lat;
  String? lng;
  String? distance;

  NearByShopRequest({this.lat, this.lng, this.distance});

  NearByShopRequest.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
    distance = json['distance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    data['distance'] = distance;
    return data;
  }
}
