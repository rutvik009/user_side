class RegisterWithSocialMediaModel {
  bool? success;
  String? message;
  Data? data;

  RegisterWithSocialMediaModel({this.success, this.message, this.data});

  RegisterWithSocialMediaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? firstname;
  String? middlename;
  String? lastname;
  String? email;
  int? mobile;
  String? provider;
  String? uid;
  int? userId;
  String? token;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.email,
      this.mobile,
      this.provider,
      this.uid,
      this.userId,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    email = json['email'];
    mobile = json['mobile'];
    provider = json['provider'];
    uid = json['uid'];
    userId = json['user_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['provider'] = this.provider;
    data['uid'] = this.uid;
    data['user_id'] = this.userId;
    data['token'] = this.token;
    return data;
  }
}
