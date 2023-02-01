class AnalysisModel {
  AnalysisModel({
    this.calls,
  });
  List<Calls>? calls;
  factory AnalysisModel.fromJson(List<dynamic>? jsonList) => AnalysisModel(
        calls: jsonList == null
            ? null
            : List<Calls>.from(jsonList.map((x) => Calls.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      calls == null ? null : List<dynamic>.from(calls!.map((x) => x.toJson()));
}

class Calls {
  int? id;
  String? date;
  String? criticallity;
  String? formated_date;

  Calls({
    this.id,
    this.date,
    this.criticallity,
    this.formated_date
  });

  Calls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    criticallity = json['criticallity'];
    formated_date = json['formated_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['criticallity'] = this.criticallity;
    data['formated_date']=this.formated_date;
    data['date'] = this.date;
    return data;
  }
}
