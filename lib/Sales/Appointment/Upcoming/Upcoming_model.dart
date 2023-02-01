class UpComingModel {
  bool? status;
  Data? data;
  String? message;

  UpComingModel({this.status, this.data, this.message});

  UpComingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? firstname;
  String? hospitals;
  String? lastname;
  String? email;
  int? age;
  String? location;
  int? experience;
  String? qualification;
  String? speciality;
  String? gender;
  String? languages;
  String? referalId;
  String? isVerified;
  String? profileFullUrl;
  List<Appointments>? appointments;

  Data(
      {this.id,
        this.firstname,
        this.hospitals,
        this.lastname,
        this.email,
        this.age,
        this.location,
        this.experience,
        this.qualification,
        this.speciality,
        this.gender,
        this.languages,
        this.referalId,
        this.isVerified,
        this.profileFullUrl,
        this.appointments});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    hospitals = json['hospitals'];
    lastname = json['lastname'];
    email = json['email'];
    age = json['age'];
    location = json['location'];
    experience = json['experience'];
    qualification = json['qualification'];
    speciality = json['speciality'];
    gender = json['gender'];
    languages = json['languages'];
    referalId = json['referalId'];
    isVerified = json['is_verified'];
    profileFullUrl = json['profile_full_url'];
    if (json['appointments'] != null) {
      appointments = <Appointments>[];
      json['appointments'].forEach((v) {
        appointments!.add(new Appointments.fromJson(v));
      });
    }
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
    data['experience'] = this.experience;
    data['qualification'] = this.qualification;
    data['speciality'] = this.speciality;
    data['gender'] = this.gender;
    data['languages'] = this.languages;
    data['referalId'] = this.referalId;
    data['is_verified'] = this.isVerified;
    data['profile_full_url'] = this.profileFullUrl;
    if (this.appointments != null) {
      data['appointments'] = this.appointments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Appointments {
  int? id;
  String? date;
  String? time;
  String? schedule;
  bool? approved;
  bool? rejected;
  bool? rescheduledByDoctor;
  bool? rescheduledByClient;
  bool? completed;
  String? meetingUrl;
  Doctor? doctor;
  Customer? customer;

  Appointments(
      {this.id,
        this.date,
        this.time,
        this.schedule,
        this.approved,
        this.rejected,
        this.rescheduledByDoctor,
        this.rescheduledByClient,
        this.completed,
        this.meetingUrl,
        this.doctor,
        this.customer});

  Appointments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    schedule = json['schedule'];
    approved = json['approved'];
    rejected = json['rejected'];
    rescheduledByDoctor = json['rescheduled_by_doctor'];
    rescheduledByClient = json['rescheduled_by_client'];
    completed = json['completed'];
    meetingUrl = json['meeting_url'];
    doctor =
    json['doctor'] != null ? new Doctor.fromJson(json['doctor']) : null;
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['schedule'] = this.schedule;
    data['approved'] = this.approved;
    data['rejected'] = this.rejected;
    data['rescheduled_by_doctor'] = this.rescheduledByDoctor;
    data['rescheduled_by_client'] = this.rescheduledByClient;
    data['completed'] = this.completed;
    data['meeting_url'] = this.meetingUrl;
    if (this.doctor != null) {
      data['doctor'] = this.doctor!.toJson();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class Doctor {
  int? id;
  String? speciality;
  String? qualification;
  String? medicalCouncil;
  String? councilRegNo;
  String? hospitals;
  String? interests;
  String? placeOfWork;
  String? onlineConsultation;
  int? experience;
  int? age;
  String? languages;
  String? location;
  String? referalId;
  int? price;
  String? gender;
  User? user;
  String? hospitalManager;

  Doctor(
      {this.id,
        this.speciality,
        this.qualification,
        this.medicalCouncil,
        this.councilRegNo,
        this.hospitals,
        this.interests,
        this.placeOfWork,
        this.onlineConsultation,
        this.experience,
        this.age,
        this.languages,
        this.location,
        this.referalId,
        this.price,
        this.gender,
        this.user,
        this.hospitalManager});

  Doctor.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    speciality = json['speciality'];
    qualification = json['qualification'];
    medicalCouncil = json['medicalCouncil'];
    councilRegNo = json['councilRegNo'];
    hospitals = json['hospitals'];
    interests = json['interests'];
    placeOfWork = json['placeOfWork'];
    onlineConsultation = json['onlineConsultation'];
    experience = json['experience'];
    age = json['age'];
    languages = json['languages'];
    location = json['location'];
    referalId = json['referalId'];
    price = json['price'];
    gender = json['gender'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    hospitalManager = json['hospitalManager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['speciality'] = this.speciality;
    data['qualification'] = this.qualification;
    data['medicalCouncil'] = this.medicalCouncil;
    data['councilRegNo'] = this.councilRegNo;
    data['hospitals'] = this.hospitals;
    data['interests'] = this.interests;
    data['placeOfWork'] = this.placeOfWork;
    data['onlineConsultation'] = this.onlineConsultation;
    data['experience'] = this.experience;
    data['age'] = this.age;
    data['languages'] = this.languages;
    data['location'] = this.location;
    data['referalId'] = this.referalId;
    data['price'] = this.price;
    data['gender'] = this.gender;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['hospitalManager'] = this.hospitalManager;
    return data;
  }
}
class Customer {
  int? id;
  int? age;
  int? weight;
  String? job;
  String? address;
  String? husband;
  String? location;
  String? idproof;
  String? marriedSince;
  int? babiesNumber;
  String? abortions;
  String? twins;
  String? diabetes;
  String? allergicReaction;
  String? surgery;
  String? menstruation;
  String? menstruationDate;
  String? hereditory;
  String? gynacology;
  String? noOfBabiesPregnantWith;
  String? doctorFinalVisit;
  Null? prescription;
  Null? drugUse;
  User? user;
  ReferalId? referalId;

  Customer(
      {this.id,
        this.age,
        this.weight,
        this.job,
        this.address,
        this.husband,
        this.location,
        this.idproof,
        this.marriedSince,
        this.babiesNumber,
        this.abortions,
        this.twins,
        this.diabetes,
        this.allergicReaction,
        this.surgery,
        this.menstruation,
        this.menstruationDate,
        this.hereditory,
        this.gynacology,
        this.noOfBabiesPregnantWith,
        this.doctorFinalVisit,
        this.prescription,
        this.drugUse,
        this.user,
        this.referalId});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    age = json['age'];
    weight = json['weight'];
    job = json['job'];
    address = json['address'];
    husband = json['husband'];
    location = json['location'];
    idproof = json['Idproof'];
    marriedSince = json['marriedSince'];
    babiesNumber = json['babies_number'];
    abortions = json['abortions'];
    twins = json['twins'];
    diabetes = json['diabetes'];
    allergicReaction = json['allergic_reaction'];
    surgery = json['surgery'];
    menstruation = json['Menstruation'];
    menstruationDate = json['Menstruation_date'];
    hereditory = json['hereditory'];
    gynacology = json['gynacology'];
    noOfBabiesPregnantWith = json['no_of_babies_pregnant_with'];
    doctorFinalVisit = json['doctor_final_visit'];
    prescription = json['prescription'];
    drugUse = json['drugUse'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    referalId = json['referalId'] != null
        ? new ReferalId.fromJson(json['referalId'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['age'] = this.age;
    data['weight'] = this.weight;
    data['job'] = this.job;
    data['address'] = this.address;
    data['husband'] = this.husband;
    data['location'] = this.location;
    data['Idproof'] = this.idproof;
    data['marriedSince'] = this.marriedSince;
    data['babies_number'] = this.babiesNumber;
    data['abortions'] = this.abortions;
    data['twins'] = this.twins;
    data['diabetes'] = this.diabetes;
    data['allergic_reaction'] = this.allergicReaction;
    data['surgery'] = this.surgery;
    data['Menstruation'] = this.menstruation;
    data['Menstruation_date'] = this.menstruationDate;
    data['hereditory'] = this.hereditory;
    data['gynacology'] = this.gynacology;
    data['no_of_babies_pregnant_with'] = this.noOfBabiesPregnantWith;
    data['doctor_final_visit'] = this.doctorFinalVisit;
    data['prescription'] = this.prescription;
    data['drugUse'] = this.drugUse;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.referalId != null) {
      data['referalId'] = this.referalId!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? password;
  String? lastLogin;
  int? role;
  String? email;
  String? firstname;
  String? lastname;
  String? mobile;
  String? profileImg;
  bool? isStaff;
  bool? isActive;
  bool? isVerified;
  String? dateJoined;

  User(
      {this.id,
        this.password,
        this.lastLogin,
        this.role,
        this.email,
        this.firstname,
        this.lastname,
        this.mobile,
        this.profileImg,
        this.isStaff,
        this.isActive,
        this.isVerified,
        this.dateJoined});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    password = json['password'];
    lastLogin = json['last_login'];
    role = json['role'];
    email = json['email'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    mobile = json['mobile'];
    profileImg = json['profile_img'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    isVerified = json['is_verified'];
    dateJoined = json['dateJoined'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['password'] = this.password;
    data['last_login'] = this.lastLogin;
    data['role'] = this.role;
    data['email'] = this.email;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['mobile'] = this.mobile;
    data['profile_img'] = this.profileImg;
    data['is_staff'] = this.isStaff;
    data['is_active'] = this.isActive;
    data['is_verified'] = this.isVerified;
    data['dateJoined'] = this.dateJoined;
    return data;
  }
}

class ReferalId {
  int? id;
  String? speciality;
  String? qualification;
  String? medicalCouncil;
  String? councilRegNo;
  String? hospitals;
  String? interests;
  String? placeOfWork;
  String? onlineConsultation;
  int? experience;
  int? age;
  String? languages;
  String? location;
  String? referalId;
  int? price;
  String? gender;
  int? user;
  Null? hospitalManager;

  ReferalId(
      {this.id,
        this.speciality,
        this.qualification,
        this.medicalCouncil,
        this.councilRegNo,
        this.hospitals,
        this.interests,
        this.placeOfWork,
        this.onlineConsultation,
        this.experience,
        this.age,
        this.languages,
        this.location,
        this.referalId,
        this.price,
        this.gender,
        this.user,
        this.hospitalManager});

  ReferalId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    speciality = json['speciality'];
    qualification = json['qualification'];
    medicalCouncil = json['medicalCouncil'];
    councilRegNo = json['councilRegNo'];
    hospitals = json['hospitals'];
    interests = json['interests'];
    placeOfWork = json['placeOfWork'];
    onlineConsultation = json['onlineConsultation'];
    experience = json['experience'];
    age = json['age'];
    languages = json['languages'];
    location = json['location'];
    referalId = json['referalId'];
    price = json['price'];
    gender = json['gender'];
    user = json['user'];
    hospitalManager = json['hospitalManager'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['speciality'] = this.speciality;
    data['qualification'] = this.qualification;
    data['medicalCouncil'] = this.medicalCouncil;
    data['councilRegNo'] = this.councilRegNo;
    data['hospitals'] = this.hospitals;
    data['interests'] = this.interests;
    data['placeOfWork'] = this.placeOfWork;
    data['onlineConsultation'] = this.onlineConsultation;
    data['experience'] = this.experience;
    data['age'] = this.age;
    data['languages'] = this.languages;
    data['location'] = this.location;
    data['referalId'] = this.referalId;
    data['price'] = this.price;
    data['gender'] = this.gender;
    data['user'] = this.user;
    data['hospitalManager'] = this.hospitalManager;
    return data;
  }
}
