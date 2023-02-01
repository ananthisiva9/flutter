class CallRecordModel{
  CallRecordModel({
    this.calls,
  });
  List<Calls>? calls;
  factory CallRecordModel.fromJson(List<dynamic>? jsonList) => CallRecordModel(
    calls: jsonList == null
        ? null
        : List<Calls>.from(jsonList.map((x) => Calls.fromJson(x))),
  );
  List<dynamic>? toJson() =>
      calls == null
          ? null
          : List<dynamic>.from(calls!.map((x) => x.toJson()));
}
class Calls {
  int? id;
  String? callResponse;
  String? note;
  String? date;

  Calls(
      {this.id,
        this.callResponse,
        this.note,
        this.date,
      });

  Calls.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    callResponse = json['callResponse'];
    note = json['note'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['callResponse'] = this.callResponse;
    data['note'] = this.note;
    data['date'] = this.date;
    return data;
  }
}