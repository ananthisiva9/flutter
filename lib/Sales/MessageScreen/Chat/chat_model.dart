class ChatModel {
  List<Client>? chat;

  ChatModel(
      {this.chat});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['totalPatients_details'] != null) {
      chat = <Client>[];
      json['totalPatients_details'].forEach((v) {
        chat!.add(Client.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    if (chat != null) {
      data['totalPatients_details'] =
          chat!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Client {
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

  Client(
      {this.id,
        this.firstName,
        this.lastName,
        this.doctorFirstName,
        this.doctorLastName,
        this.location,
        this.age,
        this.dueDate,
        this.week,
        this.day,
        this.criticality});

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    doctorFirstName = json['doctorFirstName'];
    doctorLastName = json['doctorLastName'];
    location = json['location'];
    age = json['age'];
    dueDate = json['dueDate'];
    week = json['week'];
    day = json['day'];
    criticality = json['criticality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['doctorFirstName'] = doctorFirstName;
    data['doctorLastName'] = doctorLastName;
    data['location'] = location;
    data['age'] = age;
    data['dueDate'] = dueDate;
    data['week'] = week;
    data['day'] = day;
    data['criticality'] = criticality;
    return data;
  }
}