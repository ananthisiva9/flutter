class ApproveDoctorsModel {
  ApproveDoctorsModel({
    this.items,
  });
  List<Doctors>? items;
  factory ApproveDoctorsModel.fromJson(List<dynamic>? jsonList) =>
      ApproveDoctorsModel(
        items: jsonList == null
            ? null
            : List<Doctors>.from(
            jsonList.map((x) => Doctors.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}
class Doctors {
  String? id;
  String? firstname;
  String? hospitals;
  String? lastname;
  String? email;
  int? age;
  String? location;
  String? councilRegNo;
  int? experience;
  String? qualification;
  String? speciality;
  bool? accountStatus;
  int? price;
  String? gender;
  String? languages;
  String? hospitalManager;
  String? referalId;
  String? isVerified;
  String? profileFullUrl;

  Doctors(
      {this.id,
        this.firstname,
        this.hospitals,
        this.lastname,
        this.email,
        this.age,
        this.location,
        this.councilRegNo,
        this.experience,
        this.qualification,
        this.speciality,
        this.accountStatus,
        this.price,
        this.gender,
        this.languages,
        this.hospitalManager,
        this.referalId,
        this.isVerified,
        this.profileFullUrl});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    hospitals = json['hospitals'];
    lastname = json['lastname'];
    email = json['email'];
    age = json['age'];
    location = json['location'];
    councilRegNo = json['councilRegNo'];
    experience = json['experience'];
    qualification = json['qualification'];
    speciality = json['speciality'];
    accountStatus = json['accountStatus'];
    price = json['price'];
    gender = json['gender'];
    languages = json['languages'];
    hospitalManager = json['hospital_manager'];
    referalId = json['referalId'];
    isVerified = json['is_verified'];
    profileFullUrl = json['profile_full_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['hospitals'] = this.hospitals;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['age'] = this.age;
    data['location'] = this.location;
    data['councilRegNo'] = this.councilRegNo;
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['speciality'] = this.speciality;
    data['accountStatus'] = this.accountStatus;
    data['price'] = this.price;
    data['gender'] = this.gender;
    data['languages'] = this.languages;
    data['hospital_manager'] = this.hospitalManager;
    data['referalId'] = this.referalId;
    data['is_verified'] = this.isVerified;
    data['profile_full_url'] = this.profileFullUrl;
    return data;
  }
}