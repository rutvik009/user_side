class AddExePersonalDetailModel {
  bool? success;
  String? message;
  Data? data;

  AddExePersonalDetailModel({this.success, this.message, this.data});

  AddExePersonalDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? dob;
  String? gender;
  String? email;
  String? mobile;
  int? profession;
  int? subprofession;
  String? workWith;
  var token;
  int? userId;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.dob,
      this.gender,
      this.email,
      this.mobile,
      this.profession,
      this.subprofession,
      this.workWith,
      this.token,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    profession = json['profession'];
    subprofession = json['subprofession'];
    workWith = json['work_with'];
    token = json['token'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profession'] = this.profession;
    data['subprofession'] = this.subprofession;
    data['work_with'] = this.workWith;
    data['token'] = this.token;
    data['user_id'] = this.userId;
    return data;
  }
}
