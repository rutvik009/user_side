class GetOtherDetailModel {
  bool? success;
  Data? data;

  GetOtherDetailModel({this.success, this.data});

  GetOtherDetailModel.fromJson(Map<String, dynamic> json) {
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
  int? height;
  var weight;
  int? maritalStatus;
  var diet;

  Data({this.height, this.weight, this.maritalStatus, this.diet});

  Data.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    weight = json['weight'];
    maritalStatus = json['marital_status'];
    diet = json['diet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['marital_status'] = this.maritalStatus;
    data['diet'] = this.diet;
    return data;
  }
}
