class AppointmentsModel {
  List<AppointmentTypeModel>? approved;
  List<AppointmentTypeModel>? rejected;
  List<AppointmentTypeModel>? completed;

  AppointmentsModel({this.approved, this.rejected, this.completed});

  AppointmentsModel.fromJson(Map<String, dynamic> json) {
    if (json['Approved'] != null) {
      approved = [];
      json['Approved'].forEach((v) {
        approved!.add(AppointmentTypeModel.fromJson(v));
      });
    }
    if (json['Rejected'] != null) {
      rejected = [];
      json['Rejected'].forEach((v) {
        rejected!.add(AppointmentTypeModel.fromJson(v));
      });
    }
    if (json['Completed'] != null) {
      completed = [];
      json['Completed'].forEach((v) {
        completed!.add(AppointmentTypeModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.approved != null) {
      data['Approved'] = this.approved!.map((v) => v.toJson()).toList();
    }
    if (this.rejected != null) {
      data['Rejected'] = this.rejected!.map((v) => v.toJson()).toList();
    }
    if (this.completed != null) {
      data['Completed'] = this.completed!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointmentTypeModel {
  int? id;
  String? formatedDate;
  String? formatedTime;
  String? clientName;
  String? location;
  String? date;
  String? time;
  int? week;
  int? days;
  String? schedule;
  String? meetingUrl;
  String? client_profile_pic;

  AppointmentTypeModel(
      {this.id,
      this.formatedDate,
      this.formatedTime,
      this.clientName,
      this.location,
      this.date,
      this.time,
        this.week,
        this.days,
      this.schedule,
      this.meetingUrl,
      this.client_profile_pic});

  AppointmentTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formatedDate = json['formated_date'];
    formatedTime = json['formated_time'];
    clientName = json['clientName'];
    location = json['location'];
    date = json['date'];
    time = json['time'];
    week= json['week'];
    days = json['days'];
    schedule = json['schedule'];
    meetingUrl = json['meeting_url'];
    client_profile_pic = json['client_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['formated_date'] = this.formatedDate;
    data['formated_time'] = this.formatedTime;
    data['clientName'] = this.clientName;
    data['location'] = this.location;
    data['date'] = this.date;
    data['time'] = this.time;
    data['week'] = this.week;
    data['days'] =  this.days;
    data['schedule'] = this.schedule;
    data['meeting_url'] = this.meetingUrl;
    data['client_profile_pic'] = this.client_profile_pic;
    return data;
  }
}
