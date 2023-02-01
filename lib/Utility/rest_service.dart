import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Medical/Medical_model.dart';
import '../Login/Login_model.dart';
import 'global.dart';

class RestService {
  static Future<dynamic> getMethod(
      {Map<String, dynamic>? headers, required String url}) async {
    try {
      Dio dio = new Dio();
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

  static Future<dynamic> patchmethod(
      {Map<String, String>? headers,
      required String url,
      Map<String, dynamic>? body2}) async {
    String? token = await getToken();
    if (token != null) {
      var dd = body2;
      try {
        await http.patch(
          Uri.parse(url),
          body:
              '{"date": "${dd!["date"]}", "time": "${dd["time"]}", "appointmentID": "${dd["appointmentId"]}"}',
          headers: {
            "Content-type": "application/json",
            'Authorization': "Token $token",
          },
        ).then((value) {
          print(value);
          print(value.body);

          return value.body;
        });
      } catch (e) {
        return false;
      }
    }
  }

  static Future<dynamic> postmethod(
      {Map<String, dynamic>? headers,
      required String url,
      Map<String, dynamic>? body}) async {
    try {
      log("body : " + body.toString());
      Dio dio = new Dio();
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

  static Future<dynamic> postContartionApi(
      {Map<String, dynamic>? headers,
      required String url,
      Map<String, dynamic>? body}) async {
    try {
      log("Body : " + body.toString());
      Dio dio = new Dio();
      var response = await dio.post(
        url,
        data: body,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data != null) {
          return response;
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

  static Future<dynamic> fileUploadMethod(
      {required String url,
      required Map<String, dynamic> headers,
      required AddMedicalmodel model}) async {
    try {
      FormData formData = FormData.fromMap({
        "date": model.date,
        "appointmentDate": model.appointmentDate,
        "scanDate": model.scanDate,
        "bp": model.bp,
        "weight": model.weight,
        "scanReport": model.scanReport == null
            ? null
            : await MultipartFile.fromFile(model.scanReport!),
        "bloodReport": model.bloodReport == null
            ? null
            : await MultipartFile.fromFile(model.bloodReport!),
        "antenatalChart": model.antenatalChart == null
            ? null
            : await MultipartFile.fromFile(model.antenatalChart!),
      });
      Dio dio = new Dio();
      dynamic response = await dio.post(
        url,
        data: formData,
        options: Options(
          receiveDataWhenStatusError: true,
          headers: headers,
        ),
      );
      if (response.statusCode == 200) {
        print(response.data);
        if (response.data != null) {
          if (response.data.toString().contains("error")) {
            return response.data.toString();
          } else {
            return response.data;
          }
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
    return userDetails.token;
  }
}
