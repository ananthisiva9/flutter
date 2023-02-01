import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'Activity_model.dart';

class ActivityController with ChangeNotifier {
  late StateEnum state;
  ActivityController(
      {required this.customerid,
      required this.selectedDate,
      required this.context}) {
    fetchAllActivity();
  }
  String customerid;
  DateTime selectedDate;
  BuildContext context;


  ActivityModel? model;
  late StateEnum videoState;
  late StateEnum checkBoxState;

  List<Custom> allCustom = [];
  List<Predefined> allActivity = [];

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  changeVideoState(StateEnum stateEnum) {
    videoState = stateEnum;
    notifyListeners();
  }

  changeCheckBoxState(StateEnum stateEnum) {
    checkBoxState = stateEnum;
    notifyListeners();
  }

  changeSelectedDate(DateTime selectedDate) {
    selectedDate = selectedDate;
    notifyListeners();
  }

  initialize() {
    changeCheckBoxState(StateEnum.success);
    fetchAllActivity();
  }

  fetchAllActivity() async {
    changeState(StateEnum.loading);
    changeVideoState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.update_activity_get +
            "?customer=$customerid" +
            "&date=${Global.getSelectedDate(selectedDate)}";
        //TODO:
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = ActivityModel.fromJson(response);
          allActivity.clear();
          allCustom.clear();
          if (model!.predefined != null) allActivity.addAll(model!.predefined!);
          if (model!.custom != null) allCustom.addAll(model!.custom!);

          changeState(StateEnum.success);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:  Text(
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
    } else {
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

  submitPredifinedActivity(
      String id, bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.update_activity_predefined_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "activity": id,
          "completed": status,
          "date": Global.getSelectedDate(selectedDate)
        };

        dynamic response =
            await RestService.postmethod(url: url, headers: header, body: body);
        if (response is bool) {
          allCustom[index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          allCustom[index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          allCustom[index].completed = status;
          changeCheckBoxState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Activity submitted Successfully'),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:  Text(
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
    } else {
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

  submitCustomActivity(
      String id, bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.update_activity_custom_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "activity": id,
          "completed": status,
          "date": Global.getSelectedDate(selectedDate)
        };

        dynamic response =
            await RestService.postmethod(url: url, headers: header, body: body);
        if (response is bool) {
          allCustom[index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:  Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          allCustom[index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          allCustom[index].completed = status;
          changeCheckBoxState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:  Text('Activity submitted Successfully'),
            backgroundColor: Colors.green,
          ));
        }
      } else {
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:  Text(
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
