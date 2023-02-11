class UploadPanCardModel {
  bool? success;
  String? message;
  Data? data;

  UploadPanCardModel({this.success, this.message, this.data});

  UploadPanCardModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? userId;
  int? fileTypeId;
  String? fileName;
  String? filePath;
  int? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  Data(
      {this.userId,
      this.fileTypeId,
      this.fileName,
      this.filePath,
      this.status,
      this.updatedAt,
      this.createdAt,
      this.id});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fileTypeId = json['file_type_id'];
    fileName = json['file_name'];
    filePath = json['file_path'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['file_type_id'] = this.fileTypeId;
    data['file_name'] = this.fileName;
    data['file_path'] = this.filePath;
    data['status'] = this.status;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
