class SymptomsModel {
  List<Symptoms>? symptoms;
  List<CustomSymptom>? customSymptom;
  List<SymptomsWithIputs>? symptomsWithIputs;

  SymptomsModel({this.symptoms, this.customSymptom, this.symptomsWithIputs});

  SymptomsModel.fromJson(Map<String, dynamic> json) {
    if (json['Symptoms'] != null) {
      symptoms = [];
      json['Symptoms'].forEach((v) {
        symptoms!.add(new Symptoms.fromJson(v));
      });
    }
    if (json['customSymptom'] != null) {
      customSymptom = [];
      json['customSymptom'].forEach((v) {
        customSymptom!.add(new CustomSymptom.fromJson(v));
      });
    }
    if (json['symptomsWithIputs'] != null) {
      symptomsWithIputs = [];
      json['symptomsWithIputs'].forEach((v) {
        symptomsWithIputs!.add(new SymptomsWithIputs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.symptoms != null) {
      data['Symptoms'] = this.symptoms!.map((v) => v.toJson()).toList();
    }
    if (this.customSymptom != null) {
      data['customSymptom'] =
          this.customSymptom!.map((v) => v.toJson()).toList();
    }
    if (this.symptomsWithIputs != null) {
      data['symptomsWithIputs'] =
          this.symptomsWithIputs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symptoms {
  int? id;
  String? name;
  bool? positive;
  String? category;

  Symptoms({this.id, this.name, this.positive, this.category});

  Symptoms.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    positive = json['positive'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['positive'] = this.positive;
    data['category'] = this.category;

    return data;
  }
}

class CustomSymptom {
  int? id;
  bool? positive;
  String? symptom;

  CustomSymptom({this.id, this.positive, this.symptom});

  CustomSymptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positive = json['positive'];
    symptom = json['symptom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['positive'] = this.positive;
    data['symptom'] = this.symptom;
    return data;
  }
}

class SymptomsWithIputs {
  int? id;
  String? date;
  String? others;
  String? bloodSugar;
  String? bloodPressure;
  String? report;
  String? weight;

  SymptomsWithIputs(
      {this.id,
        this.date,
        this.others,
        this.bloodSugar,
        this.bloodPressure,
        this.report,
        this.weight});

  SymptomsWithIputs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    others = json['others'];
    bloodSugar = json['bloodSugar'];
    bloodPressure = json['bloodPressure'];
    report = json['report'];
    weight = json['weight'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['others'] = this.others;
    data['bloodSugar'] = this.bloodSugar;
    data['bloodPressure'] = this.bloodPressure;
    data['report'] = this.report;
    data['weight'] = this.weight;
    return data;
  }
}
