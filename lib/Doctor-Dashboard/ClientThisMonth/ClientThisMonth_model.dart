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
  ClientThisMonthItem(
      {this.id,
      this.firstname,
      this.lastname,
      this.age,
      this.location,
      this.dueDate,
      this.accountStatus,
      this.profile_pic});
  int? id;
  String? firstname;
  String? lastname;
  int? age;
  dynamic? location;
  String? dueDate;
  bool? accountStatus;
  String? profile_pic;

  factory ClientThisMonthItem.fromJson(Map<String, dynamic> json) =>
      ClientThisMonthItem(
        firstname: json["firstname"],
        lastname: json["lastname"],
        age: json["age"],
        location: json["location"],
        dueDate: json["dueDate"],
        accountStatus: json["accountStatus"],
        profile_pic: json["profile_pic"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname,
        "lastname": lastname,
        "age": age,
        "location": location,
        "dueDate": dueDate,
        "accountStatus": accountStatus,
        "profile_pic": profile_pic,
      };
}
