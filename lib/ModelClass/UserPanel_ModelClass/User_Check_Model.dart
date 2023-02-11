class UserCheckModel {
  bool? success;
  Data? data;

  UserCheckModel({this.success, this.data});

  UserCheckModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? username;
  String? profileImage;
  int? paymentStatus;

  Data({this.userId, this.username, this.profileImage, this.paymentStatus});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    profileImage = json['profileImage'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.username;
    data['profileImage'] = this.profileImage;
    data['payment_status'] = this.paymentStatus;
    return data;
  }
}
