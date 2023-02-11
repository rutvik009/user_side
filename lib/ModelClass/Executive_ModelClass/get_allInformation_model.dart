class AllInformationModel {
  bool? success;
  Data? data;

  AllInformationModel({this.success, this.data});

  AllInformationModel.fromJson(Map<String, dynamic> json) {
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
  BasicInfo? basicInfo;
  LookingFor? lookingFor;
  UserContact? userContact;
  UserCareer? userCareer;
  UserFamily? userFamily;
  UserLocation? userLocation;

  Data(
      {this.basicInfo,
      this.lookingFor,
      this.userContact,
      this.userCareer,
      this.userFamily,
      this.userLocation});

  Data.fromJson(Map<String, dynamic> json) {
    basicInfo = json['basicInfo'] != null
        ? new BasicInfo.fromJson(json['basicInfo'])
        : null;
    lookingFor = json['lookingFor'] != null
        ? new LookingFor.fromJson(json['lookingFor'])
        : null;
    userContact = json['userContact'] != null
        ? new UserContact.fromJson(json['userContact'])
        : null;
    userCareer = json['userCareer'] != null
        ? new UserCareer.fromJson(json['userCareer'])
        : null;
    userFamily = json['userFamily'] != null
        ? new UserFamily.fromJson(json['userFamily'])
        : null;
    userLocation = json['userLocation'] != null
        ? new UserLocation.fromJson(json['userLocation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basicInfo != null) {
      data['basicInfo'] = this.basicInfo!.toJson();
    }
    if (this.lookingFor != null) {
      data['lookingFor'] = this.lookingFor!.toJson();
    }
    if (this.userContact != null) {
      data['userContact'] = this.userContact!.toJson();
    }
    if (this.userCareer != null) {
      data['userCareer'] = this.userCareer!.toJson();
    }
    if (this.userFamily != null) {
      data['userFamily'] = this.userFamily!.toJson();
    }
    if (this.userLocation != null) {
      data['userLocation'] = this.userLocation!.toJson();
    }
    return data;
  }
}

class BasicInfo {
  String? name;
  String? firstname;
  String? middlename;
  String? lastname;
  String? gender;
  String? createdBy;
  String? email;
  String? mobile;
  String? code;
  String? image;
  var age;
  String? maritalStatus;
  String? height;
  var weight;
  String? dob;
  String? birthPlace;
  String? religion;
  String? birthTime;

  BasicInfo(
      {this.name,
      this.firstname,
      this.middlename,
      this.lastname,
      this.gender,
      this.createdBy,
      this.email,
      this.mobile,
      this.code,
      this.image,
      this.age,
      this.maritalStatus,
      this.religion,
      this.height,
      this.weight,
      this.dob,
      this.birthPlace,
      this.birthTime});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    gender = json['gender'];
    createdBy = json['createdBy'];
    email = json['email'];
    mobile = json['mobile'];
    code = json['code'];
    image = json['image'];
    age = json['age'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    weight = json['weight'];
    dob = json['dob'];
    birthPlace = json['birth_place'];
    religion = json['religion'];
    birthTime = json['birth_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['firstname'] = this.firstname;
    data['middlename'] = this.middlename;
    data['lastname'] = this.lastname;
    data['gender'] = this.gender;
    data['createdBy'] = this.createdBy;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['code'] = this.code;
    data['image'] = this.image;
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['birth_place'] = this.birthPlace;
    data['religion'] = this.religion;
    data['birth_time'] = this.birthTime;
    return data;
  }
}

class LookingFor {
  String? heightFrom;
  String? heightTo;
  var ageFrom;
  var ageTo;
  String? annualIncome;
  String? diet;
  String? workType;
  String? maritalStatus;
  String? gotra;
  String? caste;

  LookingFor(
      {this.heightFrom,
      this.heightTo,
      this.ageFrom,
      this.ageTo,
      this.annualIncome,
      this.diet,
      this.workType,
      this.maritalStatus,
      this.gotra,
      this.caste});

  LookingFor.fromJson(Map<String, dynamic> json) {
    heightFrom = json['height_from'];
    heightTo = json['height_to'];
    ageFrom = json['age_from'];
    ageTo = json['age_to'];
    annualIncome = json['annual_income'];
    diet = json['diet_type'];
    workType = json['work_type'];
    maritalStatus = json['marital_status'];
    gotra = json['gotra'];
    caste = json['caste'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height_from'] = this.heightFrom;
    data['height_to'] = this.heightTo;
    data['age_from'] = this.ageFrom;
    data['age_to'] = this.ageTo;
    data['annual_income'] = this.annualIncome;
    data['diet_type'] = this.diet;
    data['work_type'] = this.workType;
    data['marital_status'] = this.maritalStatus;
    data['gotra'] = this.gotra;
    data['caste'] = this.caste;
    return data;
  }
}

class UserContact {
  String? mobile;
  String? altMobile;
  String? email;
  String? address;
  String? state;
  String? pincode;
  String? country;

  UserContact(
      {this.mobile,
      this.altMobile,
      this.email,
      this.address,
      this.state,
      this.pincode,
      this.country});

  UserContact.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    altMobile = json['alt_mobile'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    pincode = json['pincode'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['alt_mobile'] = this.altMobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['state'] = this.state;
    data['pincode'] = this.pincode;
    data['country'] = this.country;
    return data;
  }
}

class UserCareer {
  String? profession;
  String? annualIncome;
  String? qualification;
  String? educationFields;
  String? universityName;

  UserCareer(
      {this.profession,
      this.annualIncome,
      this.qualification,
      this.educationFields,
      this.universityName});

  UserCareer.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    annualIncome = json['annual_income'];
    qualification = json['qualification'];
    educationFields = json['education_fields'];
    universityName = json['university_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profession'] = this.profession;
    data['annual_income'] = this.annualIncome;
    data['qualification'] = this.qualification;
    data['education_fields'] = this.educationFields;
    data['university_name'] = this.universityName;
    return data;
  }
}

class UserFamily {
  String? familyType;
  String? religion;
  String? motherTounge;
  String? fatherOccupation;
  String? motherOccupation;
  String? familyIncome;
  String? noBrothers;
  String? marriedBrothers;
  String? noSisters;
  String? marriedSisters;
  String? familyBasedOut;

  UserFamily(
      {this.familyType,
      this.religion,
      this.motherTounge,
      this.fatherOccupation,
      this.motherOccupation,
      this.familyIncome,
      this.noBrothers,
      this.marriedBrothers,
      this.noSisters,
      this.marriedSisters,
      this.familyBasedOut});

  UserFamily.fromJson(Map<String, dynamic> json) {
    familyType = json['family_type'];
    religion = json['religion'];
    motherTounge = json['mother_tounge'];
    fatherOccupation = json['father_occupation'];
    motherOccupation = json['mother_occupation'];
    familyIncome = json['family_income'];
    noBrothers = json['no_brothers'];
    marriedBrothers = json['married_brothers'];
    noSisters = json['no_sisters'];
    marriedSisters = json['married_sisters'];
    familyBasedOut = json['family_based_out'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['family_type'] = this.familyType;
    data['religion'] = this.religion;
    data['mother_tounge'] = this.motherTounge;
    data['father_occupation'] = this.fatherOccupation;
    data['mother_occupation'] = this.motherOccupation;
    data['family_income'] = this.familyIncome;
    data['no_brothers'] = this.noBrothers;
    data['married_brothers'] = this.marriedBrothers;
    data['no_sisters'] = this.noSisters;
    data['married_sisters'] = this.marriedSisters;
    data['family_based_out'] = this.familyBasedOut;
    return data;
  }
}

class UserLocation {
  String? livingPlace;
  String? city;
  String? state;
  String? country;

  UserLocation({this.livingPlace, this.city, this.state, this.country});

  UserLocation.fromJson(Map<String, dynamic> json) {
    livingPlace = json['living_place'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['living_place'] = this.livingPlace;
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    return data;
  }
}
