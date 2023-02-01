class ConsultantModel {
  List<Details>? details;
  int? count;

  ConsultantModel({this.details, this.count});

  ConsultantModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      details =  <Details>[];
      json['data'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.details != null) {
      data['data'] = this.details!.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Details {
  String? name;
  String? email;
  String? location;
  String? passwordString;
  bool? accountStatus;
  int? user;
  String? profilePic;

  Details(
      {this.name,
        this.email,
        this.location,
        this.passwordString,
        this.accountStatus,
        this.user,
        this.profilePic});

  Details.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    location = json['location'];
    passwordString = json['passwordString'];
    accountStatus = json['accountStatus'];
    user = json['user'];
    profilePic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['location'] = this.location;
    data['passwordString'] = this.passwordString;
    data['accountStatus'] = this.accountStatus;
    data['user'] = this.user;
    data['profile_pic'] = this.profilePic;
    return data;
  }
}