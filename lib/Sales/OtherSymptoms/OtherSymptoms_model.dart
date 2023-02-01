class OtherSymptomsModel {
  OtherSymptomsModel({
    this.items,
  });
  List<Symptoms>? items;
  factory OtherSymptomsModel.fromJson(List<dynamic>? jsonList) =>
      OtherSymptomsModel(
        items: jsonList == null
            ? null
            : List<Symptoms>.from(
            jsonList.map((x) => Symptoms.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}

class Symptoms {
  Symptoms({
    this.id,
    this.name,
    this.positive,
  });

  int? id;
  String? name;
  bool? positive;

  factory Symptoms.fromJson(Map<String, dynamic> json) => Symptoms(
    id: json["id"],
    name: json["name"],
    positive: json["positive"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "positive": positive,
  };
}
