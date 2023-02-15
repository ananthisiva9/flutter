import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:railway_super_app/utility/state_enum.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'OTPVerification.dart';

class EmailVerification extends StatefulWidget {
  @override
  _EmailVerificationState createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  TextEditingController _emailController = TextEditingController();
  bool login = false;
  bool isLoading = false;
  StateEnum? state;
  bool _clicked = false;
  late StreamSubscription _connectivitySubscription;
  BaseWidget? baseWidget;

  @override
  void initState() {
    super.initState();
    baseWidget = BaseWidget();
  }

  @override
  dispose() {
    super.dispose();
  }

  SignIn(String email) async {
    String url = '${ApiEndPoint.email_verification}?id=&email=$email';
    var jsonResponse, data;
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['code'] == 500) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(response.body)['description']),
          backgroundColor: Colors.red,
       ));
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
            builder: (context) =>
            Login()));
      } else {
        // ignore: use_build_context_synchronously

      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.toString()),
        backgroundColor: Colors.red[900],
      ));
    }
  }

  final _formKey = GlobalKey<FormState>();

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
            image: const AssetImage('asset/Logo.png'),
            height: MediaQuery.of(context).size.height / 10)
      ],
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Railmitraa',
              style: GoogleFonts.poppins(
                color: const Color(0xff0093DD),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.deny(" ")],
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:
                            const BorderSide(width: 5, color: Colors.green)),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Email Id",
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    bool passValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value == null || value.isEmpty) {
                      return 'Enter Your E-Mail';
                    } else if (!passValid) {
                      return 'Email should be in Correct Format';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1.4 * (MediaQuery.of(context).size.height / 20),
                width: 5 * (MediaQuery.of(context).size.width / 10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Color(0xff5CACF9), Color(0xff0D72D0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                    SignIn(_emailController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              OTPVerification(value: _emailController.text)),
                    );
                    }
                  },
                  child: (isLoading)
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ))
                      : Text(
                          "Send OTP",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        appBar: PreferredSize(
          //wrap with PreferredSize
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            backgroundColor: const Color(0xff0093DD),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image(
                      image: const AssetImage('asset/Add1.png'),
                      height: MediaQuery.of(context).size.height / 8,
                      width: 400),
                ),
                _buildLogo(),
                const SizedBox(
                  height: 10,
                ),
                _buildName(),
                _buildContainer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      image: const AssetImage('asset/Add2.png'),
                    ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildContainer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
          child: Column(children: [
        _buildInput(),
      ])),
    );
  }
}
