class LoginModel {
  int? id;
  String? token;
  bool? sales;
  bool? admin;

  LoginModel({this.id,this.token, this.admin,this.sales});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    sales =json['sales'];
    admin = json['admin'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = this.token;
    data['sales'] = this.sales;
    data['admin'] = this.admin;
    data['id'] = this.id;
    return data;
  }
}