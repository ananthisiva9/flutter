import 'package:flutter/material.dart';
import 'package:shebirth/Doctor-Dashboard/ClientsList/ClientList_model.dart';
import 'package:shebirth/Doctor-Dashboard/ClientsList/SortByWeek.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';

class ClientListController with ChangeNotifier {
  ClientListController(this.context) {
    fetchAllClients();
  }

  BuildContext context;

  ClientListModel? model;
  List<Customers>? sortedClients;

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
        String url = doctorApi.all_client_list;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = ClientListModel.fromJson(response);
          if (model != null) {
            sortedClients = model!.customers;
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
      sortedClients = model!.customers!.where((client) {
        {
          if (client.currentWeek != null) {
            if (client.currentWeek! >= weekRange.first &&
                client.currentWeek! <= weekRange.last) {
              return true;
            } else {
              return false;
            }
          } else {
            return false;
          }
        }
      }).toList();
      notifyListeners();
    }
  }
}
