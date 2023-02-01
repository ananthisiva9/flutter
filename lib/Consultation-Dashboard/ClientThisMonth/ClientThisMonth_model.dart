class ClientThisMonthModel {
  ClientThisMonthModel({
    this.items,
  });
  List<ClientThisMonthItem>? items;
  factory ClientThisMonthModel.fromJson(List<dynamic>? jsonList) =>
      ClientThisMonthModel(
        items: jsonList == null
            ? null
            : List<ClientThisMonthItem>.from(
            jsonList.map((x) => ClientThisMonthItem.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}

class ClientThisMonthItem {
  ClientThisMonthItem({
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
  dynamic? location;
  int? age;
  DateTime? dueDate;
  int? week;
  int? day;
  String? criticality;


  factory ClientThisMonthItem.fromJson(Map<String, dynamic> json) =>
      ClientThisMonthItem(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        doctorFirstName : json["doctorFirstName"],
        doctorLastName: json["doctorLastName"],
        location: json["location"],
        age: json["age"],
        dueDate: DateTime.parse(json["dueDate"]),
        week: json["week"],
        day: json["day"],
        criticality: json["criticality"],
      );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "firstName": firstName,
    "lastName": lastName,
    "doctorFirstName" : doctorFirstName,
    "doctorLastName" : doctorLastName,
    "location": location,
    "age": age,
    "dueDate":
    "${dueDate!.year.toString().padLeft(4, '0')}-${dueDate!.month.toString().padLeft(2, '0')}-${dueDate!.day.toString().padLeft(2, '0')}",
    "week" : week,
    "day" : day,
    "criticality": criticality,
  };
}
