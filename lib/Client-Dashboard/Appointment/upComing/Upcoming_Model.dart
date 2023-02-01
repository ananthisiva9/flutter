class UpcomingModel {
  UpcomingModel({
    this.items,
  });

  List<UpcomingItem>? items;

  factory UpcomingModel.fromJson(List<dynamic>? jsonList) => UpcomingModel(
        items: jsonList == null
            ? null
            : List<UpcomingItem>.from(
                jsonList.map((x) => UpcomingItem.fromJson(x))),
      );

  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}

class UpcomingItem {
  int? id;
  String? doctorFirstname;
  String? doctorLastname;
  String? doctorQualification;
  int? doctorExperience;
  String? date;
  String? time;
  String? meetingUrl;
  String? doctor_profile_pic;

  UpcomingItem(
      {this.id,
      this.doctorFirstname,
      this.doctorLastname,
      this.doctorQualification,
      this.doctorExperience,
      this.date,
      this.time,
      this.meetingUrl,
      this.doctor_profile_pic});

  UpcomingItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    doctorFirstname = json['doctor_firstname'];
    doctorLastname = json['doctor_lastname'];
    doctorQualification = json['doctor_qualification'];
    doctorExperience = json['doctor_experience'];
    date = json['date'];
    time = json['time'];
    meetingUrl = json['meeting_url'];
    doctor_profile_pic = json['doctor_profile_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['doctor_firstname'] = this.doctorFirstname;
    data['doctor_lastname'] = this.doctorLastname;
    data['doctor_qualification'] = this.doctorQualification;
    data['doctor_experience'] = this.doctorExperience;
    data['date'] = this.date;
    data['time'] = this.time;
    data['meeting_url'] = this.meetingUrl;
    data['doctor_profile_pic'] = this.doctor_profile_pic;
    return data;
  }
}
