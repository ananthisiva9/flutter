class HospitalsModel {
  HospitalsModel({
    this.items,
  });
  List<Hospital>? items;
  factory HospitalsModel.fromJson(List<dynamic>? jsonList) =>
      HospitalsModel(
        items: jsonList == null
            ? null
            : List<Hospital>.from(
            jsonList.map((x) => Hospital.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}
class Hospital {
  int? id;
  bool? accountStatus;
  String? name;
  String? email;
  String? location;
  String? passwordString;
  int? user;

  Hospital(
      {this.id,
        this.accountStatus,
        this.name,
        this.email,
        this.location,
        this.passwordString,
        this.user});

  Hospital.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountStatus = json['accountStatus'];
    name = json['name'];
    email = json['email'];
    location = json['location'];
    passwordString = json['passwordString'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['accountStatus'] = this.accountStatus;
    data['name'] = this.name;
    data['email'] = this.email;
    data['location'] = this.location;
    data['passwordString'] = this.passwordString;
    data['user'] = this.user;
    return data;
  }
}