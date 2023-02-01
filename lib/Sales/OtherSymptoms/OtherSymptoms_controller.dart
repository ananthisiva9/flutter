import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'OtherSymptoms_model.dart';

class OtherSymptomsController with ChangeNotifier {
  OtherSymptomsController({required this.customerid,required this.context}) {
  }
  String customerid;
  DateTime? _date;
  DateTime get date => _date ?? DateTime.now();

  changeDate(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  TextEditingController caloriesController = TextEditingController();

  BuildContext context;
  OtherSymptomsModel? model;
   StateEnum? state;
   StateEnum? checkBoxState;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  changeCheckBoxState(StateEnum stateEnum) {
    checkBoxState = stateEnum;
    notifyListeners();
  }

  initialize() {
    changeCheckBoxState(StateEnum.success);
    fetchOtherSymptoms();
  }

  fetchOtherSymptoms() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String dateParam = Global.getSelectedDate(_date);

        String url = Sales.other_symptoms + '?customer=$customerid';
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = OtherSymptomsModel.fromJson(response);
          changeState(StateEnum.success);
        }
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
          MaterialPageRoute(builder: (context) => SalesDisplay()),
        );
      });
    }
  }

  submitSymptoms( bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.other_symptoms_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "customer" : customerid,
          "symptom": model!.items![index].id,
          "positive": status ? 'true' : 'false',
          "date": Global.getSelectedDate(_date)
        };

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          model!.items![index].positive = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          model!.items![index].positive= false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          model!.items![index].positive = status;
          changeCheckBoxState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Symptoms submitted Successfully'),
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
            MaterialPageRoute(builder: (context) => SalesDisplay()),
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
          MaterialPageRoute(builder: (context) => SalesDisplay()),
        );
      });
    }
  }
}