class MyDoctorListModel{
  MyDoctorListModel({
    this.items,
  });

  List<MyDoctorListItem>? items;

  factory MyDoctorListModel.fromJson(List<dynamic>? jsonList) => MyDoctorListModel(
    items: jsonList == null
        ? null
        : List<MyDoctorListItem>.from(jsonList.map((x) => MyDoctorListItem.fromJson(x))),
  );

  List<MyDoctorListItem>? toJson() =>
      items == null
          ? null
          : List<MyDoctorListItem>.from(items!.map((x) => x.toJson()));
}

class MyDoctorListItem {
  String? id;
  String? firstname;
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
  String? hospital;
  String? referalId;
  String? isVerified;

  MyDoctorListItem(
      {this.id,
        this.firstname,
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
        this.hospital,
        this.referalId,
        this.isVerified});

  MyDoctorListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
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
    hospital = json['hospital'];
    referalId = json['referalId'];
    isVerified = json['is_verified'];
  }

  Map<String, dynamic>? toJson() {
    final Map<String, dynamic>? data = new Map<String, dynamic>();
    data?['id'] = this.id;
    data?['firstname'] = this.firstname;
    data?['lastname'] = this.lastname;
    data?['email'] = this.email;
    data?['age'] = this.age;
    data?['location'] = this.location;
    data?['councilRegNo'] = this.councilRegNo;
    data?['experience'] = this.experience;
    data?['qualification'] = this.qualification;
    data?['speciality'] = this.speciality;
    data?['accountStatus'] = this.accountStatus;
    data?['price'] = this.price;
    data?['gender'] = this.gender;
    data?['languages'] = this.languages;
    data?['hospital'] = this.hospital;
    data?['referalId'] = this.referalId;
    data?['is_verified'] = this.isVerified;
    return data;
  }
}