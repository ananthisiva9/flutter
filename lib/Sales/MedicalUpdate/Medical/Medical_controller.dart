import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import '../../Daily Tracker/Medical/Medical_model.dart';

class MedicalController with ChangeNotifier {
  late StateEnum state;
  MedicalController(
      {required this.customerid,
        required this.selectedDate,
        required this.context}) {
    getMedical(context: context, date: selectedDate);
  }
  String customerid;
  DateTime selectedDate;
  BuildContext context;

  String? scanReportPath;
  String? bloodReportPath;
  String? antenatalReportPath;
  String? questionPath;
  String? bpPath;
  String? weightPath;

  MedicalFormData? medicalModel;

  void changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  getMedical({required BuildContext context, required DateTime date}) async {
    changeState(StateEnum.loading);
    medicalModel = null;
    scanReportPath = null;
    bloodReportPath = null;
    antenatalReportPath = null;
    questionPath = null;
    bpPath= null;
    weightPath = null;

    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String dateParam = Global.getSelectedDate(date);
        String url = Sales.update_medical_get +
            '?customer=' +
            customerid +
            '&&date=' +
            dateParam;
        //?customer=22&date=2022-10-12
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);

        if (response is bool) {
          changeState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          changeState(StateEnum.success);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No medical details found on ' + dateParam),
            backgroundColor: Colors.red,
          ));
        } else {
          medicalModel = MedicalFormData.fromJson(response);
          changeState(StateEnum.success);
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
    // http://{{domain}}/customer/get-medical/?date=2022-01-07
  }
}
