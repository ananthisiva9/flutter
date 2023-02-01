import 'package:flutter/material.dart';
import 'package:shebirth/Consultation-Dashboard/SortByWeek.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'AllClient_model.dart';

class AllClientController with ChangeNotifier {
  AllClientController(this.context) {
    fetchAllClients();
  }

  BuildContext context;

  AllClientModel? model;
  List<AllClient>? sortedClients;

  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  Future<void> fetchAllClients() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = consultantAPi.display;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = AllClientModel.fromJson(response);
          if (model != null) {
            sortedClients = model!.allClients;
          }
          print(response);
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

  Future<void> sortByWeek() async {
    List<int>? weekRange = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SortByWeek()),
    );
    if (weekRange != null) {
      sortedClients = model!.allClients!.where((client) {
        {
          if (client.week != null) {
            return true;
          } else {
            return false;
          }
        }
      }).toList();
      notifyListeners();
    }
  }
}
