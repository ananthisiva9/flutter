class BookAppoinmentModel {
  String? doctor;
  String? date;
  String? time;

  BookAppoinmentModel({this.doctor, this.date, this.time});

  BookAppoinmentModel.fromJson(Map<String, dynamic> json) {
    doctor = json['doctor'];
    date = json['date'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor'] = this.doctor;
    data['date'] = this.date;
    data['time'] = this.time;
    return data;
  }
}