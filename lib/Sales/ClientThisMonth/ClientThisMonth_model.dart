class ClientThisMonthsModel {
  ClientThisMonthsModel({
    this.items,
  });
  List<Client>? items;
  factory ClientThisMonthsModel.fromJson(List<dynamic>? jsonList) =>
      ClientThisMonthsModel(
        items: jsonList == null
            ? null
            : List<Client>.from(
            jsonList.map((x) => Client.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}

class Client {
  Client({
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

  factory Client.fromJson(Map<String, dynamic> json) =>
      Client(
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

  Map<String, dynamic> toJson() =>
      {
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