class GetLocationModel {
  bool? success;
  Data? data;

  GetLocationModel({this.success, this.data});

  GetLocationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? livingPlace;
  String? city;
  int? state;
  int? country;

  Data({this.livingPlace, this.city, this.state, this.country});

  Data.fromJson(Map<String, dynamic> json) {
    livingPlace = json['living_place'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['living_place'] = this.livingPlace;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}