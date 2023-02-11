class GetContactModel {
  bool? success;
  Data? data;

  GetContactModel({this.success, this.data});

  GetContactModel.fromJson(Map<String, dynamic> json) {
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
  String? mobile;
  String? altMobile;
  String? email;
  String? address;
  String? state;
  String? pincode;
  int? country;

  Data(
      {this.mobile,
      this.altMobile,
      this.email,
      this.address,
      this.state,
      this.pincode,
      this.country});

  Data.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    altMobile = json['alt_mobile'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['alt_mobile'] = this.altMobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    return data;
  }
}