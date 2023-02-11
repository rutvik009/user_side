class GetAllCandidateDetailsModel {
  bool? success;
  Data? data;

  GetAllCandidateDetailsModel({this.success, this.data});

  GetAllCandidateDetailsModel.fromJson(Map<String, dynamic> json) {
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
  Profile? profile;
  BasicInfo? basicInfo;
  LookingFor? lookingFor;
  UserContact? userContact;
  UserCareer? userCareer;
  UserFamily? userFamily;
  UserLocation? userLocation;
  UserHobbies? userHobbies;

  Data(
      {this.profile,
      this.basicInfo,
      this.lookingFor,
      this.userContact,
      this.userCareer,
      this.userFamily,
      this.userLocation,
      this.userHobbies});

  Data.fromJson(Map<String, dynamic> json) {
    profile =
        json['profile'] != null ? new Profile.fromJson(json['profile']) : null;
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
    userHobbies = json['userHobbies'] != null
        ? new UserHobbies.fromJson(json['userHobbies'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.profile != null) {
      data['profile'] = this.profile!.toJson();
    }
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
    if (this.userHobbies != null) {
      data['userHobbies'] = this.userHobbies!.toJson();
    }
    return data;
  }
}

class Profile {
  String? profileCompletion;

  Profile({this.profileCompletion});

  Profile.fromJson(Map<String, dynamic> json) {
    profileCompletion = json['profile_completion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_completion'] = this.profileCompletion;
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
  String? referedBy;
  String? email;
  String? mobile;
  String? code;
  String? image;
  var religion;
  var weight;
  String? dob;
  var age;
  String? maritalStatus;
  String? height;
  String? caste;
  String? gotra;
  String? skinTone;
  String? allergicType;
  String? manglikType;
  String? beardType;
  String? drinkType;
  String? nationality;
  String? bodyType;
  String? birthPlace;
  String? birthTime;

  BasicInfo(
      {this.name,
      this.firstname,
      this.middlename,
      this.lastname,
      this.gender,
      this.createdBy,
      this.referedBy,
      this.email,
      this.mobile,
      this.code,
      this.image,
      this.weight,
      this.dob,
      this.religion,
      this.age,
      this.maritalStatus,
      this.height,
      this.caste,
      this.gotra,
      this.skinTone,
      this.allergicType,
      this.manglikType,
      this.beardType,
      this.drinkType,
      this.nationality,
      this.bodyType,
      this.birthPlace,
      this.birthTime});

  BasicInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    firstname = json['firstname'];
    middlename = json['middlename'];
    lastname = json['lastname'];
    gender = json['gender'];
    createdBy = json['createdBy'];
    referedBy = json['referedBy'];
    email = json['email'];
    mobile = json['mobile'];
    code = json['code'];
    image = json['image'];
    religion = json['religion'];
    weight = json['weight'];
    dob = json['dob'];
    age = json['age'];
    maritalStatus = json['marital_status'];
    height = json['height'];
    caste = json['caste'];
    gotra = json['gotra'];
    skinTone = json['skin_tone'];
    allergicType = json['allergic_type'];
    manglikType = json['manglik_type'];
    beardType = json['beard_type'];
    drinkType = json['drink_type'];
    nationality = json['nationality'];
    bodyType = json['body_type'];
    birthPlace = json['birth_place'];
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
    data['referedBy'] = this.referedBy;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    data['code'] = this.code;
    data['image'] = this.image;
    data['religion'] = this.religion;
    data['weight'] = this.weight;
    data['dob'] = this.dob;
    data['age'] = this.age;
    data['marital_status'] = this.maritalStatus;
    data['height'] = this.height;
    data['caste'] = this.caste;
    data['gotra'] = this.gotra;
    data['skin_tone'] = this.skinTone;
    data['allergic_type'] = this.allergicType;
    data['manglik_type'] = this.manglikType;
    data['beard_type'] = this.beardType;
    data['drink_type'] = this.drinkType;
    data['nationality'] = this.nationality;
    data['body_type'] = this.bodyType;
    data['birth_place'] = this.birthPlace;
    data['birth_time'] = this.birthTime;
    return data;
  }
}

class LookingFor {
  String? heightFrom;
  String? heightTo;
  int? ageFrom;
  int? ageTo;
  String? annualIncome;
  String? dietType;
  String? workType;
  String? caste;
  String? gotra;
  String? maritalStatus;
  String? quality;

  LookingFor(
      {this.heightFrom,
      this.heightTo,
      this.ageFrom,
      this.ageTo,
      this.annualIncome,
      this.dietType,
      this.workType,
      this.caste,
      this.gotra,
      this.maritalStatus,
      this.quality});

  LookingFor.fromJson(Map<String, dynamic> json) {
    heightFrom = json['height_from'];
    heightTo = json['height_to'];
    ageFrom = json['age_from'];
    ageTo = json['age_to'];
    annualIncome = json['annual_income'];
    dietType = json['diet_type'];
    workType = json['work_type'];
    caste = json['caste'];
    gotra = json['gotra'];
    maritalStatus = json['marital_status'];
    quality = json['quality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height_from'] = this.heightFrom;
    data['height_to'] = this.heightTo;
    data['age_from'] = this.ageFrom;
    data['age_to'] = this.ageTo;
    data['annual_income'] = this.annualIncome;
    data['diet_type'] = this.dietType;
    data['work_type'] = this.workType;
    data['caste'] = this.caste;
    data['gotra'] = this.gotra;
    data['marital_status'] = this.maritalStatus;
    data['quality'] = this.quality;
    return data;
  }
}

class UserContact {
  var mobile;
  var altMobile;
  var email;
  String? address;
  String? state;
  String? country;
  String? pincode;

  UserContact(
      {this.mobile,
      this.altMobile,
      this.email,
      this.address,
      this.state,
      this.country,
      this.pincode});

  UserContact.fromJson(Map<String, dynamic> json) {
    mobile = json['mobile'];
    altMobile = json['alt_mobile'];
    email = json['email'];
    address = json['address'];
    state = json['state'];
    country = json['country'];
    pincode = json['pincode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mobile'] = this.mobile;
    data['alt_mobile'] = this.altMobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['state'] = this.state;
    data['country'] = this.country;
    data['pincode'] = this.pincode;
    return data;
  }
}

class UserCareer {
  var profession;
  var annualIncome;
  var qualification;
  var educationFields;
  var universityName;
  var education;

  UserCareer(
      {this.profession,
      this.annualIncome,
      this.qualification,
      this.educationFields,
      this.education,
      this.universityName});

  UserCareer.fromJson(Map<String, dynamic> json) {
    profession = json['profession'];
    annualIncome = json['annual_income'];
    qualification = json['qualification'];
    educationFields = json['education_fields'];
    education = json['education'];
    universityName = json['university_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profession'] = this.profession;
    data['annual_income'] = this.annualIncome;
    data['qualification'] = this.qualification;
    data['education_fields'] = this.educationFields;
    data['education'] = this.education;
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
  var livingPlace;
  var city;
  var state;
  var country;

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

class UserHobbies {
  var hobbies;

  UserHobbies({this.hobbies});

  UserHobbies.fromJson(Map<String, dynamic> json) {
    hobbies = json['hobbies'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['hobbies'] = this.hobbies;
    return data;
  }
}
