class ExerciseModel {
  List<Exercises>? exercises;
  List<Exercises>? custom;
  String? url;
  dynamic calorieBurnt;
  bool? consentAccepted;

  ExerciseModel(
      {this.exercises,
        this.custom,
        this.url,
        this.calorieBurnt,
        this.consentAccepted});

  ExerciseModel.fromJson(Map<String, dynamic> json) {
    if (json['exercises'] != null) {
      exercises = [];
      json['exercises'].forEach((v) {
        exercises!.add(new Exercises.fromJson(v));
      });
    }
    if (json['custom'] != null) {
      custom = [];
      json['custom'].forEach((v) {
        custom!.add(new Exercises.fromJson(v));
      });
    }
    url = json['url'];
    calorieBurnt = json['calorieBurnt'];
    consentAccepted = json['consentAccepted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exercises != null) {
      data['exercises'] = this.exercises!.map((v) => v.toJson()).toList();
    }
    if (this.custom != null) {
      data['custom'] = this.custom!.map((v) => v.toJson()).toList();
    }
    data['url'] = this.url;
    data['calorieBurnt'] = this.calorieBurnt;
    data['consentAccepted'] = this.consentAccepted;
    return data;
  }
}

class Exercises {
  int? id;
  bool? completed;
  String? name;

  Exercises({this.id, this.completed, this.name});

  Exercises.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    completed = json['completed'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['completed'] = this.completed;
    data['name'] = this.name;
    return data;
  }
}
