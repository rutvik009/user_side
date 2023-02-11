class GetFamilyDetailModel {
  bool? success;
  Data? data;

  GetFamilyDetailModel({this.success, this.data});

  GetFamilyDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? familyType;
 
  String? motherTounge;
  String? fatherOccupation;
  String? motherOccupation;
  String? familyIncome;
  String? noBrothers;
  String? marriedBrothers;
  String? noSisters;
  String? marriedSisters;
  String? familyBasedOut;

  Data(
      {this.familyType,
    
      this.motherTounge,
      this.fatherOccupation,
      this.motherOccupation,
      this.familyIncome,
      this.noBrothers,
      this.marriedBrothers,
      this.noSisters,
      this.marriedSisters,
      this.familyBasedOut});

  Data.fromJson(Map<String, dynamic> json) {
    familyType = json['family_type'];
  
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_type'] = this.familyType;
  
    data['mother_tounge'] = this.motherTounge;
    data['father_occupation'] = this.fatherOccupation;
    data['mother_occupation'] = this.motherOccupation;
    data['family_income'] = this.familyIncome;
    data['no_brothers'] = this.noBrothers;
    data['married_brothers'] = this.marriedBrothers;
    data['no_sisters'] = this.noSisters;
    data['married_sisters'] = this.marriedSisters;
    data['family_based_out'] = this.familyBasedOut;
    return data;
  }
}