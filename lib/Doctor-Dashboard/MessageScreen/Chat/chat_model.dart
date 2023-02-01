class ChatModel {
  List<ChatItem>? customers;

  ChatModel({this.customers});

  ChatModel.fromJson(Map<String, dynamic> json) {
    if (json['customers'] != null) {
      customers = [];
      json['customers'].forEach((v) {
        customers!.add(new ChatItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customers != null) {
      data['customers'] = this.customers!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChatItem {
  int? id;
  String? firstname;
  String? lastname;
  String? profile_pic;

  ChatItem(
      {this.id,
        this.firstname,
        this.lastname,
        this.profile_pic});

  ChatItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    profile_pic = json['profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['profile_pic'] = this.profile_pic;
    return data;
  }
}