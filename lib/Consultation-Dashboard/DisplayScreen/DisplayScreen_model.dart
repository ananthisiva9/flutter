class DisplayModel {
  var total_clients;
  var clients_this_month;
  var firstname;
  var lastname;

  DisplayModel(
      {
      this.total_clients,
      this.clients_this_month,
      this.firstname,
      this.lastname,
    });

  DisplayModel.fromJson(Map<String, dynamic> json) {
    total_clients = json['total_clients'];
    clients_this_month = json['clients_this_month'];
    firstname = json['firstname'];
    lastname = json['lastname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['total_clients'] = this.total_clients;
    data['clients_this_month'] = this.clients_this_month;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    return data;
  }
}
class LoginUserDataModel {
  String? firstname;
  String? lastname;
  String? email;

  LoginUserDataModel({this.firstname, this.lastname, this.email});

  LoginUserDataModel.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    return data;
  }
}
