import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'Activity_model.dart';

class AddActivityController with ChangeNotifier {
  late StateEnum state;
  AddActivityController() {
    changeState(StateEnum.success);
  }

  void changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  addNewActivity(String name, BuildContext context) async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.add_activity_post;
        Map<String, dynamic> header = {
         "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        ActivityModel? model = ActivityModel(name: name);
        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: model.toJson());
        if (response is bool) {
          changeState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else {
          changeState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Activity added Successfully'),
            backgroundColor: Colors.green,
          ));
        }
      } else {
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
    } else {
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
