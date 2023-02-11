class UserAboutMeModel {
  bool? success;
  Data? data;

  UserAboutMeModel({this.success, this.data});

  UserAboutMeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? address;
  var religion;
  int? age;
  String? lookingFor;
  String? pincode;
  String? email;
  String? fullName;
  String? mobile;
  String? myselfoneline;
  String? myself;
  int? blurImage;
  List<ProfileImage>? profileImage;
  List<CoverImage>? coverImage;
  String? activeStatus;

  Data(
      {this.address,
      this.religion,
      this.age,
      this.blurImage,
      this.lookingFor,
      this.pincode,
      this.email,
      this.fullName,
      this.mobile,
      this.myselfoneline,
      this.myself,
      this.profileImage,
      this.activeStatus,
      this.coverImage});

  Data.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    religion = json['religion'];
    age = json['age'];
    blurImage = json['blur_image'];
    lookingFor = json['looking_for'];
    pincode = json['pincode'];
    email = json['email'];
    fullName = json['full_name'];
    mobile = json['mobile'];
    myselfoneline = json['myselfoneline'];
    myself = json['myself'];
    activeStatus = json['active_status'];
    if (json['profileImage'] != null) {
      profileImage = <ProfileImage>[];
      json['profileImage'].forEach((v) {
        profileImage!.add(new ProfileImage.fromJson(v));
      });
    }
    if (json['coverImage'] != null) {
      coverImage = <CoverImage>[];
      json['coverImage'].forEach((v) {
        coverImage!.add(new CoverImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['religion'] = this.religion;
    data['age'] = this.age;
    data['blur_image'] = this.blurImage;
    data['looking_for'] = this.lookingFor;
    data['pincode'] = this.pincode;
    data['email'] = this.email;
    data['full_name'] = this.fullName;
    data['mobile'] = this.mobile;
    data['myselfoneline'] = this.myselfoneline;
    data['myself'] = this.myself;
    data['active_status'] = this.activeStatus;
    if (this.profileImage != null) {
      data['profileImage'] = this.profileImage!.map((v) => v.toJson()).toList();
    }
    if (this.coverImage != null) {
      data['coverImage'] = this.coverImage!.map((v) => v.toJson()).toList();
    }
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

class CoverImage {
  String? filePath;

  CoverImage({this.filePath});

  CoverImage.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}
