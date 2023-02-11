class AllCountUsersModel {
  bool? success;
  Data? data;

  AllCountUsersModel({this.success, this.data});

  AllCountUsersModel.fromJson(Map<String, dynamic> json) {
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
  int? getTodayMatchCount;
  int? getNearYouCount;
  int? getMyMatchCount;
  int? getDisLikedCount;
  int? getLikedCount;
  int? getArchiveCount;
  int? getRecentVisitedByYouCount;
  int? getRecentYouVisitedCount;
  int? getNewUsersCount;

  Data(
      {this.getTodayMatchCount,
      this.getNearYouCount,
      this.getMyMatchCount,
      this.getDisLikedCount,
      this.getLikedCount,
      this.getArchiveCount,
      this.getRecentVisitedByYouCount,
      this.getRecentYouVisitedCount,
      this.getNewUsersCount});

  Data.fromJson(Map<String, dynamic> json) {
    getTodayMatchCount = json['getTodayMatchCount'];
    getNearYouCount = json['getNearYouCount'];
    getMyMatchCount = json['getMyMatchCount'];
    getDisLikedCount = json['getDisLikedCount'];
    getLikedCount = json['getLikedCount'];
    getArchiveCount = json['getArchiveCount'];
    getRecentVisitedByYouCount = json['getRecentVisitedByYouCount'];
    getRecentYouVisitedCount = json['getRecentYouVisitedCount'];
    getNewUsersCount = json['getNewUsersCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['getTodayMatchCount'] = this.getTodayMatchCount;
    data['getNearYouCount'] = this.getNearYouCount;
    data['getMyMatchCount'] = this.getMyMatchCount;
    data['getDisLikedCount'] = this.getDisLikedCount;
    data['getLikedCount'] = this.getLikedCount;
    data['getArchiveCount'] = this.getArchiveCount;
    data['getRecentVisitedByYouCount'] = this.getRecentVisitedByYouCount;
    data['getRecentYouVisitedCount'] = this.getRecentYouVisitedCount;
    data['getNewUsersCount'] = this.getNewUsersCount;
    return data;
  }
}
