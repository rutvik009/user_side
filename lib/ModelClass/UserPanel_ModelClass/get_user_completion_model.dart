class GetProfileCompletionModel {
  bool? success;
  Data? data;

  GetProfileCompletionModel({this.success, this.data});

  GetProfileCompletionModel.fromJson(Map<String, dynamic> json) {
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
  String? profileCompletion;

  Data({this.profileCompletion});

  Data.fromJson(Map<String, dynamic> json) {
    profileCompletion = json['profile_completion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_completion'] = this.profileCompletion;
    return data;
  }
}
