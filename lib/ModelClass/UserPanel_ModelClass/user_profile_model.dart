class UserQualificationModel {
  bool? success;
  Data? data;

  UserQualificationModel({this.success, this.data});

  UserQualificationModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = Data.fromJson(json['data']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data;
    }
    return data;
  }
}

class Data {
  int? qualificationId;
  String? workTypeId;
  String? workPost;
  String? annualIncomeId;

  Data(
      {this.annualIncomeId,
      this.qualificationId,
      this.workPost,
      this.workTypeId});

  Data.fromJson(Map<String, dynamic> json) {
    qualificationId = json['qualification_id'];
    workTypeId = json['work_type_id'];
    workPost = json['work_post'];
    annualIncomeId = json['annual_income_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qualification_id'] = this.qualificationId;
    data['work_type_id'] = this.workTypeId;
    data['work_post'] = this.workPost;
    data['annual_income_id'] = this.annualIncomeId;
    return data;
  }
}
