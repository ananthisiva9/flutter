class RescheduleModel {
  String? appointmentID;
  String? date;
  String? time;

  RescheduleModel({this.appointmentID, this.date, this.time});

  RescheduleModel.fromJson(Map<String, dynamic> json) {
    appointmentID = json['doctor'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentId'] = this.appointmentID;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}