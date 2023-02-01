class DisplayModel {
  DisplayModel({
    this.firstname,
    this.lastname,
    this.totalPatientsCount,
    this.noUpdateFromClientsCount,
    this.thisMonthPatientsCount,
    this.totalPatientsDetails,
  });

  String? firstname;
  dynamic? lastname;
  int? totalPatientsCount;
  int? noUpdateFromClientsCount;
  int? thisMonthPatientsCount;
  List<TotalPatientsDetail>? totalPatientsDetails;

  factory DisplayModel.fromJson(Map<String, dynamic> json) => DisplayModel(
    firstname: json["firstname"],
    lastname: json["lastname"],
    totalPatientsCount: json["total_patients_count"],
    noUpdateFromClientsCount: json["noUpdateFromClientsCount"],
    thisMonthPatientsCount: json["this_month_patients_count"],
    totalPatientsDetails: List<TotalPatientsDetail>.from(json["totalPatients_details"].map((x) => TotalPatientsDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "total_patients_count": totalPatientsCount,
    "noUpdateFromClientsCount": noUpdateFromClientsCount,
    "this_month_patients_count": thisMonthPatientsCount,
    "totalPatients_details": List<dynamic>.from(totalPatientsDetails!.map((x) => x.toJson())),
  };
}

class TotalPatientsDetail {
  TotalPatientsDetail({
    this.id,
    this.firstName,
    this.lastName,
    this.doctorFirstName,
    this.doctorLastName,
    this.location,
    this.age,
    this.dueDate,
    this.week,
    this.day,
    this.criticality,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? doctorFirstName;
  String? doctorLastName;
  String? location;
  int? age;
  String? dueDate;
  int? week;
  int? day;
  String? criticality;

  factory TotalPatientsDetail.fromJson(Map<String, dynamic> json) => TotalPatientsDetail(
    id: json["id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    doctorFirstName: json["doctorFirstName"],
    doctorLastName: json["doctorLastName"],
    location: json["location"],
    age: json["age"],
    dueDate: json["dueDate"],
    week: json["week"],
    day: json["day"],
    criticality: json["criticality"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "firstName": firstName,
    "lastName": lastName,
    "doctorFirstName": doctorFirstName,
    "doctorLastName": doctorLastName,
    "location": location,
    "age": age,
    "dueDate": dueDate,
    "week": week,
    "day": day,
    "criticality": criticality,
  };
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