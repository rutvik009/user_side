class UpdateExeQualificationModel {
  bool? success;
  Data? data;

  UpdateExeQualificationModel({this.success, this.data});

  UpdateExeQualificationModel.fromJson(Map<String, dynamic> json) {
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
  int? qualification;
  int? workType;
  int? workPost;
  int? annualIncome;

  Data({this.qualification, this.workType, this.workPost, this.annualIncome});

  Data.fromJson(Map<String, dynamic> json) {
    qualification = json['qualification'];
    workType = json['work_type'];
    workPost = json['work_post'];
    annualIncome = json['annual_income'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qualification'] = this.qualification;
    data['work_type'] = this.workType;
    data['work_post'] = this.workPost;
    data['annual_income'] = this.annualIncome;
    return data;
  }
}
