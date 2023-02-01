class ActivityModel {
  List<Predefined>? predefined;
  List<Custom>? custom;

  ActivityModel({this.predefined,
    this.custom,
  });

  ActivityModel.fromJson(Map<String, dynamic> json) {
    if (json['Predefined'] != null) {
      predefined = [];
      json['Predefined'].forEach((v) {
        predefined!.add(Predefined.fromJson(v));
      });
    }
    if (json['custom'] != null) {
      custom = [];
      json['custom'].forEach((v) {
        custom!.add(Custom.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.predefined != null) {
      data['Predefined'] = this.predefined!.map((v) => v.toJson()).toList();
    }
    if (this.custom != null) {
      data['custom'] = this.custom!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Custom {
  int?  id;
  bool?  completed;
  String?  name;

  Custom({this.id, this.completed, this.name});

  Custom.fromJson(Map<String, dynamic> json) {
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

class Predefined{
  int?  id;
  bool?  completed;
  String?  name;

  Predefined({this.id, this.completed, this.name});

  Predefined.fromJson(Map<String, dynamic> json) {
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
