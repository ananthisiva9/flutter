import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:railway_super_app/Login/Login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Global {
  static SharedPreferences? prefs;

  static Future<void> getPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  static Future<dynamic> getUserDetails() async {
    await getPreferences();
    String? userDetails = prefs!.getString("userDetails");
    if (userDetails != null) {
      log(jsonDecode(userDetails).toString());
      return LoginModel.fromJson(jsonDecode(userDetails));
    }
  }

  static String getSelectedDate(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } else {
      return DateFormat('yyyy-MM-dd').format(DateTime.now());
    }
  }

  static String getSelectedTime(DateTime? dateTime) {
    if (dateTime != null) {
      return DateFormat.jm().format(dateTime);
    } else {
      return DateFormat.jm().format(DateTime.now());
    }
  }
}