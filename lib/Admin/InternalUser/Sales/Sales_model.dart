class SalesModel {
  List<Details>? details;

  SalesModel({this.details});

  SalesModel.fromJson(Map<String, dynamic> json) {
    if (json['details'] != null) {
      details = [];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String? id;
  String? firstname;
  String? email;
  bool? accountStatus;
  String? location;
  String? profile_pic;
  Details({
    this.id,
    this.firstname,
    this.email,
    this.accountStatus,
    this.location,
    this.profile_pic
  });

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    email = json['email'];
    accountStatus = json['accountStatus'];
    location = json['location'];
    profile_pic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['email'] = this.email;
    data['accountStatus'] = this.accountStatus;
    data['profile_pic'] = this.profile_pic;
    return data;
  }
}
