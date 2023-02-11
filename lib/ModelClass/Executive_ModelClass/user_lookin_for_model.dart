class UserLookinForExeModel {
  bool? success;
  Data? data;

  UserLookinForExeModel({this.success, this.data});

  UserLookinForExeModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  LookingFor? lookingFor;

  Data({this.userId, this.lookingFor});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    lookingFor = json['lookingFor'] != null
        ? new LookingFor.fromJson(json['lookingFor'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    if (this.lookingFor != null) {
      data['lookingFor'] = this.lookingFor!.toJson();
    }
    return data;
  }
}

class LookingFor {
  String? heightFrom;
  String? heightTo;
  String? height;
  int? ageFrom;
  int? ageTo;
  String? age;
  String? annualIncome;
  String? dietType;
  String? workType;
  String? caste;
  String? gotra;
  String? maritalStatus;
  String? quality;

  LookingFor(
      {this.heightFrom,
      this.heightTo,
      this.height,
      this.ageFrom,
      this.ageTo,
      this.age,
      this.annualIncome,
      this.dietType,
      this.workType,
      this.caste,
      this.gotra,
      this.maritalStatus,
      this.quality});

  LookingFor.fromJson(Map<String, dynamic> json) {
    heightFrom = json['height_from'];
    heightTo = json['height_to'];
    height = json['height'];
    ageFrom = json['age_from'];
    ageTo = json['age_to'];
    age = json['age'];
    annualIncome = json['annual_income'];
    dietType = json['diet_type'];
    workType = json['work_type'];
    caste = json['caste'];
    gotra = json['gotra'];
    maritalStatus = json['marital_status'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height_from'] = this.heightFrom;
    data['height_to'] = this.heightTo;
    data['height'] = this.height;
    data['age_from'] = this.ageFrom;
    data['age_to'] = this.ageTo;
    data['age'] = this.age;
    data['annual_income'] = this.annualIncome;
    data['diet_type'] = this.dietType;
    data['work_type'] = this.workType;
    data['caste'] = this.caste;
    data['gotra'] = this.gotra;
    data['marital_status'] = this.maritalStatus;
    data['quality'] = this.quality;
    return data;
  }
}
