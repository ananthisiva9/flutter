import 'package:admin_dashboard/Sales/AllClients/AllClients.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'Analysis_model.dart';

class AnalysisController with ChangeNotifier {
  AnalysisController({required this.context,required this.customerid}) {
    fetchAllCall();
  }

  BuildContext context;
  AnalysisModel? model;
  String customerid;
  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  Future<void> fetchAllCall() async {
    String? token = await getToken();
    if (token != null) {
      changeState(StateEnum.loading);
      LoginModel? userdetails = await Global.getUserDetails();
      if (userdetails != null) {
        if (userdetails.token != null) {
          String url = Sales.analysis + '?customer=' + customerid;
          print(customerid);
          Map<String, dynamic> header = {
            "Authorization": "Token ${token}"
          };
          dynamic response =
          await RestService.getMethod(url: url, headers: header);
          if (response is bool) {
            changeState(StateEnum.error);
          } else {
            model = AnalysisModel.fromJson(response);
            print(response);
            changeState(StateEnum.success);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Call Not Found'),
            backgroundColor: Colors.red,
          ));
          Future.delayed(Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AllClient()),
            );
          });
        }
      }
    }else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Call Not Found'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AllClient()),
        );
      });
    }
  }
}
