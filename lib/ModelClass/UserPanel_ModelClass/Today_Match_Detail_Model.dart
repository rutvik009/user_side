/* class TodayMatchDetailModel {
  bool? success;
  List<Data>? data;

  TodayMatchDetailModel({this.success, this.data});

  TodayMatchDetailModel.fromJson(Map<String, dynamic> json) {
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
  var age;
  String? maritalStatus;
  String? height;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.gender,
      this.profileImage,
      this.userId,
      this.age,
      this.maritalStatus,
      this.height});

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
    age = json['age'];
    maritalStatus = json['marital_status'];
    height = json['height'];
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
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
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

class TodayMatchDetailModel {
  bool? success;
  List<Data>? data;

  TodayMatchDetailModel({this.success, this.data});

  TodayMatchDetailModel.fromJson(Map<String, dynamic> json) {
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
  String? isAgent;
  String? aboutMe;
  List<String>? hobbies;

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
      this.isAgent,
      this.aboutMe,
      this.hobbies
      });

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
    isAgent = json['is_agent'];
    aboutMe = json['about_me'];
    hobbies = json['hobbies'].cast<String>();
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
    data['is_agent'] = this.isAgent;
    data['about_me'] = this.aboutMe;
    data['hobbies'] = this.hobbies;
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
