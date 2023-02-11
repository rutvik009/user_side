class UpdateBasicDetailModel {
  bool? success;
  Data? data;

  UpdateBasicDetailModel({this.success, this.data});

  UpdateBasicDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? firstname;
  String? middlename;
  String? lastname;
  String? mobile;
  String? email;
  String? gender;
  String? createdBy;
  String? adress;
  int? age;
  int? maritalStatus;
  int? height;
 var weight;
  String? dob;
  String? birthPlace;
  String? birthTime;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.mobile,
      this.email,
      this.gender,
      this.createdBy,
      this.adress,
      this.age,
      this.maritalStatus,
      this.height,
      this.weight,
      this.dob,
      this.birthPlace,
      this.birthTime});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    createdBy = json['createdBy'];
    adress = json['adress'];
    age = json['age'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    weight = json['weight'];
    dob = json['dob'];
    birthPlace = json['birth_place'];
    birthTime = json['birth_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['createdBy'] = this.createdBy;
    data['adress'] = this.adress;
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['birth_place'] = this.birthPlace;
    data['birth_time'] = this.birthTime;
    return data;
  }
}
