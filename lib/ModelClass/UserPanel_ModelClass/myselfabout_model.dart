class mySelfAboutModel {
  bool? success;
  MyselfData? data;

  mySelfAboutModel({this.success, this.data});

  mySelfAboutModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new MyselfData.fromJson(json['data']) : null;
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

class MyselfData {
  String? myselfoneline;
  String? myself;

  MyselfData({this.myselfoneline, this.myself});

  MyselfData.fromJson(Map<String, dynamic> json) {
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
