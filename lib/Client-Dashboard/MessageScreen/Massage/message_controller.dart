import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'Message_model.dart';

class MessageController with ChangeNotifier {
  MessageController({required this.context, required this.customerid}) {
    fetchAllClients();
  }
  BuildContext context;
  MessageModel? model;
  String customerid;
  late StateEnum state;

  changeState(StateEnum stateEnum) {
    state = stateEnum;
    notifyListeners();
  }

  Future<void> fetchAllClients() async {
    changeState(StateEnum.loading);
    LoginModel? userdetails = await Global.getUserDetails();
    if (userdetails != null) {
      if (userdetails.token != null) {
        String url = clientApi.get_message + '?receiver=$customerid';
        Map<String, dynamic> header = {
          "Authorization": "Token ${userdetails.token}"
        };
        dynamic response =
            await RestService.getMethod(url: url, headers: header);
        if (response is bool) {
          changeState(StateEnum.error);
        } else {
          model = MessageModel.fromJson(response);
          print(response);
          changeState(StateEnum.success);
        }
      }
    }
  }
}
