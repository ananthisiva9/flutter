import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'Medical_model.dart';

class MedicalController with ChangeNotifier {
  late StateEnum state;
  MedicalController(BuildContext context, DateTime date) {
    // changeState(StateEnum.success);
    getMedical(context: context, date: date);
  }

  final TextEditingController questionController = TextEditingController();
  final TextEditingController bpController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  String? scanReportPath;
  String? bloodReportPath;
  String? antenatalReportPath;

  MedicalFormData? medicalModel;

  void changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  getMedical({required BuildContext context, required DateTime date}) async {
    changeState(StateEnum.loading);
    medicalModel = null;
    scanReportPath = null;
    bloodReportPath = null;
    antenatalReportPath = null;
    questionController.text = "";
    bpController.text = "";
    weightController.text = "";

    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String dateParam = Global.getSelectedDate(date);
        String url = clientApi.medical_get + '?date=' + dateParam ;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        print("URL : " + url);

        dynamic response =
        await RestService.getMethod(url: url, headers: header);

        if (response is bool) {
          changeState(StateEnum.error);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        } else if (response is String) {
          print("The response is String");
          changeState(StateEnum.success);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No medical details found on ' + dateParam),
            backgroundColor: Colors.red,
          ));
        } else {
          print("**********************");
          print(response);
          medicalModel = MedicalFormData.fromJson(response);
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
    // http://{{domain}}/customer/get-medical/?date=2022-01-07
  }

  addNewMedical(
      {required DateTime date,
        required DateTime appoinmentDate,
        String? question,
        required BuildContext context,
        String? bp,
        String? weight}) async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.medical_post;
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };

        AddMedicalmodel model = AddMedicalmodel(
            date: Global.getSelectedDate(date),
            appointmentDate: Global.getSelectedDate(appoinmentDate),
            question: question,
            bp: bp,
            weight: weight,
            scanReport: scanReportPath,
            bloodReport: bloodReportPath,
            antenatalChart: antenatalReportPath);
        print("THE JSON:");
        print(model.toJson().toString());

        dynamic response = await RestService.fileUploadMethod(
            url: url, headers: header, model: model);
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
          scanReportPath = null;
          bloodReportPath = null;
          antenatalReportPath = null;
          changeState(StateEnum.success);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Medical details added successfully'),
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
