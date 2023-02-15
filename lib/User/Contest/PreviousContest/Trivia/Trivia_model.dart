class TriviaModel {
  TriviaModel({
    required this.data,
  });

  List<Datum> data;

  factory TriviaModel.fromJson(Map<String, dynamic> json) => TriviaModel(
    data: List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.date,
    required this.errorCode,
    required this.name,
    required this.score,
  });

  String date;
  int errorCode;
  String name;
  int score;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"],
    errorCode: json["error_code"],
    name: json["name"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "error_code": errorCode,
    "name": name,
    "score": score,
  };
}
