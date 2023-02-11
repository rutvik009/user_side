class UpdateHobbiesModel {
  bool? success;
  Data? data;

  UpdateHobbiesModel({this.success, this.data});

  UpdateHobbiesModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? hobbies;

  Data({this.hobbies});

  Data.fromJson(Map<String, dynamic> json) {
    hobbies = json['hobbies'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobbies'] = this.hobbies;
    return data;
  }
}
