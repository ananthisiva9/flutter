
class SymptomModel {
  String? symptom;

  SymptomModel({this.symptom});

  SymptomModel.fromJson(Map<String, dynamic> json) {
    symptom = json['symptom'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symptom'] = this.symptom;
    return data;
  }
}