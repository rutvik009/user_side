class UserDataModel {
  bool? success;
  Userdata? data;

  UserDataModel({this.success, this.data});

  UserDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = Userdata.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data;
    return data;
  }
}

class Userdata {
  String? userId;
  String? userName;
  String? profileImage;

  Userdata({this.userId, this.profileImage, this.userName});

  Userdata.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'].toString();
    userName = json['username'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['username'] = this.userName;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
