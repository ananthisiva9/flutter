class ApprovalRequestModel{
  ApprovalRequestModel({
    this.items,
  });
  List<ApprovalRequestItem>? items;
  factory ApprovalRequestModel.fromJson(List<dynamic>? jsonList) => ApprovalRequestModel(
    items: jsonList == null
        ? null
        : List<ApprovalRequestItem>.from(jsonList.map((x) => ApprovalRequestItem.fromJson(x))),
  );
  List<dynamic>? toJson() =>
      items == null
          ? null
          : List<ApprovalRequestItem>.from(items!.map((x) => x.toJson()));
}
class ApprovalRequestItem {
  int? id;
  String? formated_date;
  String? formated_time;
  String? clientName;
  String? location;
  int? week;
  int? days;
  String? date;
  String? time;
  String? meetingUrl;
  String? client_profile_pic;

  ApprovalRequestItem(
      {this.id,
        this.formated_date,
        this.formated_time,
        this.clientName,
        this.location,
        this.week,
        this.days,
        this.date,
        this.time,
        this.meetingUrl,
      this.client_profile_pic});

  ApprovalRequestItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formated_date = json['formated_date'];
    formated_time = json['formated_time'];
    clientName = json['clientName'];
    location = json['location'];
    week = json['week'];
    days= json['days'];
    date = json['date'];
    time = json['time'];
    meetingUrl = json['meeting_url'];
    client_profile_pic = json['client_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['formated_date'] = this.formated_date;
    data['formated_time'] = this.formated_time;
    data['clientName'] = this.clientName;
    data['location'] = this.location;
    data['week'] = this.week;
    data['days'] = this.days;
    data['date'] = this.date;
    data['time'] = this.time;
    data['meeting_url'] = this.meetingUrl;
    data['client_profile_pic'] = this.client_profile_pic;
    return data;
  }
}