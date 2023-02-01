import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';

import 'Medicine_model.dart';

class MedicineController with ChangeNotifier {
  MedicineController(
      {required this.context,
        required this.customerid,
        required this.selectedDate}) {
    fetchMedicine();
  }
  String customerid;
  String selectedDate;

  BuildContext context;
  MedicineModel? model;
  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  changeDate(DateTime date) {
    selectedDate = Global.getSelectedDate(date);
    notifyListeners();
  }

  fetchMedicine() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.medicine_get +
            "?customer=$customerid" +
            "&date=$selectedDate";
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          print(response);
          model = MedicineModel.fromJson(response);
          changeState(StateEnum.success);
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

  MedicineModelItem? filterMedicine(String medicationTime) {
    List<MedicineModelItem> tempList = model!.items!
        .where((element) => element.medicationTime == medicationTime)
        .toList();
    if (tempList.isNotEmpty) {
      return tempList.first;
    } else {
      return null;
    }
  }
}