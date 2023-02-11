/* class GetHobbiesModel {
  bool? success;
  Data? data;

  GetHobbiesModel({this.success, this.data});

  GetHobbiesModel.fromJson(Map<String, dynamic> json) {
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
  List<Hobbies>? hobbies;

  Data({this.hobbies});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['hobbies'] != null) {
      hobbies = <Hobbies>[];
      json['hobbies'].forEach((v) {
        hobbies!.add(new Hobbies.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.hobbies != null) {
      data['hobbies'] = this.hobbies!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Hobbies {
  String? hobby;

  Hobbies({this.hobby, required String fromValue});

  Hobbies.fromJson(Map<String, dynamic> json) {
    hobby = json['hobby'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobby'] = this.hobby;
    return data;
  }
} */

class GetHobbiesModel {
  bool? success;
  Data? data;

  GetHobbiesModel({this.success, this.data});

  GetHobbiesModel.fromJson(Map<String, dynamic> json) {
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
  UserHobbies? userHobbies;

  Data({this.userHobbies});

  Data.fromJson(Map<String, dynamic> json) {
    userHobbies = json['userHobbies'] != null
        ? new UserHobbies.fromJson(json['userHobbies'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userHobbies != null) {
      data['userHobbies'] = this.userHobbies!.toJson();
    }
    return data;
  }
}

class UserHobbies {
  List<String>? hobbies;

  UserHobbies({this.hobbies});

  UserHobbies.fromJson(Map<String, dynamic> json) {
    hobbies = json['hobbies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobbies'] = this.hobbies;
    return data;
  }
}
