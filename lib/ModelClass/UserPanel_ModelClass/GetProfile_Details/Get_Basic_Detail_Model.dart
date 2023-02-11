class GetBasicDetailModel {
  bool? success;
  Data? data;

  GetBasicDetailModel({this.success, this.data});

  GetBasicDetailModel.fromJson(Map<String, dynamic> json) {
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
   var religion;
  String? middlename;
  String? lastname;
  String? mobile;
  String? email;
  String? gender;
  String? createdBy;
  var address;
  var maritalStatus;
  var height;
  var weight;
  var age;
  var dob;
  var caste;
  var gotra;
  var skinTone;
  var allergicType;
  var manglikType;
  var beardType;
  var bodytype;
  var drinkType;
  var birthPlace;
  var birthTime;
  var nationality;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.mobile,
      this.email,
      this.gender,
        this.religion,
      this.createdBy,
      this.address,
      this.maritalStatus,
      this.height,
      this.weight,
      this.age,
      this.dob,
      this.caste,
      this.gotra,
      this.skinTone,
      this.allergicType,
      this.manglikType,
      this.beardType,
      this.bodytype,
      this.drinkType,
      this.birthPlace,
      this.nationality,
      this.birthTime});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
      religion = json['religion'];
    mobile = json['mobile'];
    email = json['email'];
    gender = json['gender'];
    createdBy = json['createdBy'];
    address = json['address'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    weight = json['weight'];
    age = json['age'];
    dob = json['dob'];
    caste = json['caste'];
    gotra = json['gotra'];
    bodytype = json['body_type'];
    skinTone = json['skin_tone'];
    allergicType = json['allergic_type'];
    manglikType = json['manglik_type'];
    beardType = json['beard_type'];
    drinkType = json['drink_type'];
    birthPlace = json['birth_place'];
    birthTime = json['birth_time'];
    nationality = json['nationality'];
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
    data['address'] = this.address;
      data['religion'] = this.religion;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['caste'] = this.caste;
    data['gotra'] = this.gotra;
    data['skin_tone'] = this.skinTone;
    data['allergic_type'] = this.allergicType;
    data['manglik_type'] = this.manglikType;

    data['body_type'] = this.bodytype;
    data['beard_type'] = this.beardType;
    data['drink_type'] = this.drinkType;
    data['birth_place'] = this.birthPlace;
    data['birth_time'] = this.birthTime;
    data['nationality'] = this.nationality;
    return data;
  }
}



/* class GetBasicDetailModel {
  bool? success;
  Data? data;

  GetBasicDetailModel({this.success, this.data});

  GetBasicDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? age;
  int? maritalStatus;
  int? height;
  int? weight;
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
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['birth_place'] = this.birthPlace;
    data['birth_time'] = this.birthTime;
    return data;
  }
} */