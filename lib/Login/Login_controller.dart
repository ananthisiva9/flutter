import 'dart:convert';
import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool isPasswordObscured = true;

  void togglePassword() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }

  loginMethod(String email, String password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      changeState(StateEnum.loading);
      String url = ApiEndPoint.login;
      Map<String, dynamic> header = {"Content-Type": "application/json"};
      Map<String, dynamic> body = {"email": email, "password": password};
      dynamic response =
          await RestService.postmethod(url: url, headers: header, body: body);
      if (response is bool) {
        changeState(StateEnum.error);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Incorrect Password'),
          backgroundColor: Colors.red,
        ));
      } else {
        if (response is Map<String, dynamic> && response['token'] != null) {
          model = LoginModel.fromJson(response);
          saveLocally(model!.toJson());
          if (model!.sales != null &&
              model!.sales == true) {
            //User is Sales
            changeState(StateEnum.success);
            Navigator.push(
             context,
             MaterialPageRoute(
                builder: (context) => SalesDisplay()),
             );
          }  else if (model!.admin != null && model!.admin == true) {
            //User is doctor
            changeState(StateEnum.success);
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AdminDisplay()),
            );
          }
        } else {
          changeState(StateEnum.error);
          if (response is Map) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.values.toString()),
              backgroundColor: Colors.red,
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response.toString()),
              backgroundColor: Colors.red,
            ));
          }
        }
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
