class AddManagementModel {
  bool? success;
  Data? data;

  AddManagementModel({this.success, this.data});

  AddManagementModel.fromJson(Map<String, dynamic> json) {
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
  var userId;
  int? budget;
  String? details;
  String? visitCount;
  String? spacialNotes;
  String? followupDate;

  Data(
      {this.userId,
      this.budget,
      this.details,
      this.visitCount,
      this.spacialNotes,
      this.followupDate});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    budget = json['budget'];
    details = json['details'];
    visitCount = json['visit_count'];
    spacialNotes = json['spacial_notes'];
    followupDate = json['followup_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['budget'] = this.budget;
    data['details'] = this.details;
    data['visit_count'] = this.visitCount;
    data['spacial_notes'] = this.spacialNotes;
    data['followup_date'] = this.followupDate;
    return data;
  }
}
