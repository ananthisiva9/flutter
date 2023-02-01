class AllClientsModel {
  List<ClientDetails>? clientDetails;

  AllClientsModel({this.clientDetails});

  AllClientsModel.fromJson(Map<String, dynamic> json) {
    this.clientDetails = json["clientDetails"] == null
        ? null
        : (json["clientDetails"] as List)
            .map((e) => ClientDetails.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.clientDetails != null)
      data["clientDetails"] =
          this.clientDetails?.map((e) => e.toJson()).toList();
    return data;
  }
}

class ClientDetails {
  int? id;
  String? firstname;
  String? lastname;
  int? age;
  String? location;
  bool? isActive;
  int? week;
  String? profilePic;

  ClientDetails({this.id,
    this.firstname,
    this.lastname,
    this.age,
    this.location,
    this.isActive,
    this.week,
    this.profilePic});

  ClientDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    age = json['age'];
    location = json['location'];
    isActive = json['is_active'];
    week = json['week'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['age'] = this.age;
    data['location'] = this.location;
    data['is_active'] = this.isActive;
    data['week'] = this.week;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}