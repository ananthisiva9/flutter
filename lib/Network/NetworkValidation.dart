import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class BaseWidget extends ChangeNotifier{

  Future<bool> isInternet(BuildContext context) async{
    ConnectivityResult result =
    await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile) {
      return true;
    } else{
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("No  Internet"),
        backgroundColor: Colors.red,
      ));
      return false;
    }
  }
}