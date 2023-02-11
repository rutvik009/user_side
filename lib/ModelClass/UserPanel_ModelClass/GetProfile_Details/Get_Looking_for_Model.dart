class GetLookingForModel {
  bool? success;
  Data? data;

  GetLookingForModel({this.success, this.data});

  GetLookingForModel.fromJson(Map<String, dynamic> json) {
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
  String? heightFrom;
  String? heightTo;
  String? ageFrom;
  String? ageTo;
  int? annualIncome;
  int? diet;
  String? workType;
  String? maritalStatus;
  int? gotra;
  int? caste;
  int? quality;

  Data(
      {this.heightFrom,
      this.heightTo,
      this.ageFrom,
      this.ageTo,
      this.annualIncome,
      this.diet,
      this.workType,
      this.maritalStatus,
      this.gotra,
      this.quality,
      this.caste});

  Data.fromJson(Map<String, dynamic> json) {
    heightFrom = json['height_from'];
    heightTo = json['height_to'];
    ageFrom = json['age_from'];
    ageTo = json['age_to'];
    annualIncome = json['annual_income'];
    diet = json['diet'];
    workType = json['work_type'];
    maritalStatus = json['marital_status'];
    gotra = json['gotra'];
    caste = json['caste'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height_from'] = this.heightFrom;
    data['height_to'] = this.heightTo;
    data['age_from'] = this.ageFrom;
    data['age_to'] = this.ageTo;
    data['annual_income'] = this.annualIncome;
    data['diet'] = this.diet;
    data['work_type'] = this.workType;
    data['marital_status'] = this.maritalStatus;
    data['gotra'] = this.gotra;
    data['caste'] = this.caste;
    data['quality'] = this.quality;
    return data;
  }
}
