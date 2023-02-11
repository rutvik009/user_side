class GetSearchDataModel {
  bool? success;
  List<Data>? data;

  GetSearchDataModel({this.success, this.data});

  GetSearchDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? username;
  String? place;
  String? state;
  String? gender;
  List<ProfileImage>? profileImage;
  int? userId;

  Data(
      {this.username,
      this.place,
      this.state,
      this.gender,
      this.profileImage,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    place = json['place'];
    state = json['state'];
    gender = json['gender'];
    if (json['profileImage'] != null) {
      profileImage = <ProfileImage>[];
      json['profileImage'].forEach((v) {
        profileImage!.add(new ProfileImage.fromJson(v));
      });
    }
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['place'] = this.place;
    data['state'] = this.state;
    data['gender'] = this.gender;
    if (this.profileImage != null) {
      data['profileImage'] = this.profileImage!.map((v) => v.toJson()).toList();
    }
    data['user_id'] = this.userId;
    return data;
  }
}

class ProfileImage {
  String? filePath;

  ProfileImage({this.filePath});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}
