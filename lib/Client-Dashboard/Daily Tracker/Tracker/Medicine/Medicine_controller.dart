import 'package:flutter/material.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Daily%20Tracker.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Medicine/Medicine_model.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';



class MedicationController with ChangeNotifier {
  MedicationController(this.context);

  DateTime? _date;

  DateTime get date => _date ?? DateTime.now();

  changeDate(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  BuildContext context;
  MedicineModel? model;
  late StateEnum state;
  late StateEnum checkBoxState;

  List<Medicines> allMedicines = [];

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
    fetchAllMedicines();
  }

  fetchAllMedicines() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String dateParam = Global.getSelectedDate(_date);
        String url = clientApi.medicine_get +
            '?date=' +
            dateParam; //TODO:
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = MedicineModel.fromJson(response);
          allMedicines.clear();
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

  submitMedicines(String id, bool status, BuildContext context,
      int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.medicine_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "medicine": id,
          "taken": status,
          "date": Global.getSelectedDate(_date)
        };

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          model!.items![index].medicines![index].taken = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Medicine Submitted Successfully'),
            backgroundColor: Colors.green,
          ));
          Future.delayed(Duration(seconds: 2), () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ClientDailyTracker()),
            );
          });
        } else if (response is String) {
          model!.items![index].medicines![index].taken = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          model!.items![index].medicines![index].taken = status;
          changeCheckBoxState(StateEnum.success);
        }
      }
    }
  }
}