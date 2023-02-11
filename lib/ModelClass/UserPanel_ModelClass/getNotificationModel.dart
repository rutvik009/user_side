class getNotificationModel {
  bool? success;
  Data? data;

  getNotificationModel({this.success, this.data});

  getNotificationModel.fromJson(Map<String, dynamic> json) {
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
  List<Week>? week;
  List<Year>? year;

  Data({this.week, this.year});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['week'] != null) {
      week = <Week>[];
      json['week'].forEach((v) {
        week!.add(new Week.fromJson(v));
      });
    }
    if (json['year'] != null) {
      year = <Year>[];
      json['year'].forEach((v) {
        year!.add(new Year.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.week != null) {
      data['week'] = this.week!.map((v) => v.toJson()).toList();
    }
    if (this.year != null) {
      data['year'] = this.year!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Year {
  String? notification;
  int? userId;
  int? notificationId;
  String? activeStatus;
  Image? image;
  String? read;

  Year(
      {this.notification,
      this.userId,
      this.notificationId,
      this.activeStatus,
      this.image,
      this.read});

  Year.fromJson(Map<String, dynamic> json) {
    notification = json['notification'];
    userId = json['user_id'];
    notificationId = json['notification_id'];
    activeStatus = json['active_status'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification'] = this.notification;
    data['user_id'] = this.userId;
    data['notification_id'] = this.notificationId;
    data['active_status'] = this.activeStatus;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['read'] = this.read;
    return data;
  }
}

class Week {
  String? notification;
  int? userId;
  int? notificationId;
  String? activeStatus;
  Image? image;
  String? read;

  Week(
      {this.notification,
      this.userId,
      this.notificationId,
      this.activeStatus,
      this.image,
      this.read});

  Week.fromJson(Map<String, dynamic> json) {
    notification = json['notification'];
    userId = json['user_id'];
    notificationId = json['notification_id'];
    activeStatus = json['active_status'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification'] = this.notification;
    data['user_id'] = this.userId;
    data['notification_id'] = this.notificationId;
    data['active_status'] = this.activeStatus;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['read'] = this.read;
    return data;
  }
}

class Image {
  String? filePath;

  Image({this.filePath});

  Image.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}



/* class getNotificationModel {
  bool? success;
  List<Data>? data;

  getNotificationModel({this.success, this.data});

  getNotificationModel.fromJson(Map<String, dynamic> json) {
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
  String? notification;
  int? userId;
  int? notificationId;
  Image? image;
  String? read;

  Data(
      {this.notification,
      this.userId,
      this.notificationId,
      this.image,
      this.read});

  Data.fromJson(Map<String, dynamic> json) {
    notification = json['notification'];
    userId = json['user_id'];
    notificationId = json['notification_id'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    read = json['read'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['notification'] = this.notification;
    data['user_id'] = this.userId;
    data['notification_id'] = this.notificationId;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['read'] = this.read;
    return data;
  }
}

class Image {
  String? filePath;

  Image({this.filePath});

  Image.fromJson(Map<String, dynamic> json) {
    filePath = json['file_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['file_path'] = this.filePath;
    return data;
  }
}
 */