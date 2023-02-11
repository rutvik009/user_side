/* class AllExecutiveCandidates_Model {
  bool? success;
  List<Data>? data;

  AllExecutiveCandidates_Model({this.success, this.data});

  AllExecutiveCandidates_Model.fromJson(Map<String, dynamic> json) {
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
  String? dob;
  String? gender;
  List<ProfileImage>? profileImage;
  var userId;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.dob,
      this.gender,
      this.profileImage,
      this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    dob = json['dob'];
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
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['dob'] = this.dob;
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
 */
class AllExecutiveCandidates_Model {
  bool? success;
  List<Data>? data;

  AllExecutiveCandidates_Model({this.success, this.data});

  AllExecutiveCandidates_Model.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  int? age;
  String? maritalStatus;
  String? height;
  String? caste;
  String? like;

  Data(
      {this.firstname,
      this.middlename,
      this.lastname,
      this.gender,
      this.profileImage,
      this.userId,
      this.age,
      this.maritalStatus,
      this.height,
      this.caste,
      this.like});

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
    caste = json['caste'];
    like = json['like'];
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
    data['caste'] = this.caste;
    data['like'] = this.like;
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
