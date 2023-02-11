class GetStarProfileModel {
  bool? success;
  List<Data>? data;

  GetStarProfileModel({this.success, this.data});

  GetStarProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? firstname;
  String? middlename;
  String? lastname;
  String? gender;
  List<ProfileImage>? profileImage;
  int? userId;
  int? blurImage;
  var age;
  String? maritalStatus;
  String? height;
  String? like;
  String? isAgent;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.gender,
      this.profileImage,
      this.userId,
      this.blurImage,
      this.age,
      this.maritalStatus,
      this.height,
      this.like,
      this.isAgent});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    gender = json['gender'];
    if (json['profileImage'] != null) {
      profileImage = <ProfileImage>[];
      json['profileImage'].forEach((v) {
        profileImage!.add(new ProfileImage.fromJson(v));
      });
    }
    userId = json['user_id'];
    blurImage = json['blur_image'];
    age = json['age'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    like = json['like'];
    isAgent = json['is_agent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    if (this.profileImage != null) {
      data['profileImage'] = this.profileImage!.map((v) => v.toJson()).toList();
    }
    data['user_id'] = this.userId;
    data['blur_image'] = this.blurImage;
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['like'] = this.like;
    data['is_agent'] = this.isAgent;
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
