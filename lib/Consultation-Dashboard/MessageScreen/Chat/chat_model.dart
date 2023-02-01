class ChatModel {
  ChatModel({
    this.allClients,
  });

  List<ChatItem>? allClients;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    allClients: List<ChatItem>.from(json["all_clients"].map((x) => ChatItem.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "all_clients": List<dynamic>.from(allClients!.map((x) => x.toJson())),
  };
}

class ChatItem {
  int? id;
  String? firstName;
  String? lastName;
  String? profile_pic;

  ChatItem(
      {this.id,
        this.firstName,
        this.lastName,
        this.profile_pic
       });

  ChatItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profile_pic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['profile_pic'] = this.profile_pic;
    return data;
  }
}