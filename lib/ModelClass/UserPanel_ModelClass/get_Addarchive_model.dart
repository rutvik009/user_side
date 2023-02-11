class GetAddarchiveModel {
  bool? success;
  String? message;
  // Data? data;
  int? data;

  GetAddarchiveModel({this.success, this.message, this.data});

  GetAddarchiveModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ?json['data'] : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!;
    }
    return data;
  }
}

class Data {
  String? userId;
  int? activityTypeId;
  int? createdBy;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
      this.activityTypeId,
      this.createdBy,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    activityTypeId = json['activity_type_id'];
    createdBy = json['created_by'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['activity_type_id'] = this.activityTypeId;
    data['created_by'] = this.createdBy;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
