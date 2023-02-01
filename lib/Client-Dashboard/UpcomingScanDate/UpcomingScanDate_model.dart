class UpcomingScanDateModel {
  String? doctor;
  String? dueDate;
  String? lastMenstrualDate;
  String? probableDate;
  int? foetalWeek;
  int? foetalDays;
  String? datingScan;
  String? ntScan;
  String? morphologyScan;
  String? anomalyScan;
  String? growthScan;
  String? lastScan;
  String? lastScanDetails;

  UpcomingScanDateModel(
      {this.doctor,
      this.dueDate,
      this.lastMenstrualDate,
      this.probableDate,
      this.foetalWeek,
      this.foetalDays,
      this.datingScan,
      this.ntScan,
      this.morphologyScan,
      this.anomalyScan,
      this.growthScan,
      this.lastScan,
      this.lastScanDetails});

  UpcomingScanDateModel.fromJson(Map<String, dynamic> json) {
    doctor = json['doctor'];
    dueDate = json['dueDate'];
    lastMenstrualDate = json['lastMenstrualDate'];
    probableDate = json['probableDate'];
    foetalWeek = json['foetal_week'];
    foetalDays = json['foetal_days'];
    datingScan = json['datingScan'];
    ntScan = json['ntScan'];
    morphologyScan = json['morphologyScan'];
    anomalyScan = json['anomalyScan'];
    growthScan = json['growthScan'];
    lastScan = json['lastScan'];
    lastScanDetails = json['lastScanDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctor'] = this.doctor;
    data['dueDate'] = this.dueDate;
    data['lastMenstrualDate'] = this.lastMenstrualDate;
    data['probableDate'] = this.probableDate;
    data['foetal_week'] = this.foetalWeek;
    data['foetal_days'] = this.foetalDays;
    data['datingScan'] = this.datingScan;
    data['ntScan'] = this.ntScan;
    data['morphologyScan'] = this.morphologyScan;
    data['anomalyScan'] = this.anomalyScan;
    data['growthScan'] = this.growthScan;
    data['lastScan'] = this.lastScan;
    data['lastScanDetails'] = this.lastScanDetails;
    return data;
  }
}
