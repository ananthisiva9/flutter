import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sgx/Login/Login.dart';
import 'package:sgx/Login/Login_model.dart';
import 'package:sgx/Utility/global.dart';

class SplashScreenController with ChangeNotifier {
  SplashScreenController(this.context) {
    Timer(Duration(seconds: 5), () => checkFirstTime());
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
      goToOnboarding();
    } else {
      if (userData.data!.token == null) {
        goToOnboarding();
      } else {
        if (userData.error == null) {
          goToOnboarding();
        } else {
          if (userData.error != null) {
            goToClientDashboard();
          }
        }
      }
    }
  }

  goToOnboarding() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Login()));
  }

  goToClientDashboard() {
    // Navigator.push(
    //context, MaterialPageRoute(builder: (context) => ClientDisplay()));
  }
}
