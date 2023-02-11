/* class UpdateAboutMeModel {
  bool? success;
  String? message;
  Datum? data;

  UpdateAboutMeModel({this.success, this.message, this.data});

  UpdateAboutMeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Datum.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Datum {
  String? myselfoneline;
  String? myself;

  Datum({this.myselfoneline, this.myself});

  Datum.fromJson(Map<String, dynamic> json) {
    myselfoneline = json['myselfoneline'];
    myself = json['myself'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['myselfoneline'] = this.myselfoneline;
    data['myself'] = this.myself;
    return data;
  }
} */
class UpdateAboutMeModel {
  UpdateAboutMeModel({
    required this.success,
    required this.message,
    required this.data,
  });
  late final bool success;
  late final String message;
  late final Datum data;

  UpdateAboutMeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = Datum.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['message'] = message;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Datum {
  Datum({
    required this.myselfoneline,
    required this.myself,
  });
  late final String myselfoneline;
  late final String myself;

  Datum.fromJson(Map<String, dynamic> json) {
    myselfoneline = json['myselfoneline'];
    myself = json['myself'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['myselfoneline'] = myselfoneline;
    _data['myself'] = myself;
    return _data;
  }
}
