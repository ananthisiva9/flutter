class ClientListModel {
  List<Customers>? customers;

  ClientListModel({this.customers});

  ClientListModel.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = [];
      json['customers'].forEach((v) {
        customers!.add(new Customers.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Customers {
  int? id;
  String? firstname;
  String? lastname;
  int? age;
  String? location;
  String? dueDate;
  bool? accountStatus;
  String? criticality;
  int? currentWeek;
  int? days;
  String? profile_pic;

  Customers(
      {this.id,
        this.firstname,
        this.lastname,
        this.age,
        this.location,
        this.dueDate,
        this.accountStatus,
        this.criticality,
        this.currentWeek,
        this.days,
      this.profile_pic});

  Customers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    location = json['location'];
    dueDate = json['dueDate'];
    accountStatus = json['accountStatus'];
    criticality = json['criticality'];
    currentWeek = json['currentWeek'];
    days = json['days'];
    profile_pic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['age'] = this.age;
    data['location'] = this.location;
    data['dueDate'] = this.dueDate;
    data['accountStatus'] = this.accountStatus;
    data['criticality'] = this.criticality;
    data['currentWeek'] = this.currentWeek;
    data['days'] = this.days;
    data['profile_pic'] = this.profile_pic;
    return data;
  }
}