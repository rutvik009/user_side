class MatchCandidateModel {
  bool? success;
  Data? data;

  MatchCandidateModel({this.success, this.data});

  MatchCandidateModel.fromJson(Map<String, dynamic> json) {
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
  String? kundli;
  String? habits;
  String? occupation;
  String? caste;

  Data({this.kundli, this.habits, this.occupation, this.caste});

  Data.fromJson(Map<String, dynamic> json) {
    kundli = json['kundli'];
    habits = json['habits'];
    occupation = json['occupation'];
    caste = json['caste'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kundli'] = this.kundli;
    data['habits'] = this.habits;
    data['occupation'] = this.occupation;
    data['caste'] = this.caste;
    return data;
  }
}
