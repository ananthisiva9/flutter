class TodaysAppointmentModel{
  TodaysAppointmentModel({
    this.items,
  });
  List<TodaysAppointmentItem>? items;
  factory TodaysAppointmentModel.fromJson(List<dynamic>? jsonList) => TodaysAppointmentModel(
    items: jsonList == null
        ? null
        : List<TodaysAppointmentItem>.from(jsonList.map((x) => TodaysAppointmentItem.fromJson(x))),
  );
  List<dynamic>? toJson() =>
      items == null
          ? null
          : List<dynamic>.from(items!.map((x) => x.toJson()));
}
class TodaysAppointmentItem {
  int? id;
  String? firstname;
  String? lastname;
  String? time;
  String? date;
  String? meetingUrl;
  String? location;
  int? week;
  int? days;
  bool? meeting_open;
  String? client_profile_pic;

  TodaysAppointmentItem(
      {this.id,
        this.firstname,
        this.lastname,
        this.time,
        this.date,
        this.meetingUrl,
        this.location,
        this.week,
        this.days,
        this.meeting_open,
      this.client_profile_pic});

  TodaysAppointmentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    time = json['time'];
    date = json['date'];
    meetingUrl = json['meeting_url'];
    meeting_open = json['meeting_open'];
    location = json['location'];
    week = json['week'];
    days= json['days'];
    client_profile_pic = json['client_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['time'] = this.time;
    data['date'] = this.date;
    data['meetingUrl'] = this.meetingUrl;
    data['meeting_open'] = this.meeting_open;
    data['location'] = this.location;
    data['week'] = this.week;
    data['days'] = this.days;
    data['client_profile_pic'] = this.client_profile_pic;
    return data;
  }
}