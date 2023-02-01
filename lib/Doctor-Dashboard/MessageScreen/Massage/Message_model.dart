class MessageModel {
  MessageModel({
    this.messages,
    this.receiverDetails,
  });

  List<Message>? messages;
  ReceiverDetails? receiverDetails;

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    messages: List<Message>.from(json["messages"].map((x) => Message.fromJson(x))),
    receiverDetails: ReceiverDetails.fromJson(json["receiverDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "messages": List<dynamic>.from(messages!.map((x) => x.toJson())),
    "receiverDetails": receiverDetails!.toJson(),
  };
}

class Message {
  Message({
    this.sender,
    this.receiver,
    this.message,
    this.date,
    this.time,
  });

  String? sender;
  String? receiver;
  String? message;
  String? date;
  String? time;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    sender: json["sender"],
    receiver: json["receiver"],
    message: json["message"],
    date: json["date"],
    time: json["time"],
  );

  Map<String, dynamic> toJson() => {
    "sender": sender,
    "receiver": receiver,
    "message": message,
    "date": date,
    "time": time,
  };
}

class ReceiverDetails {
  ReceiverDetails({
    this.imageUrl,
    this.name,
    this.id
  });

  String? imageUrl;
  String? name;
  int? id;

  factory ReceiverDetails.fromJson(Map<String, dynamic> json) => ReceiverDetails(
    id: json["id"],
    imageUrl: json["image_url"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "image_url": imageUrl,
    "name": name,
    "id" : id,
  };
}
