/* class AboutUsModel {
  bool? success;
  List<AboutUsData>? data;

  AboutUsModel({this.success, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <AboutUsData>[];
      json['data'].forEach((v) {
        data!.add(new AboutUsData.fromJson(v));
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

class AboutUsData {
  String? title;
  String? content;

  AboutUsData({this.title, this.content});

  AboutUsData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
} */

class AboutUsModel {
  bool? success;
  Data? data;

  AboutUsModel({this.success, this.data});

  AboutUsModel.fromJson(Map<String, dynamic> json) {
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
  List<AboutUs>? aboutUs;
  List<TermCondition>? termCondition;
  List<PrivacyPolicy>? privacyPolicy;

  Data({this.aboutUs, this.termCondition, this.privacyPolicy});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['about_us'] != null) {
      aboutUs = <AboutUs>[];
      json['about_us'].forEach((v) {
        aboutUs!.add(new AboutUs.fromJson(v));
      });
    }
    if (json['term_condition'] != null) {
      termCondition = <TermCondition>[];
      json['term_condition'].forEach((v) {
        termCondition!.add(new TermCondition.fromJson(v));
      });
    }
    if (json['privacy_policy'] != null) {
      privacyPolicy = <PrivacyPolicy>[];
      json['privacy_policy'].forEach((v) {
        privacyPolicy!.add(new PrivacyPolicy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.aboutUs != null) {
      data['about_us'] = this.aboutUs!.map((v) => v.toJson()).toList();
    }
    if (this.termCondition != null) {
      data['term_condition'] =
          this.termCondition!.map((v) => v.toJson()).toList();
    }
    if (this.privacyPolicy != null) {
      data['privacy_policy'] =
          this.privacyPolicy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AboutUs {
  String? title;
  String? content;

  AboutUs({this.title, this.content});

  AboutUs.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

class PrivacyPolicy {
  String? title;
  String? content;

  PrivacyPolicy({this.title, this.content});

  PrivacyPolicy.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}
class TermCondition {
  String? title;
  String? content;

  TermCondition({this.title, this.content});

  TermCondition.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['content'] = this.content;
    return data;
  }
}

