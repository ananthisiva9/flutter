class SymptomModel {
  List<Symptom>? Symptoms;
  List<CustomSymptom>? customSymptom;
  List<LastWeekReport>? lastWeekSymptomReport;

  SymptomModel(
      {this.Symptoms,
        this.customSymptom,
        this.lastWeekSymptomReport,
        });

  SymptomModel.fromJson(Map<String, dynamic> json) {
    if (json['Symptoms'] != null) {
      Symptoms = [];
      json['Symptoms'].forEach((v) {
        Symptoms!.add(Symptom.fromJson(v));
      });
    }
    if (json['customSymptom'] != null) {
      customSymptom = [];
      json['customSymptom'].forEach((v) {
        customSymptom!.add(CustomSymptom.fromJson(v));
      });
    }
    if (json['last_week_symptom_report'] != null) {
      lastWeekSymptomReport = [];
      json['last_week_symptom_report'].forEach((v) {
        lastWeekSymptomReport!.add(LastWeekReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.Symptoms != null) {
      data['Symptoms'] = this.Symptoms!.map((v) => v.toJson()).toList();
    }
    if (this.customSymptom != null) {
      data['customSymptom'] = this.customSymptom!.map((v) => v.toJson()).toList();
    }
    if (this.lastWeekSymptomReport != null) {
      data['last_week_symptom_report'] = this.lastWeekSymptomReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class LastWeekReport {
  LastWeekReport({
    this.symptom,
    this.count,
  });

  String? symptom;
  int? count;

  LastWeekReport.fromJson(Map<String, dynamic> json) {
    symptom = json["symptom"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() => {
    "symptom": symptom,
    "count": count,
  };
}


class Symptom {
  int?  id;
  bool?  positive;
  String?  name;
  String? category;

  Symptom({this.id, this.positive, this.name,this.category});

  Symptom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    positive = json['positive'];
    name = json['name'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['positive'] = this.positive;
    data['name'] = this.name;
    data['category'] = this.category;
    return data;
  }
}
class CustomSymptom {
int?  id;
bool?  positive;
String?  name;

CustomSymptom({this.id, this.positive, this.name});

CustomSymptom.fromJson(Map<String, dynamic> json) {
id = json['id'];
positive = json['positive'];
name = json['name'];
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['id'] = this.id;
  data['positive'] = this.positive;
  data['name'] = this.name;
  return data;
}
}

