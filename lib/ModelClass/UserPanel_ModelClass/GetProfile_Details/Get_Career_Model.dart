class GetCareerModel {
  bool? success;
  Data? data;

  GetCareerModel({this.success, this.data});

  GetCareerModel.fromJson(Map<String, dynamic> json) {
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
  String? profession;
  int? annualIncome;
  int? qualification;
  String? educationFields;
  String? universityName;
  int? education;

  Data(
      {this.profession,
      this.annualIncome,
      this.qualification,
      this.educationFields,
      this.education,
      this.universityName});

  Data.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    annualIncome = json['annual_income'];
    qualification = json['qualification'];
    educationFields = json['education_fields'];
    universityName = json['university_name'];
    education = json['education'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profession'] = this.profession;
    data['annual_income'] = this.annualIncome;
    data['qualification'] = this.qualification;
    data['education_fields'] = this.educationFields;
    data['university_name'] = this.universityName;
    data['education'] = this.education;
    return data;
  }
}