import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'Payments_model.dart';

class PaymentsController with ChangeNotifier {
  PaymentsController(this.context) {
    fetchAllPayments();
  }
  BuildContext context;
  PaymentsModel? model;
  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  fetchAllPayments() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.payments_get;
        Map<String, dynamic> header = {
           "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = PaymentsModel.fromJson(response);
          changeState(StateEnum.success);
        }
      }else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Login Details not found. You will be rerouted to the login page'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      }
    }else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Login Details not found. You will be rerouted to the login page'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      }
  }
}