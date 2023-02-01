class AddMedicalmodel {
  String? date;
  String? appointmentDate;
  String? scanDate;
  String? question;
  String? scanReport;
  String? bloodReport;
  String? antenatalChart;
  String? bp;
  String? weight;

  AddMedicalmodel(
      {this.date,
        this.appointmentDate,
        this.question,
        this.bp,
        this.weight,
        this.scanDate,
        this.scanReport,
        this.bloodReport,
        this.antenatalChart});

  AddMedicalmodel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    appointmentDate = json['appointmentDate'];
    scanDate = json['scanDate'];
    question = json['question'];
    scanReport = json['scanReport'];
    bloodReport = json['bloodReport'];
    antenatalChart = json['antenatalChart'];
    bp = json['bp'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['date'] = this.date;
    data['appointmentDate'] = this.appointmentDate;
    data['scanDate'] = this.scanDate;
    data['question'] = this.question;
    data['scanReport'] = this.scanReport;
    data['bloodReport'] = this.bloodReport;
    data['antenatalChart'] = this.antenatalChart;
    data['bp'] = this.bp;
    data['weight'] = this.weight;
    return data;
  }
}

class MedicalFormData {
  int? id;
  String? date;
  String? appointmentDate;
  String? scantDate;
  String? ultraSound;
  String? bloodReport;
  String? antenatalChart;
  int? bp;
  int? weight;
  String? question;

  MedicalFormData(
      {this.id,
        this.date,
        this.appointmentDate,
        this.scantDate,
        this.ultraSound,
        this.bloodReport,
        this.antenatalChart,
        this.bp,
        this.weight,
        this.question});

  MedicalFormData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    appointmentDate = json['appointmentDate'];
    scantDate = json['scantDate'].toString();
    ultraSound = json['ultraSound'];
    bloodReport = json['bloodReport'];
    antenatalChart = json['antenatalChart'].toString();
    bp = json['bp'];
    weight = json['weight'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = this.id;
    data['date'] = this.date;
    data['appointmentDate'] = this.appointmentDate;
    data['scantDate'] = this.scantDate;
    data['ultraSound'] = this.ultraSound;
    data['bloodReport'] = this.bloodReport;
    data['antenatalChart'] = this.antenatalChart;
    data['bp'] = this.bp;
    data['weight'] = this.weight;
    data['question'] = this.question;
    return data;
  }
}
