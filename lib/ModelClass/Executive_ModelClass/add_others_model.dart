class AddOthersModel {
  AddOthersModel(
      {this.height, this.age, this.diet, this.maritalStatus, this.userId});

  int? height;
  int? age;
  int? diet;
  int? maritalStatus;
  int? userId;

  factory AddOthersModel.fromJson(Map<String, dynamic> json) => AddOthersModel(
      height: json["height"],
      age: json["weight"],
      diet: json["diet"],
      maritalStatus: json["marital_status"],
      userId: json["user_id"]);

  Map<String, dynamic> toJson() => {
        "height": height,
        "age": age,
        "diet": diet,
        "marital_status": maritalStatus,
        "user_id": userId
      };
}
