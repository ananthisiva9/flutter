class AllClientsModel {
  List<MemberShipPlans>? memberShipPlans;
  Counts? counts;
  List<ClientDetails>? clientDetails;

  AllClientsModel({this.memberShipPlans, this.counts,this.clientDetails});

  AllClientsModel.fromJson(Map<String, dynamic> json) {
    this.memberShipPlans = json["MemberShipPlans"]==null ? null : (json["MemberShipPlans"] as List).map((e)=>MemberShipPlans.fromJson(e)).toList();
    this.counts = json["counts"] == null ? null : Counts.fromJson(json["counts"]);
    this.clientDetails = json["clientDetails"]==null ? null : (json["clientDetails"] as List).map((e)=>ClientDetails.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.memberShipPlans != null)
      data["MemberShipPlans"] = this.memberShipPlans?.map((e)=>e.toJson()).toList();
    if(this.counts != null)
      data["counts"] = this.counts?.toJson();
    if(this.clientDetails != null)
      data["clientDetails"] = this.clientDetails?.map((e)=>e.toJson()).toList();
    return data;
  }
}
class ClientDetails {
  int? id;
  String? firstname;
  String? lastname;
  String? location;
  String? doctorFirstname;
  String? doctorLastname;
  String? criticality;
  String? profilePic;

  ClientDetails(
      {this.id,
        this.firstname,
        this.lastname,
        this.location,
        this.doctorFirstname,
        this.doctorLastname,
        this.criticality,
        this.profilePic});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    location = json['location'];
    doctorFirstname = json['doctor_firstname'];
    doctorLastname = json['doctor_lastname'];
    criticality = json['criticality'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['location'] = this.location;
    data['doctor_firstname'] = this.doctorFirstname;
    data['doctor_lastname'] = this.doctorLastname;
    data['criticality'] = this.criticality;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}
class Counts {
  int? totalConsultant;
  int? totalSalesTeam;
  int? activeClients;
  int? disabledDoctors;
  int? totalHospitals;
  int? totalDoctors;
  int? totalClients;

  Counts({this.totalConsultant, this.totalSalesTeam, this.activeClients, this.disabledDoctors, this.totalHospitals, this.totalDoctors, this.totalClients});

  Counts.fromJson(Map<String, dynamic> json) {
    this.totalConsultant = json["totalConsultant"];
    this.totalSalesTeam = json["totalSalesTeam"];
    this.activeClients = json["activeClients"];
    this.disabledDoctors = json["disabledDoctors"];
    this.totalHospitals = json["totalHospitals"];
    this.totalDoctors = json["totalDoctors"];
    this.totalClients = json["totalClients"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["totalConsultant"] = this.totalConsultant;
    data["totalSalesTeam"] = this.totalSalesTeam;
    data["activeClients"] = this.activeClients;
    data["disabledDoctors"] = this.disabledDoctors;
    data["totalHospitals"] = this.totalHospitals;
    data["totalDoctors"] = this.totalDoctors;
    data["totalClients"] = this.totalClients;
    return data;
  }
}

class MemberShipPlans {
  int? id;
  String? name;
  int? amount;
  String? validity;

  MemberShipPlans({this.id, this.name, this.amount, this.validity});

  MemberShipPlans.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.name = json["name"];
    this.amount = json["amount"];
    this.validity = json["validity"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["amount"] = this.amount;
    data["validity"] = this.validity;
    return data;
  }
}
class LoginUserDataModel {
  String? firstname;
  String? lastname;
  String? email;

  LoginUserDataModel({this.firstname, this.lastname, this.email});

  LoginUserDataModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    return data;
  }
}