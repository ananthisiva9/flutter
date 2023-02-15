class ContestTypeModel {
  ContestTypeModel({
    required this.count,
    required this.data,
  });

  int count;
  List<Datum> data;

  factory ContestTypeModel.fromJson(Map<String, dynamic> json) => ContestTypeModel(
    count: json["count"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.attemptUser,
    required this.attempts,
    required this.contestName,
    required this.contestType,
    required this.fromDatetime,
    required this.id,
    required this.image,
    required this.languageId,
    required this.languageName,
    required this.questioncount,
    required this.rules,
    required this.stateId,
    required this.stateName,
    required this.toDatetime,
  });

  int attemptUser;
  int attempts;
  String contestName;
  int contestType;
  DateTime fromDatetime;
  int id;
  String image;
  List<int> languageId;
  List<String> languageName;
  int questioncount;
  String rules;
  List<int> stateId;
  List<String> stateName;
  DateTime toDatetime;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    attemptUser: json["attempt_user"],
    attempts: json["attempts"],
    contestName: json["contest_name"],
    contestType: json["contest_type"],
    fromDatetime: DateTime.parse(json["from_datetime"]),
    id: json["id"],
    image: json["image"],
    languageId: List<int>.from(json["language_id"].map((x) => x)),
    languageName: List<String>.from(json["language_name"].map((x) => x)),
    questioncount: json["questioncount"],
    rules: json["rules"],
    stateId: List<int>.from(json["state_id"].map((x) => x)),
    stateName: List<String>.from(json["state_name"].map((x) => x)),
    toDatetime: DateTime.parse(json["to_datetime"]),
  );

  Map<String, dynamic> toJson() => {
    "attempt_user": attemptUser,
    "attempts": attempts,
    "contest_name": contestName,
    "contest_type": contestType,
    "from_datetime": fromDatetime.toIso8601String(),
    "id": id,
    "image": image,
    "language_id": List<dynamic>.from(languageId.map((x) => x)),
    "language_name": List<dynamic>.from(languageName.map((x) => x)),
    "questioncount": questioncount,
    "rules": rules,
    "state_id": List<dynamic>.from(stateId.map((x) => x)),
    "state_name": List<dynamic>.from(stateName.map((x) => x)),
    "to_datetime": toDatetime.toIso8601String(),
  };
}
