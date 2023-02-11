class UserMatchDetailModel {
  bool? success;
  Data? data;

  UserMatchDetailModel({this.success, this.data});

  UserMatchDetailModel.fromJson(Map<String, dynamic> json) {
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
  Kundli? kundli;
  Kundli? foodHabits;
  Kundli? occupations;
  Kundli? caste;
  Kundli? gotra;

  Data(
      {this.kundli, this.foodHabits, this.occupations, this.caste, this.gotra});

  Data.fromJson(Map<String, dynamic> json) {
    kundli =
        json['kundli'] != null ? new Kundli.fromJson(json['kundli']) : null;
    foodHabits = json['food_habits'] != null
        ? new Kundli.fromJson(json['food_habits'])
        : null;
    occupations = json['occupations'] != null
        ? new Kundli.fromJson(json['occupations'])
        : null;
    caste = json['caste'] != null ? new Kundli.fromJson(json['caste']) : null;
    gotra = json['gotra'] != null ? new Kundli.fromJson(json['gotra']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.kundli != null) {
      data['kundli'] = this.kundli!.toJson();
    }
    if (this.foodHabits != null) {
      data['food_habits'] = this.foodHabits!.toJson();
    }
    if (this.occupations != null) {
      data['occupations'] = this.occupations!.toJson();
    }
    if (this.caste != null) {
      data['caste'] = this.caste!.toJson();
    }
    if (this.gotra != null) {
      data['gotra'] = this.gotra!.toJson();
    }
    return data;
  }
}

class Kundli {
  int? totalPercentage;
  List<String>? list;

  Kundli({this.totalPercentage, this.list});

  Kundli.fromJson(Map<String, dynamic> json) {
    totalPercentage = json['total_percentage'];
    list = json['list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_percentage'] = this.totalPercentage;
    data['list'] = this.list;
    return data;
  }
}
