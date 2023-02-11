class getWorkTypeModel {
  bool? success;
  List<DataWorkType>? data;

  getWorkTypeModel({this.success, this.data});

  getWorkTypeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataWorkType>[];
      json['data'].forEach((v) {
        data!.add(new DataWorkType.fromJson(v));
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

class DataWorkType {
  int? id;
  String? name;

  DataWorkType({this.id, this.name});

  DataWorkType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}