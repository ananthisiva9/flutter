import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'TodaysAppointment_model.dart';

class TodaysAppointmentController with ChangeNotifier {
  TodaysAppointmentController(this.context) {
    fetchTodaysAppointment();
  }

  BuildContext context;
  TodaysAppointmentModel? model;
  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  List<TodaysAppointmentItem> dummylist = [];

  fetchTodaysAppointment() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = doctorApi.today_appointment_get;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = TodaysAppointmentModel.fromJson(response);
          print(response);
          if (model!.items != null) {
            dummylist = model!.items!;
            changeState(StateEnum.success);
            notifyListeners();
          }
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

  launchMeeting(String url) async {
    if (!await launch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Could not launch the meeting. Please try again later'),
        backgroundColor: Colors.red,
      ));
    }
  }
}