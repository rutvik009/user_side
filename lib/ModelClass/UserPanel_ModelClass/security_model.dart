class SecurityQModel {
  bool? success;
  List<SecurityQData>? data;

  SecurityQModel({this.success, this.data});

  SecurityQModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SecurityQData>[];
      json['data'].forEach((v) {
        data!.add(new SecurityQData.fromJson(v));
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

class SecurityQData {
  int? id;
  String? question;

  SecurityQData({this.id, this.question});

  SecurityQData.fromJson(Map<String, dynamic> json) {
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
