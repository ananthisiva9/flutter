import 'dart:async';
import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/OnBoard/onboard.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/global.dart';

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
        if (userData.sales == null && userData.admin == null) {
          goToLogin();
        } else {
          if (userData.sales != null && userData.sales!) {
            goToSalesDashboard();
          } else if (userData.admin != null && userData.admin!) {
            goToAdminDashboard();
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

  goToSalesDashboard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SalesDisplay()));
  }

  goToAdminDashboard() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminDisplay()));
  }
}