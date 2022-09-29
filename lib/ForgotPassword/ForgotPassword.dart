import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sgx/Utility/api_endpoint.dart';

import 'OtpVerification.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;
  var mobileNo;

  forgotPassword(String email, BuildContext context) async {
    String url = ApiEndPoint.forgot_password;
    Map body = {"email": email};
    Map<String, dynamic> jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    jsonResponse = json.decode(res.body);
    if (res.statusCode == 201) {
      mobileNo = jsonResponse['data'];
    }
      else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something went wrong!'),
          backgroundColor: Colors.red,
        ));
      }
  }

  late String email;

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: const InputDecoration(
          labelText: 'Admin Number',
          labelStyle: TextStyle(
              color: Colors.black, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitBtn(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.indigo),
        onPressed:(){
                forgotPassword(_emailController.text, context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtpVerification(mobileNo: mobileNo.toString())),
                );
              },
        child: const Text(
          "Submit",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Avenir',
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/login.jpg').image,
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildContainer(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Forgot Password ",
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
                const Divider(
                  height: 20,
                ),
                _buildEmail(),
                _buildSubmitBtn(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
