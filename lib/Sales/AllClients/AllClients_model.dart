class AllClients {
  List<TotalPatientsDetails>? totalPatientsDetails;

  AllClients(
      {this.totalPatientsDetails});

  AllClients.fromJson(Map<String, dynamic> json) {
    if (json['totalPatients_details'] != null) {
      totalPatientsDetails = <TotalPatientsDetails>[];
      json['totalPatients_details'].forEach((v) {
        totalPatientsDetails!.add( TotalPatientsDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (totalPatientsDetails != null) {
      data['totalPatients_details'] =
          totalPatientsDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalPatientsDetails {
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

  TotalPatientsDetails(
      {this.id,
        this.firstName,
        this.lastName,
        this.doctorFirstName,
        this.doctorLastName,
        this.location,
        this.age,
        this.dueDate,
        this.week,
        this.day,
        this.criticality});

  TotalPatientsDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    doctorFirstName = json['doctorFirstName'];
    doctorLastName = json['doctorLastName'];
    location = json['location'];
    age = json['age'];
    dueDate = json['dueDate'];
    week = json['week'];
    day = json['day'];
    criticality = json['criticality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['doctorFirstName'] = doctorFirstName;
    data['doctorLastName'] = doctorLastName;
    data['location'] = location;
    data['age'] = age;
    data['dueDate'] = dueDate;
    data['week'] = week;
    data['day'] = day;
    data['criticality'] = criticality;
    return data;
  }
}