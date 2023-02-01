class EditActivityeModel {
  EditActivityeModel({
    this.items,
  });
  List<Activity>? items;
  factory EditActivityeModel.fromJson(List<dynamic>? jsonList) =>
      EditActivityeModel(
        items: jsonList == null
            ? null
            : List<Activity>.from(jsonList.map((x) => Activity.fromJson(x))),
      );
  List<dynamic>? toJson() =>
      items == null ? null : List<dynamic>.from(items!.map((x) => x.toJson()));
}

class Activity {
  Activity({
    this.id,
    this.name,
    this.disabled,
  });

  int? id;
  String? name;
  bool? disabled;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
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
