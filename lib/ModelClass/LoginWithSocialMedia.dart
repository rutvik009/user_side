class LoginWithSocialMediaModel {
  bool? success;
  String? token;

  LoginWithSocialMediaModel({this.success, this.token});

  LoginWithSocialMediaModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['token'] = this.token;
    return data;
  }
}
