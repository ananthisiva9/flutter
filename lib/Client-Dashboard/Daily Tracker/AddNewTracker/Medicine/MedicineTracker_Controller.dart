import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'MedicineTracker_Model.dart';

class AddMedicineController with ChangeNotifier {
  AddMedicineController(this.context) {
    changeState(StateEnum.success);
  }
  BuildContext context;
  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  addNewMedicine(String name, String medicationTime) async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.add_medicine_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        print(DateTime.now().toIso8601String());
        AddMedicinemodel? model = AddMedicinemodel(
            name: name,
            medicationTime: medicationTime,
            date: DateTime.now().toIso8601String()); //TODO;

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: model.toJson());
        if (response is bool) {
          changeState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else {
          // model = AddMedicinemodel.fromJson(response);
          print(response);
          changeState(StateEnum.success);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Medicine added Successfully'),
            backgroundColor: Colors.green,
          ));
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
}
