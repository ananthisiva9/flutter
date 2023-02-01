import 'package:flutter/material.dart';
import 'package:shebirth/Client-Dashboard/Appointment/upComing/Upcoming_Model.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'Reshedule_model.dart';

class RescheduleController with ChangeNotifier {
  RescheduleController(this.context, this.doctorInfo) {
    changeState(StateEnum.success);
  }

  BuildContext context;
  late StateEnum state;

  UpcomingItem doctorInfo;
  DateTime? date;
  String? time;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  onMakeAnAppointmentPressed() async {
    if (date != null && time != null) {
      await addRescheduleAppointment();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Select date and time before making an appointment'),
        backgroundColor: Colors.red,
      ));
    }
  }

  selectTime(String selectedTime) {
    time = selectedTime;
    notifyListeners();
  }

  addRescheduleAppointment() async {
    String? token = await getToken();
    if (token != null) {
      changeState(StateEnum.loading);
      LoginModel? userdetails = await Global.getUserDetails();
      if (userdetails != null) {
        if (userdetails.token != null) {
          String url = clientApi.reshedule_patch;
          print(DateTime.now().toIso8601String());
          RescheduleModel? model = RescheduleModel(
              appointmentID: doctorInfo.id.toString(),
              date: Global.getSelectedDate(date),
              time: time);
          print(model.toJson());

          dynamic response = await RestService.patchmethod(
              url: url,
              headers: {
                'Accept': 'application/json',
                'Authorization': "Token $token"
              },
              body2: model.toJson());
          if (response is bool) {
            changeState(StateEnum.error);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Something went wrong!'),
              backgroundColor: Colors.red,
            ));
          } else if (response is String) {
            changeState(StateEnum.error);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(response),
              backgroundColor: Colors.red,
            ));
          } else {
            // model = AddMedicinemodel.fromJson(response);
            print(response);
            changeState(StateEnum.success);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Appointment booked successfully'),
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

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }
}
