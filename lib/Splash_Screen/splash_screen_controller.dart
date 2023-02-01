import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/Consultation-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Dad%20Dashboard/Display.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/OnBoard/onboard.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/global.dart';

class SplashScreenController with ChangeNotifier {
  SplashScreenController(this.context) {
    Timer(Duration(seconds: 3), () => checkFirstTime());
    // checkForExistingUserData();
  }
  BuildContext context;

  Future<void> checkFirstTime() async {
    await Global.getPreferences();
    bool showOnboarding = !(Global.prefs!.containsKey("firsttime"));
    if (showOnboarding) {
      await Global.prefs!.setBool("firsttime", true);
      goToOnboarding();
    } else {
      checkForExistingUserData();
    }
  }

  Future<void> checkForExistingUserData() async {
    LoginModel? userData = await Global.getUserDetails();
    if (userData == null) {
      goToLogin();
    } else {
      if (userData.token == null) {
        goToLogin();
      } else {
        if (userData.client == null && userData.doctor == null) {
          goToLogin();
        } else {
          if (userData.client != null && userData.client!) {
            goToClientDashboard();
          } else if (userData.doctor != null && userData.doctor!) {
            goToDoctorDashboard();
          }
          else if (userData.consltant != null && userData.consltant!){
            goToConsultantDashboard();
          }
          else if (userData.dad != null && userData.dad!){
            goToDadDashboard();
          }
        }
      }
    }
  }

  goToOnboarding() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Onbording()));
  }

  goToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  goToClientDashboard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ClientDisplay()));
  }

  goToDoctorDashboard() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Display()));
  }
  goToConsultantDashboard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ConsultDisplay()));
  }
  goToDadDashboard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DadDisplay()));
  }
}