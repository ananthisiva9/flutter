import 'package:admin_dashboard/Sales/Daily%20Tracker/Daily%20Tracker.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/rest_service.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'Medicine_model.dart';

class MedicationController with ChangeNotifier {
  MedicationController({required this.customerid, required this.context,required this.selectedDate}) {
    fetchAllMedicines();
  }

  String customerid;
  String selectedDate;
  BuildContext context;

  MedicineModel? model;
  late StateEnum state;
  late StateEnum checkBoxState;

  List<Medicines> allMedicines= [];
  Medicines? medicines;

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
        String dateParam = selectedDate;
        String url = Sales.update_medicine_get +
            '?date=' +
            dateParam +
            '&customer=' + customerid; //TODO:
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateTracker(medicines!.id!)),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:  Text(
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
        content:  Text(
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
  submitMedicines(
      String id, bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url =  Sales.update_medicine_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "customer" :customerid,
          "medicine": id,
          "taken": status,
          "date": selectedDate
        };

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          allMedicines[index].taken = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:  Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          allMedicines[index].
          taken= false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          allMedicines[index].taken = status;
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
          content:  Text(
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
        content:  Text(
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
  }
}