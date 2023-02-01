import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'MedicalDetails_model.dart';

class MedicalDetailsController with ChangeNotifier {
  MedicalDetailsController(
      {required this.customerid,
        required this.context}) {
    fetchAllDetails();
  }
  int customerid;
  BuildContext context;
  Details? model;
  late StateEnum state;
  late StateEnum checkBoxState;

  List<Details> allDetails= [];

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
    fetchAllDetails();
  }

  fetchAllDetails() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.flowup_medical_get +
            '&customer=$customerid'; //TODO:
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = Details.fromJson(response);
          allDetails.clear();
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
  Details? filterDetails(String details) {
    var element;
    List<Details> tempList = (element.category == details) as List<Details>;
    if (tempList.isNotEmpty) {
      return tempList.first;
    } else {
      return null;
    }
  }
  submitDetails(
      String id, bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.flowup_medical_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "customer": customerid,
          "id": id,
          "flag": status
        };

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          allDetails[index].flag = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          allDetails[index].
          flag= false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          allDetails[index].flag = status;
          changeCheckBoxState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Medicines submitted Successfully'),
            backgroundColor: Colors.green,
          ));
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SalesDisplay()));
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