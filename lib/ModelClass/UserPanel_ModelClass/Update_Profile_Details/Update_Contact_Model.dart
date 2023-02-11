class UpdateContactModel {
  UpdateContactModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;
  
  UpdateContactModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.mobile,
    required this.altMobile,
    required this.email,
    required this.address,
    required this.state,
    required this.pincode,
    required this.country,
  });
  late final String mobile;
  late final String altMobile;
  late final String email;
  late final String address;
  late final int state;
  late final String pincode;
  late final int country;
  
  Data.fromJson(Map<String, dynamic> json){
    mobile = json['mobile'];
    altMobile = json['alt_mobile'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['mobile'] = mobile;
    _data['alt_mobile'] = altMobile;
    _data['email'] = email;
    _data['address'] = address;
    _data['state'] = state;
    _data['pincode'] = pincode;
    _data['country'] = country;
    return _data;
  }
}