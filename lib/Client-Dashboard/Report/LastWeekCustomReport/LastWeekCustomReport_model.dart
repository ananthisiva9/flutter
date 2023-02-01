class LastWeekReportModel {
  List<LastWeekSymptomReport>? lastWeekSymptomReport;
  LastWeekReportModel({
    this.lastWeekSymptomReport,
  });

  LastWeekReportModel.fromJson(Map<String, dynamic> json) {
    if (json['last_week_custom_symptom_report'] != null) {
      lastWeekSymptomReport = [];
      json['last_week_custom_symptom_report'].forEach((v) {
        lastWeekSymptomReport!.add(LastWeekSymptomReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lastWeekSymptomReport != null) {
      data['last_week_custom_symptom_report'] =
          this.lastWeekSymptomReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LastWeekSymptomReport {
  LastWeekSymptomReport({
    this.symptom,
    this.count,
  });

  String? symptom;
  int? count;

  LastWeekSymptomReport.fromJson(Map<String, dynamic> json) {
    symptom = json["symptom"];
    count = json["count"];
  }

  Map<String, dynamic> toJson() => {
    "symptom": symptom,
    "count": count,
  };
}