class HeightModel {
  bool? success;
  List<HeightData>? data;

  HeightModel({this.success, this.data});

  HeightModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <HeightData>[];
      json['data'].forEach((v) {
        data!.add(new HeightData.fromJson(v));
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

class HeightData {
  int? id;
  String? height;

  HeightData({this.id, this.height});

  HeightData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['height'] = this.height;
    return data;
  }
}
