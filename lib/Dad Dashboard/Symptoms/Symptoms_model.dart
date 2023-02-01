class SymptomsModel {
  List<Data>? data;

  SymptomsModel({this.data});

  SymptomsModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  String? symptom;
  String? remedy;

  Data({this.id, this.symptom, this.remedy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symptom = json['symptom'];
    remedy = json['remedy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['symptom'] = this.symptom;
    data['remedy'] = this.remedy;
    return data;
  }
}

