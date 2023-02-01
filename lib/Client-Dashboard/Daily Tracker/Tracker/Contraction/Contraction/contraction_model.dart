class ContractionModel{
  ContractionModel({
    this.items,
  });

  List<ContractionModeItems>? items;

  factory ContractionModel.fromJson(List<dynamic>? jsonList) => ContractionModel(
    items: jsonList == null
        ? null
        : List<ContractionModeItems>.from(jsonList.map((x) => ContractionModeItems.fromJson(x))),
  );

  List<dynamic>? toJson() =>
      items == null
          ? null
          : List<dynamic>.from(items!.map((x) => x.toJson()));
}
class ContractionModeItems {
  int? id;
  String? painScale;
  String? formatedTime;
  String? formatedInterval;
  String? timeStamp;
  String? date;
  String? time;
  int? contraction;
  String? interval;

  ContractionModeItems(
      {this.id,
      this.painScale,
      this.formatedTime,
      this.formatedInterval,
      this.timeStamp,
      this.date,
      this.time,
      this.contraction,
      this.interval});

  ContractionModeItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    painScale = json['pain_scale'];
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
    data['pain_scale'] = this.painScale;
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