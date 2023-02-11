class GetUserImageModel {
  bool? success;
  Data? data;

  GetUserImageModel({this.success, this.data});

  GetUserImageModel.fromJson(Map<String, dynamic> json) {
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
  List<ProfileImage>? profileImage;
  List<CoverImage>? coverImage;

  Data({this.profileImage, this.coverImage});

  Data.fromJson(Map<String, dynamic> json) {
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
  int? imageId;
  String? image;
  int? status;

  ProfileImage({this.imageId, this.image, this.status});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class CoverImage {
  int? imageId;
  String? image;
  int? status;

  CoverImage({this.imageId,this.image, this.status});

  CoverImage.fromJson(Map<String, dynamic> json) {
    imageId = json['image_id'];
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_id'] = this.imageId;
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}


/* class GetUserImageModel {
  bool? success;
  Data? data;

  GetUserImageModel({this.success, this.data});

  GetUserImageModel.fromJson(Map<String, dynamic> json) {
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
  List<ProfileImage>? profileImage;
  List<CoverImage>? coverImage;

  Data({this.profileImage, this.coverImage});

  Data.fromJson(Map<String, dynamic> json) {
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
  String? image;
  int? status;

  ProfileImage({this.image, this.status});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}

class CoverImage {
  String? image;
  int? status;

  CoverImage({this.image, this.status});

  CoverImage.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['status'] = this.status;
    return data;
  }
}
 */