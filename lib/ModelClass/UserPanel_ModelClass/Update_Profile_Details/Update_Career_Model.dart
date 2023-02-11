class UpdateCareerModel {
  UpdateCareerModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  UpdateCareerModel.fromJson(Map<String, dynamic> json) {
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
  Data(
      {required this.annualIncome,
      required this.profession,
      required this.qualification,
      required this.job,
      required this.education,
      required this.educationFields,
      required this.universityName});

  late final int profession;
  late final int annualIncome;
  late final int qualification;
  var job;
  late final int education;
  late final String educationFields;
  late final String universityName;

  Data.fromJson(Map<String, dynamic> json) {
    annualIncome = json['annual_income'];
    profession = json['profession'];
    qualification = json['qualification'];
    job = json['job'];
    education = json['education'];
    educationFields = json['education_fields'];
    universityName = json['university_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['profession'] = profession;
    _data['annual_income'] = annualIncome;
    _data['qualification'] = qualification;
    _data['job'] = job;  
    _data['education'] = this.education;
    _data['education_fields'] = educationFields;
    _data['university_name'] = universityName;
    return _data;
  }
}
