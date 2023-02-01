import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/Consultation-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Dad%20Dashboard/Display.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/FreePackage-Dashboard/Package-Display.dart';
import 'package:shebirth/Packages/Package.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';

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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Incorrect Password'),
          backgroundColor: Colors.red,
        ));
      } else {
        if (response is Map<String, dynamic> && response['token'] != null) {
          model = LoginModel.fromJson(response);
          saveLocally(model!.toJson());
          if (model!.client != null &&
              model!.client == true &&
              model!.has_subscription == true &&
              model!.subscription_package == "full pregnancy package") {
            //User is client
            changeState(StateEnum.success);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientDisplay()),
            );
          } else if (model!.client != null &&
              model!.client == true &&
              model!.has_subscription == true &&
              model!.subscription_package == 'free version') {
            changeState(StateEnum.success);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PackageDisplay()),
            );
          } else if (model!.doctor != null && model!.doctor == true) {
            //User is doctor
            changeState(StateEnum.success);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Display()),
            );
          } else if (model!.consltant != null && model!.consltant == true) {
            //User is Consultant
            changeState(StateEnum.success);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ConsultDisplay()),
            );
          } else if (model!.has_subscription == false &&
              model!.client == true) {
            changeState(StateEnum.success);
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(
                  "Your Account is Disabled. Kindly Wait for 2 Working days until we activate your account, elsr contact +91 7022423264 or Mail us  smartbirth@shebirth.com",
                  style: GoogleFonts.poppins(fontSize: 12),
                  textAlign: TextAlign.justify,
                ),
              ),
            );
          } else if (model!.dad != null &&
              model!.subscription_package == null &&
              model!.sales == null &&
              model!.dad == true) {
            //User is dad
            changeState(StateEnum.success);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DadDisplay()),
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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
