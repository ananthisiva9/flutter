class ContrationModel {
  int? id;
  String? painScale;
  String? formatedTime;
  String? formatedInterval;
  String? timeStamp;
  String? date;
  String? time;
  int? contraction;
  String? interval;

  ContrationModel(
      {this.id,
        this.painScale,
        this.formatedTime,
        this.formatedInterval,
        this.timeStamp,
        this.date,
        this.time,
        this.contraction,
        this.interval});

  ContrationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    painScale = json['painScale'];
    formatedTime = json['formated_time'];
    formatedInterval = json['formated_interval'];
    timeStamp = json['time_stamp'];
    date = json['date'];
    time = json['time'];
    contraction = json['contraction'];
    interval = json['interval'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['painScale'] = this.painScale;
    data['formated_time'] = this.formatedTime;
    data['formated_interval'] = this.formatedInterval;
    data['time_stamp'] = this.timeStamp;
    data['date'] = this.date;
    data['time'] = this.time;
    data['contraction'] = this.contraction;
    data['interval'] = this.interval;
    return data;
  }
}