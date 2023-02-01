import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:flutter/material.dart';
import 'Display_model.dart';

class DisplayController with ChangeNotifier {
  DisplayController(this.context) {
    fetchDisplayActivity();
  }

  AllClientsModel? model;
  LoginUserDataModel? userDataModel;
  List<ClientDetails>? clients;
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
    fetchLoginDetails();
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Admin.display;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          print(response);
          model = AllClientsModel.fromJson(response);
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

  fetchLoginDetails() async {
    changeUserDataState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = ApiEndPoint.login_data;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        print(url);
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeUserDataState(StateEnum.error);
        } else {
          print(response);
          userDataModel = LoginUserDataModel.fromJson(response);
          changeUserDataState(StateEnum.success);
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
