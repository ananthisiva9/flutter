class EditExerciseModel {
  EditExerciseModel({
    this.items,
  });
  List<Exercise>? items;
  factory EditExerciseModel.fromJson(List<dynamic>? jsonList) =>
      EditExerciseModel(
        items: jsonList == null
            ? null
            : List<Exercise>.from(jsonList.map((x) => Exercise.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}

class Exercise {
  Exercise({
    this.id,
    this.name,
    this.disabled,
  });

  int? id;
  String? name;
  bool? disabled;

  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
        id: json["id"],
        name: json["name"],
        disabled: json["disabled"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "disabled": disabled,
      };
}
