class updateMySelfAboutModel {
  bool? success;
  String? message;
  UpdateMyselfData? data;

  updateMySelfAboutModel({this.success, this.message, this.data});

  updateMySelfAboutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new UpdateMyselfData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UpdateMyselfData {
  String? myselfoneline;
  String? myself;

  UpdateMyselfData({this.myselfoneline, this.myself});

  UpdateMyselfData.fromJson(Map<String, dynamic> json) {
    myselfoneline = json['myselfoneline'];
    myself = json['myself'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myselfoneline'] = this.myselfoneline;
    data['myself'] = this.myself;
    return data;
  }
}
