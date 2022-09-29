import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:sgx/Login/Login_model.dart';
import 'global.dart';

class RestService {
  static Future<dynamic> getMethod(
      {Map<String, dynamic>? headers, required String url}) async {
    try {
      Dio dio =  Dio();
      var response = await dio.get(
        url,
        options: Options(headers: headers),
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return false;
      }
    } catch (e) {
      log(DioErrorType.response.toString());
      if (e is DioError) {
        if (e.error.toString().contains('404')) {
          return e.error.toString();
        }
      }
      print(e);
      return false;
    }
  }


  static Future<dynamic> postmethod(
      {Map<String, dynamic>? headers,
      required String url,
      Map<String, dynamic>? body}) async {
    try {
      log("body : " + body.toString());
      Dio dio =  Dio();
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          validateStatus: (status) => true,
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data != null) {
          return response.data;
        } else {
          return false;
        }
      } else {
        log(response.data);
        return false;
      }
    } catch (e) {
      if (e is DioError) {
        log(e.message.toString());
        log(e.response.toString());
        String error = e.message.toString() + "\n" + e.response.toString();
        return error;
      }
      return false;
    }
  }
}

getToken() async {
  dynamic userDetails = await Global.getUserDetails();
  if (userDetails != null && userDetails is LoginModel) {
    return userDetails.data!.token;
  }
}
