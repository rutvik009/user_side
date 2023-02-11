class PersonalDetails {
  bool? success;
  String? message;
  Data? data;

  PersonalDetails({this.success, this.message, this.data});

  PersonalDetails.fromJson(Map<String, dynamic> json) {
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
  String? createdBy;
  String? referBy;
  String? token;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.dob,
      this.gender,
      this.email,
      this.mobile,
      this.createdBy,
      this.referBy,
      this.token});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    createdBy = json['createdBy'];
    referBy = json['referBy'];
    token = json['token'];
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
    data['createdBy'] = this.createdBy;
    data['referBy'] = this.referBy;
    data['token'] = this.token;
    return data;
  }
}
