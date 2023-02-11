class GetBenefitsModel {
  bool? success;
  List<Data>? data;

  GetBenefitsModel({this.success, this.data});

  GetBenefitsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  List<Benefit>? benefit;
  List<Commonquestion>? commonquestion;

  Data({this.benefit, this.commonquestion});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['benefit'] != null) {
      benefit = <Benefit>[];
      json['benefit'].forEach((v) {
        benefit!.add(new Benefit.fromJson(v));
      });
    }
    if (json['commonquestion'] != null) {
      commonquestion = <Commonquestion>[];
      json['commonquestion'].forEach((v) {
        commonquestion!.add(new Commonquestion.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.benefit != null) {
      data['benefit'] = this.benefit!.map((v) => v.toJson()).toList();
    }
    if (this.commonquestion != null) {
      data['commonquestion'] =
          this.commonquestion!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Benefit {
  String? question;
  String? answer;

  Benefit({this.question, this.answer});

  Benefit.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
class Commonquestion {
  String? question;
  String? answer;

  Commonquestion({this.question, this.answer});

  Commonquestion.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['answer'] = this.answer;
    return data;
  }
}
