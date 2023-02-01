class DietModel {
  List<Diet>? diet;
  CustomizedDiet? customizedDiet;

  DietModel({this.diet, this.customizedDiet});

  DietModel.fromJson(Map<String, dynamic> json) {
    if (json['Diet'] != null) {
      diet = [];
      json['Diet'].forEach((v) {
        diet!.add(new Diet.fromJson(v));
      });
    }
    customizedDiet = json['CustomizedDiet'] != null
        ? new CustomizedDiet.fromJson(json['CustomizedDiet'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.diet != null) {
      data['Diet'] = this.diet!.map((v) => v.toJson()).toList();
    }
    if (this.customizedDiet != null) {
      data['CustomizedDiet'] = this.customizedDiet!.toJson();
    }
    return data;
  }
}

class Diet {
  int? id;
  String? mealName;
  String? date;
  String? food;
  String? time;

  Diet({this.id, this.mealName, this.date, this.food, this.time});

  Diet.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealName = json['mealName'];
    date = json['date'];
    food = json['food'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['mealName'] = this.mealName;
    data['date'] = this.date;
    data['food'] = this.food;
    data['time'] = this.time;
    return data;
  }
}

class CustomizedDiet {
  String? url;
  String? customer;
  String? module;

  CustomizedDiet({this.url, this.customer, this.module});

  CustomizedDiet.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    customer = json['customer'];
    module = json['module'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['customer'] = this.customer;
    data['module'] = this.module;
    return data;
  }
}