class LoginModel {
  String? token;
  bool? client;
  bool? consltant;
  bool? doctor;
  bool? dad;
  bool? has_subscription;
  int? id;
  String? subscription_package;
  String? sales;

  LoginModel({this.token, this.client, this.id,this.has_subscription,this.subscription_package,this.sales,this.dad});

  LoginModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    consltant =json['consltant'];
    client = json['client'];
    doctor = json['doctor'];
    has_subscription = json['has_subscription'];
    id = json['id'];
    subscription_package = json['subscription_package'];
    sales = json["sales"];
    dad = json["dad"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['token'] = this.token;
    data['consltant'] = this.consltant;
    data['client'] = this.client;
    data['doctor'] = this.doctor;
    data ['has_subscription'] = this.has_subscription;
    data['id'] = this.id;
    data['subscription_package']= this.subscription_package;
    data["sales"] = this.sales;
    data["dad"] = this.dad;
    return data;
  }
}