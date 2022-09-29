import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:sgx/DisplayScreen.dart';
import 'package:sgx/Utility/api_endpoint.dart';
import 'package:sgx/Utility/global.dart';
import 'package:http/http.dart' as http;
import 'package:sgx/Utility/state_enum.dart';
import 'Login_model.dart';

class LoginController with ChangeNotifier {
  late StateEnum state;
  BuildContext context;
  LoginController(this.context) {
    changeState(StateEnum.success);
  }

  void changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  LoginModel? model;

  loginMethod(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      changeState(StateEnum.loading);
      String url = ApiEndPoint.login;
      Map<String, dynamic> jsonResponse;
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/x-www-form-urlencoded"},
          body: {"email": email, "password": password});
      jsonResponse = json.decode(response.body);
      if (response.statusCode == 201) {
        print('++++++');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('login Successfully'),
          backgroundColor: Colors.green,
        ));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Display()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something Went Wrong!!!'),
          backgroundColor: Colors.green,
        ));
      }
    } else {
      changeState(StateEnum.error);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please fill in your email and password'),
        backgroundColor: Colors.red,
      ));
    }
  }

  void saveLocally(Map<String, dynamic> json) async {
    await Global.getPreferences();
    Global.prefs!.setString("userDetails", jsonEncode(json));
  }
}
