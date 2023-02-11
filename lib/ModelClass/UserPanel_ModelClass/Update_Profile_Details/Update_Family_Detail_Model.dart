class UpdateFamilyDetailModel {
  UpdateFamilyDetailModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;

  UpdateFamilyDetailModel.fromJson(Map<String, dynamic> json) {
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
    required this.familyType,
    this.religion,
    required this.motherTounge,
    required this.fatherOccupation,
    required this.motherOccupation,
    required this.familyIncome,
    required this.noBrothers,
    required this.marriedBrothers,
    required this.noSisters,
    required this.marriedSisters,
    required this.familyBasedOut,
  });
  var familyType;
  int? religion;
  var motherTounge;
  late final int fatherOccupation;
  late final int motherOccupation;
  late final int familyIncome;
  late final String noBrothers;
  late final String marriedBrothers;
  late final String noSisters;
  late final String marriedSisters;
  late final String familyBasedOut;

  Data.fromJson(Map<String, dynamic> json) {
    familyType = json['family_type'];
    religion = json['religion'];
    motherTounge = json['mother_tounge'];
    fatherOccupation = json['father_occupation'];
    motherOccupation = json['mother_occupation'];
    familyIncome = json['family_income'];
    noBrothers = json['no_brothers'];
    marriedBrothers = json['married_brothers'];
    noSisters = json['no_sisters'];
    marriedSisters = json['married_sisters'];
    familyBasedOut = json['family_based_out'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['family_type'] = familyType;
    _data['religion'] = religion;
    _data['mother_tounge'] = motherTounge;
    _data['father_occupation'] = fatherOccupation;
    _data['mother_occupation'] = motherOccupation;
    _data['family_income'] = familyIncome;
    _data['no_brothers'] = noBrothers;
    _data['married_brothers'] = marriedBrothers;
    _data['no_sisters'] = noSisters;
    _data['married_sisters'] = marriedSisters;
    _data['family_based_out'] = familyBasedOut;
    return _data;
  }
}
