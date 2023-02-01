class Details {
  int? id;
  bool? flag;
  String? category;
  String? name;

  Details({this.id, this.flag, this.category, this.name});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    flag = json['flag'];
    category = json['category'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['flag'] = this.flag;
    data['category'] = this.category;
    data['name'] = this.name;
    return data;
  }
}