import 'package:flutter/material.dart';
import 'package:shebirth/Dad%20Dashboard/Display.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'Symptoms_model.dart';

class SymptomsController with ChangeNotifier {
  SymptomsController(this.context) {
    fetchAllSymptoms();
  }

  BuildContext context;

  SymptomsModel? model;
  List<Data> allSymptoms = [];

  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  Future<void> fetchAllSymptoms() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = dadApi.remedy;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = SymptomsModel.fromJson(response);
          if (model != null) {
            if (model!.data!= null)
              allSymptoms.addAll(model!.data!);
          }
          print(response);
          changeState(StateEnum.success);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              ' Details not found.'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DadDisplay()),
          );
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Details not found.'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DadDisplay()),
        );
      });
    }
  }
}
