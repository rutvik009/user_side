
class GetExeProfileModel {
  bool? success;
  Data?   data;

  GetExeProfileModel({this.success, this.data});

  GetExeProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? firstname;
  String? middlename;
  String? lastname;
  String? dob;
  String? gender;
  String? email;
  String? mobile;
  var profession;
  var subprofession;
  var workWith;
  var distict;
  String? state;
  String? pincode;
  List<ProfileImage>? profileImage;
  List<CoverImage>? coverImage;
  int? userId;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.dob,
      this.gender,
      this.email,
      this.mobile,
      this.profession,
      this.subprofession,
      this.workWith,
      this.distict,
      this.state,
      this.pincode,
      this.profileImage,
      this.coverImage,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    profession = json['profession'];
    subprofession = json['subprofession'];
    workWith = json['work_with'];
    distict = json['distict'];
    state = json['state'];
    pincode = json['pincode'];
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
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profession'] = this.profession;
    data['subprofession'] = this.subprofession;
    data['work_with'] = this.workWith;
    data['distict'] = this.distict;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    if (this.profileImage != null) {
      data['profileImage'] = this.profileImage!.map((v) => v.toJson()).toList();
    }
    if (this.coverImage != null) {
      data['coverImage'] = this.coverImage!.map((v) => v.toJson()).toList();
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

/* class GetExeProfileModel {
  bool? success;
  Data? data;

  GetExeProfileModel({this.success, this.data});

  GetExeProfileModel.fromJson(Map<String, dynamic> json) {
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
  String? firstname;
  String? middlename;
  String? lastname;
  String? dob;
  String? gender;
  String? email;
  String? mobile;
  Null? profession;
  Null? subprofession;
  String? workWith;
  List<ProfileImage>? profileImage;
  int? userId;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.dob,
      this.gender,
      this.email,
      this.mobile,
      this.profession,
      this.subprofession,
      this.workWith,
      this.profileImage,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    dob = json['dob'];
    gender = json['gender'];
    email = json['email'];
    mobile = json['mobile'];
    profession = json['profession'];
    subprofession = json['subprofession'];
    workWith = json['work_with'];
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
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['profession'] = this.profession;
    data['subprofession'] = this.subprofession;
    data['work_with'] = this.workWith;
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
 */