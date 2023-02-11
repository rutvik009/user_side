class DietModel {
  bool? success;
  List<DietData>? data;

  DietModel({this.success, this.data});

  DietModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DietData>[];
      json['data'].forEach((v) {
        data!.add(new DietData.fromJson(v));
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

class DietData {
  int? id;
  String? diet;

  DietData({this.id, this.diet});

  DietData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    diet = json['diet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['diet'] = this.diet;
    return data;
  }
}
