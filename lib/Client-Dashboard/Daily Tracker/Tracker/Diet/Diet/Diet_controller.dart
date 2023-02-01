import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';

import '../Diet/Diet_model.dart';

class DietController with ChangeNotifier {
  DietController(this.context) {
    // changeState(StateEnum.success);
    fetchDiet();
  }
  BuildContext context;

  DietModel? model;
  late StateEnum state;
  String? errorMessage;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;

  setSelectedDate(DateTime newDateTime) {
    _selectedDate = newDateTime;
  }

  TextEditingController morningDrinkEnergyController = TextEditingController();
  TextEditingController morningDrinkTimeController = TextEditingController();

  TextEditingController breakfastEnergyController = TextEditingController();
  TextEditingController breakfastTimeController = TextEditingController();

  TextEditingController middaySnackEnergyController = TextEditingController();
  TextEditingController middaySnackTimeController = TextEditingController();

  TextEditingController lunchEnergyController = TextEditingController();
  TextEditingController lunchTimeController = TextEditingController();

  TextEditingController eveningSnackEnergyController = TextEditingController();
  TextEditingController eveningSnackTimeController = TextEditingController();

  TextEditingController dinnerEnergyController = TextEditingController();
  TextEditingController dinnerTimeController = TextEditingController();

  TextEditingController dinnerDrinkEnergyController = TextEditingController();
  TextEditingController dinnerDrinkTimeController = TextEditingController();

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  setErrorMessage(String? message) {
    errorMessage = message ?? "Error";
    notifyListeners();
  }

  changeSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
    notifyListeners();
  }

  getStringMealName(MealNames mealName) {
    String mealnameString = mealName.toString().split(".").last;
    return mealnameString.replaceAll("_", " ");
  }

  onAddPressed(
      {required MealNames mealType,
      required String food,
      required String time}) async {
    if (food.isNotEmpty && time.isNotEmpty) {
      await addDiet(mealType: mealType, food: food, time: time);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select food and time beofre adding the diet'),
        backgroundColor: Colors.red,
      ));
    }
  }

  fetchDiet() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null && userdetails.id != null) {
        String url = clientApi.diet_get +
            "?customer=${userdetails.id}" +
            "&date=${Global.getSelectedDate(selectedDate)}";
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        print(url);
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          print(response);
          model = DietModel.fromJson(response);
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

  Diet? filterDiet(String mealName) {
    if (model == null) {
      return null;
    } else {
      if (model!.diet == null || model!.diet!.isEmpty) {
        return null;
      } else {
        List filteredList = model!.diet!
            .where((element) => element.mealName == mealName)
            .toList();
        if (filteredList.isEmpty) {
          return null;
        } else {
          return filteredList.last;
        }
      }
    }
  }

  addDiet(
      {required MealNames mealType,
      required String food,
      required String time}) async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null && userdetails.id != null) {
        String url = clientApi.diet_post;

        print("URl : " + url);
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };

        Map<String, dynamic> body = {
          "mealType": getStringMealName(mealType),
          "food": food,
          "time": time,
          "date": Global.getSelectedDate(_selectedDate),
          "customer": userdetails.id
        };
        log("body : " + body.toString());

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          setErrorMessage(null);
          changeState(StateEnum.error);
        } else if (response is String) {
          setErrorMessage(response);
          changeState(StateEnum.error);
        } else {
          // model = DietModel.fromJson(response);
          log(response.toString());
          changeState(StateEnum.success);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Diet added successully'),
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

  void dispose() {
    morningDrinkEnergyController.dispose();
    morningDrinkTimeController.dispose();

    breakfastEnergyController.dispose();
    breakfastTimeController.dispose();

    middaySnackEnergyController.dispose();
    middaySnackTimeController.dispose();

    lunchEnergyController.dispose();
    lunchTimeController.dispose();

    eveningSnackEnergyController.dispose();
    eveningSnackTimeController.dispose();

    dinnerEnergyController.dispose();
    dinnerTimeController.dispose();

    dinnerDrinkEnergyController.dispose();
    dinnerDrinkTimeController.dispose();
  }
}
