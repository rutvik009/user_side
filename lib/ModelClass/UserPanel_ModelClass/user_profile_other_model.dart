class UserOtherModel {
  bool? success;
  Data? data;

  UserOtherModel({this.success, this.data});

  UserOtherModel.fromJson(Map<String, dynamic> json) {
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
  int? marital_status;
  String? diet;
  String? height;
  String? weight;

  Data({this.marital_status, this.diet, this.height, this.weight});

  Data.fromJson(Map<String, dynamic> json) {
    marital_status = json['marital_status'];
    diet = json['diet'].toString();
    height = json['height'].toString(); 
    weight = json['weight'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['marital_status'] = this.marital_status;
    data['diet'] = this.diet;
    data['height'] = this.height;
    data['weight'] = this.weight;
    return data;
  }
}
