import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'contraction_model.dart';

class ContractionController with ChangeNotifier {
  ContractionController({required this.customerid,required this.selectedDate, required this.context}) {
    fetchAllContraction();
  }

  String customerid;
  String selectedDate;
  changeDate(DateTime date) {
    selectedDate = Global.getSelectedDate(date);
    notifyListeners();
  }

  ContractionModel? model;
  Map<String, List<ContractionModeItems>> sortedMap = {};
  List<String> keyList = [];
  List<List<ContractionModeItems>>valueList = [];
  late StateEnum state;
  BuildContext context;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  fetchAllContraction() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = Sales.contraction_get + "?customer=$customerid";
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        print(url);
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = ContractionModel.fromJson(response);
          print(response);

          sortContractions();

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

  sortContractions() {
    if (model != null) {
      if (model!.items != null) {
        if (model!.items!.isNotEmpty) {
          // List nonNull = model!.items!
          //     .where((element) => (element.timeStamp != null))
          //     .toList();
          // nonNull.sort((a, b) {
          //   return (a.timeStamp)!.compareTo(b.timeStamp!);
          // });

          for (ContractionModeItems element in model!.items!) {
            if (element.date != null) {
              if (sortedMap.containsKey(element.date!)) {
                if (sortedMap[element.date!] == null) {
                  sortedMap[element.date!] = [];
                }
              } else {
                sortedMap[element.date!] = [];
              }
              sortedMap[element.date!]!.add(element);
            }
          }
          keyList.addAll(sortedMap.keys);
          valueList.addAll(sortedMap.values);
        }
      }
    }
  }
}
