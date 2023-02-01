import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'Symptoms_model.dart';

class SymptomController with ChangeNotifier {
  SymptomController({required this.customerid, required this.context,required this.selectedDate}) {
    fetchAllSymptom();
  }
  String customerid;
  BuildContext context;
  String selectedDate;


  SymptomModel? model;
  LastWeekReport? report;
  late StateEnum state;
   StateEnum? checkBoxState;

  List<Symptom> allSymptom = [];
  List<CustomSymptom> allCustom = [];
  List<LastWeekReport> allReport = [];

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
    fetchAllSymptom();
  }

  fetchAllSymptom() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.update_symptoms_get +
            '?customer=' +
            customerid +
            '&date=' +
            selectedDate;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = SymptomModel.fromJson(response);
          allSymptom.clear();
          if (model!.Symptoms != null) allSymptom.addAll(model!.Symptoms!);
          if (model!.customSymptom != null)
            allCustom.addAll(model!.customSymptom!);

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

  submitPredifinedSymptom(
      String id, bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.update_symptoms_predefined_post  +
            '?customer=' +
            customerid;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "symptom": id,
          "positive": status,
          "date": selectedDate
        };

        dynamic response =
            await RestService.postmethod(url: url, headers: header, body: body);
        if (response is bool) {
          allSymptom[index].positive = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          allSymptom[index].positive = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          allSymptom[index].positive = status;
          changeCheckBoxState(StateEnum.success);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Symptom submitted Successfully'),
            backgroundColor: Colors.green,
          ));
          Future.delayed(const Duration(seconds: 1), () {
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

  submitCustomSymptom(
      String id, bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.update_symptoms_custom_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "symptom": id,
          "positive": status,
          "date": selectedDate
        };

        dynamic response =
            await RestService.postmethod(url: url, headers: header, body: body);
        if (response is bool) {
          allSymptom[index].positive = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          allSymptom[index].positive = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          allSymptom[index].positive = status;
          changeCheckBoxState(StateEnum.success);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Symptom submitted Successfully'),
            backgroundColor: Colors.green,
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
}
