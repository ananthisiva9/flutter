import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:flutter/material.dart';
import 'Subscriptions_model.dart';

class SubscriptionController with ChangeNotifier {
  SubscriptionController(this.context) {
    fetchDisplayActivity();
  }

  SubscriptionModel? model;
  late StateEnum state;
  late StateEnum userDataState;
  BuildContext context;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  changeUserDataState(StateEnum stateEnum) {
    userDataState = stateEnum;
    notifyListeners();
  }

  fetchDisplayActivity() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Admin.subscription;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = SubscriptionModel.fromJson(response);
          changeState(StateEnum.success);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Login Details not found. You will be rerouted to the login page'),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Login Details not found. You will be rerouted to the login page'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
