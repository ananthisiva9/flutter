import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'Exercise_Tracker/excercise_Tracker_Model.dart';

class ExerciseController with ChangeNotifier {
  ExerciseController(this.context);

  DateTime? _date;

  DateTime get date => _date ?? DateTime.now();
  changeDate(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

  // ExerciseTrackerController(this.context);

  late YoutubePlayerController _youtubeController;

  YoutubePlayerController get youtubeController => _youtubeController;

  TextEditingController caloriesController = TextEditingController();

  BuildContext context;
  ExerciseTrackerModel? model;
  late StateEnum state;
  late StateEnum videoState;
  late StateEnum checkBoxState;
  late StateEnum caloriesState;

  List<Exercises> allExercises = [];

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  changeVideoState(StateEnum stateEnum) {
    videoState = stateEnum;
    notifyListeners();
  }

  changeCheckBoxState(StateEnum stateEnum) {
    checkBoxState = stateEnum;
    notifyListeners();
  }

  changeCaloriesState(StateEnum stateEnum) {
    caloriesState = stateEnum;
    notifyListeners();
  }

  initialize() {
    changeCheckBoxState(StateEnum.success);
    changeCaloriesState(StateEnum.success);
    fetchAllExercises();
  }

  fetchAllExercises() async {
    changeState(StateEnum.loading);
    changeVideoState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String dateParam = Global.getSelectedDate(_date);

        String url = clientApi.exercise_get + '?date=' + dateParam;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        print("URL : " + url);

        dynamic response =
        await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = ExerciseTrackerModel.fromJson(response);
          log(response.toString());

          if (model!.calorieBurnt != null) {
            caloriesController.text = model!.calorieBurnt.toString();
          }

          print(model!.url ?? "No URL");
          if (model!.url != null) {
            if (model!.url!.isNotEmpty) {
              late String subString, videoId;

              if (model!.url!.toString().contains("embed")) {
                subString = model!.url!
                    .substring(model!.url!.toString().lastIndexOf("/"));
                print("SUBSTRING : " + subString);
                videoId = subString.substring(1);
                print("videoId : " + videoId);
              } else {
                subString = model!.url!.substring(model!.url!.indexOf("="));
                List<String> splitSubString = subString.split("");
                Iterable<String> range = splitSubString.getRange(1, 12);
                videoId = range.join("");
              }

              print("SUBSTRING : " + subString);
              print("videoId : " + videoId);

              _youtubeController =
              await YoutubePlayerController(
                initialVideoId: videoId,
                params: YoutubePlayerParams(
                  showControls: true,
                  showFullscreenButton: true,
                  privacyEnhanced: true,
                  loop: true,
                ),
              );
              changeVideoState(StateEnum.success);
            } else {
              changeVideoState(StateEnum.error);
            }
          } else {
            changeVideoState(StateEnum.error);
          }

          allExercises.clear();
          if (model!.exercises != null) allExercises.addAll(model!.exercises!);
          if (model!.custom != null) allExercises.addAll(model!.custom!);

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

  submitExcercise( bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.exercise_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "exercise": model!.exercises![index].id,
          "completed": status ? 'True' : 'False',
          "date": Global.getSelectedDate(_date)
        };

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          model!.exercises![index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          model!.exercises![index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          model!.exercises![index].completed = status;
          changeCheckBoxState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Exercise submitted Successfully'),
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

  submitCustomExcercise(bool status, BuildContext context, int index) async {
    changeCheckBoxState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.custom_exercise_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "exercise": model!.custom![index].id,
          "completed": status,
          "date": Global.getSelectedDate(_date)
        };

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          model!.custom![index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          model!.custom![index].completed = false;
          changeCheckBoxState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          model!.custom![index].completed = status;
          changeCheckBoxState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Exercise submitted Successfully'),
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

  submitCalories() async{
    changeCaloriesState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.calories_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        Map<String, dynamic> body = {
          "value": caloriesController.text,
          "date": Global.getSelectedDate(_date)
        };

        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: body);
        if (response is bool) {
          changeCaloriesState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          changeCaloriesState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(response),
            backgroundColor: Colors.red,
          ));
        } else {
          changeCaloriesState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Exercise submitted Successfully'),
            backgroundColor: Colors.green,
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Details not found. You will be rerouted to the login page'),
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