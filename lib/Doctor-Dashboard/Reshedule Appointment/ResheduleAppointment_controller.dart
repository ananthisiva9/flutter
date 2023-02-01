import 'package:flutter/material.dart';
import 'package:shebirth/Doctor-Dashboard/Appointments/AppointmentsModel.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'ResheduleAppointment_model.dart';

class ResheduleController with ChangeNotifier {
  ResheduleController(this.context, this.doctorInfo) {
    changeState(StateEnum.success);
  }

  BuildContext context;
  late StateEnum state;

  AppointmentTypeModel doctorInfo;
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
    String? token = await getToken();
    if (token != null) {
      changeState(StateEnum.loading);
      LoginModel? userdetails = await Global.getUserDetails();
      if (userdetails != null) {
        if (userdetails.token != null) {
          String url = doctorApi.reschedule_patch;
          print(DateTime.now().toIso8601String());
          ResheduleModel? model = ResheduleModel(
              appointmentID: doctorInfo.id.toString(),
              date: Global.getSelectedDate(date),
              time: time);
          print(model.toJson());
          dynamic response = await RestService.patchmethod(
              url: url,
              headers: {'Authorization': " Token ${token}"},
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
