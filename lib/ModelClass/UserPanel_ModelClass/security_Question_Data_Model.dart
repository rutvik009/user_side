class SecurityDataModel {
  bool? success;
  List<SecurityData>? data;

  SecurityDataModel({this.success, this.data});

  SecurityDataModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SecurityData>[];
      json['data'].forEach((v) {
        data!.add(new SecurityData.fromJson(v));
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

class SecurityData {
  int? id;
  String? question;

  SecurityData({this.id, this.question});

  SecurityData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['question'] = this.question;
    return data;
  }
}
