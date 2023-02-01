class AllClientModel {
  AllClientModel({
    this.allClients,
  });

  List<AllClient>? allClients;

  factory AllClientModel.fromJson(Map<String, dynamic> json) => AllClientModel(
    allClients: List<AllClient>.from(json["all_clients"].map((x) => AllClient.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "all_clients": List<dynamic>.from(allClients!.map((x) => x.toJson())),
  };
}

class AllClient {
  int? id;
  String? firstName;
  String? lastName;
  int? age;
  String? location;
  String? dueDate;
  bool? accountStatus;
  String? criticality;
  int? week;
  int? days;

  AllClient(
      {this.id,
        this.firstName,
        this.lastName,
        this.age,
        this.location,
        this.dueDate,
        this.accountStatus,
        this.criticality,
        this.week,
        this.days});

  AllClient.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    age = json['age'];
    location = json['location'];
    dueDate = json['dueDate'];
    accountStatus = json['accountStatus'];
    criticality = json['criticality'];
    week = json['week'];
    days = json['days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['age'] = this.age;
    data['location'] = this.location;
    data['dueDate'] = this.dueDate;
    data['accountStatus'] = this.accountStatus;
    data['criticality'] = this.criticality;
    data['week'] = this.week;
    data['days'] = this.days;
    return data;
  }
}