class getWorkAsModel {
  bool? success;
  List<DataWorkAs>? data;

  getWorkAsModel({this.success, this.data});

  getWorkAsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <DataWorkAs>[];
      json['data'].forEach((v) {
        data!.add(new DataWorkAs.fromJson(v));
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

class DataWorkAs {
  int? id;
  String? name;

  DataWorkAs({this.id, this.name});

  DataWorkAs.fromJson(Map<String, dynamic> json) {
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