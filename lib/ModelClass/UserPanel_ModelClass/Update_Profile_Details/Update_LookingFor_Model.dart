class UpdateLookingForModel {
  UpdateLookingForModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  UpdateLookingForModel.fromJson(Map<String, dynamic> json) {
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
  Data({
    required this.heightFrom,
    required this.heightTo,
    required this.ageFrom,
    required this.ageTo,
    required this.annualIncome,
    required this.diet,
    required this.workType,
    required this.maritalStatus,
    required this.gotra,
    required this.caste,
    required this.quality,
  });
  late final int heightFrom;
  late final int heightTo;
  late final int ageFrom;
  late final int ageTo;
  late final int annualIncome;
  var diet;
  late final int workType;
  late final int maritalStatus;
  late final int gotra;
  late final int caste;
  var quality;

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
    final _data = <String, dynamic>{};
    _data['height_from'] = heightFrom;
    _data['height_to'] = heightTo;
    _data['age_from'] = ageFrom;
    _data['age_to'] = ageTo;
    _data['annual_income'] = annualIncome;
    _data['diet'] = diet;
    _data['work_type'] = workType;
    _data['marital_status'] = maritalStatus;
    _data['gotra'] = gotra;
    _data['caste'] = caste;
    _data['quality'] = quality;
    return _data;
  }
}
