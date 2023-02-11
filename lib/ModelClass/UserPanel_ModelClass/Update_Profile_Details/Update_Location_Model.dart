class UpdateCurrentLocationModel {
  UpdateCurrentLocationModel({
    required this.success,
    required this.data,
  });
  late final bool success;
  late final Data data;
  
  UpdateCurrentLocationModel.fromJson(Map<String, dynamic> json){
    success = json['success'];
    data = Data.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['success'] = success;
    _data['data'] = data.toJson();
    return _data;
  }
}

class Data {
  Data({
    required this.livingPlace,
    required this.city,
    required this.stateId,
    required this.countryId,
  });
  late final String livingPlace;
  late final int city;
  late final int stateId;
  late final int countryId;
  
  Data.fromJson(Map<String, dynamic> json){
    livingPlace = json['living_place'];
    city = json['city'];
    stateId = json['state_id'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['living_place'] = livingPlace;
    _data['city'] = city;
    _data['state_id'] = stateId;
    _data['country_id'] = countryId;
    return _data;
  }
}