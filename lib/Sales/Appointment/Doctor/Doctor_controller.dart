import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'Doctor_model.dart';

class GetDoctorController with ChangeNotifier {
  GetDoctorController(this.context) {
    fetchGetDoctor();
  }
  BuildContext context;
  GetDoctorModel? model;
  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  fetchGetDoctor() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Admin.get_doctor;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = GetDoctorModel.fromJson(response);
          changeState(StateEnum.success);
        }
      }else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Login Details not found. You will be rerouted to the login page'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      }
    }else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Login Details not found. You will be rerouted to the login page'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login()),
        );
      });
    }
  }
}