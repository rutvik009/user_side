class AnnualincomeModel {
  bool? success;
  List<AnnualData>? data;

  AnnualincomeModel({this.success, this.data});

  AnnualincomeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AnnualData>[];
      json['data'].forEach((v) {
        data!.add(new AnnualData.fromJson(v));
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

class AnnualData {
  int? id;
  String? incomes;

  AnnualData({this.id, this.incomes});

  AnnualData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    incomes = json['incomes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['incomes'] = this.incomes;
    return data;
  }
}
