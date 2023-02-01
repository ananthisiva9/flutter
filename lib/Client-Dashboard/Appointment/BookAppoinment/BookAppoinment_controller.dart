import 'package:flutter/material.dart';
import 'package:shebirth/Client-Dashboard/Appointment/upComing/UpComing_View.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/DoctorList/DoctorList_model.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'BookAppoinment_model.dart';

class BookAppoinmentController with ChangeNotifier {
  BookAppoinmentController(this.context, this.doctorInfo) {
    changeState(StateEnum.success);
  }
  BuildContext context;
  late StateEnum state;

  DoctorListItem doctorInfo;
  DateTime? date;
  String? time;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  onMakeAnAppointmentPressed() async {
    if (date != null && time != null) {
      await addBookAppoinment();
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

  addBookAppoinment() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.bookAppoinment_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}",
          "Content-Type": "application/json"
        };
        print(DateTime.now().toString());
        BookAppoinmentModel? model = BookAppoinmentModel(
            doctor: doctorInfo.id.toString(),
            date: Global.getSelectedDate(date),
            time: time);
        print(model.toJson());
        dynamic response = await RestService.postmethod(
            url: url, headers: header, body: model.toJson());
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
          return url;
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