class SubscriptionClientModel {
  SubscriptionClientModel({
    this.items,
  });
  List<Client>? items;
  factory SubscriptionClientModel.fromJson(List<dynamic>? jsonList) =>
      SubscriptionClientModel(
        items: jsonList == null
            ? null
            : List<Client>.from(
            jsonList.map((x) => Client.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}

class Client {
  int? id;
  String? firstname;
  String? lastname;
  String? email;
  int? age;
  String? location;
  String? dueDate;
  String? doctorFirstname;
  String? doctorLastname;
  bool? isActive;
  String? subscription;
  String? criticality;
  int? week;
  String? profilePic;

  Client(
      {this.id,
        this.firstname,
        this.lastname,
        this.email,
        this.age,
        this.location,
        this.dueDate,
        this.doctorFirstname,
        this.doctorLastname,
        this.isActive,
        this.subscription,
        this.criticality,
        this.week,
        this.profilePic});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    age = json['age'];
    location = json['location'];
    dueDate = json['dueDate'];
    doctorFirstname = json['doctor_firstname'];
    doctorLastname = json['doctor_lastname'];
    isActive = json['is_active'];
    subscription = json['subscription'];
    criticality = json['criticality'];
    week = json['week'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['age'] = this.age;
    data['location'] = this.location;
    data['dueDate'] = this.dueDate;
    data['doctor_firstname'] = this.doctorFirstname;
    data['doctor_lastname'] = this.doctorLastname;
    data['is_active'] = this.isActive;
    data['subscription'] = this.subscription;
    data['criticality'] = this.criticality;
    data['week'] = this.week;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}