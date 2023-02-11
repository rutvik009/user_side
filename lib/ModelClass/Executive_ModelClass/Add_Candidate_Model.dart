class AddCandidateModel {
  bool? success;
  Data? data;

  AddCandidateModel({this.success, this.data});

  AddCandidateModel.fromJson(Map<String, dynamic> json) {
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
  String? fullname;
  String? email;
  String? mobile;
  String? dob;
  String? gender;
  String? address;
  var pincode;
  int? maritalStatus;
  int? state;
  String? aboutMeLong;
  int? userId;

  Data(
      {this.fullname,
      this.email,
      this.mobile,
      this.dob,
      this.gender,
      this.address,
      this.pincode,
      this.maritalStatus,
      this.state,
      this.userId,
      this.aboutMeLong});

  Data.fromJson(Map<String, dynamic> json) {
    fullname = json['fullname'];
    email = json['email'];
    mobile = json['mobile'];
    dob = json['dob'];
    gender = json['gender'];
    address = json['address'];
    pincode = json['pincode'];
    maritalStatus = json['marital_status'];
    state = json['state'];
    aboutMeLong = json['about_me_long'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['address'] = this.address;
    data['pincode'] = this.pincode;
    data['marital_status'] = this.maritalStatus;
    data['state'] = this.state;
    data['about_me_long'] = this.aboutMeLong;
    data['user_id'] = this.userId;
    return data;
  }
}
