// ignore_for_file: must_be_immutable
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:railway_super_app/ForgotPassword/ForgotPassword.dart';
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:railway_super_app/User/Profile/Profile.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:railway_super_app/utility/state_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValidOTP extends StatefulWidget {
  String? value;
  ValidOTP({Key? key, this.value}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ValidOTPState createState() => _ValidOTPState();
}

class _ValidOTPState extends State<ValidOTP> {
  final TextEditingController _otpController = TextEditingController();
  bool login = false;
  StateEnum? state;
  late StreamSubscription connectivitySubscription;
  BaseWidget? baseWidget;
  int _countdownTime = 60; // Countdown time in seconds
  Timer? _timer;
  @override
  void initState() {
    super.initState();
    baseWidget = BaseWidget();
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) => setState(
            () {
          if (_countdownTime < 1) {
            timer.cancel();
          } else {
            _countdownTime = _countdownTime - 1;
          }
        },
      ),
    );
  }

  void resetTimer() {
    _timer!.cancel();
    _countdownTime = 60;
    startTimer();
    emailVerification(widget.value.toString());
  }

  @override
  dispose() {
    super.dispose();
  }

  emailVerification(String email) async {
    String url = '${ApiEndPoint.email_verification}?id=1&email=$email';
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['code'] == "INVALID CONTACTDETAILS ID") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(response.body)['description'].toString()),
          backgroundColor: Colors.red,
        ));
      } else {}
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.toString()),
        backgroundColor: Colors.red[900],
      ));
    }
  }

  otp(String otp) async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    String url = '${ApiEndPoint.otp}?otp=$otp';
    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['code'] == 500) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(response.body)['description'].toString()),
          backgroundColor: Colors.red,
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account Verified Successfully'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Profile()),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.toString()),
        backgroundColor: Colors.red[900],
      ));
    }
  }
  getData() async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    String url = '${ApiEndPoint.update_email}?email_id=${widget.value}';
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {

    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Details Not Found'),
        backgroundColor: Colors.red,
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
        Padding(
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
      ],
    );
  }

  String currentText = "";
  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Image(image: AssetImage('asset/otp.png')),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "Enter OTP that has been send to your registered Email",
                  style: GoogleFonts.poppins(fontSize: 20, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              PinCodeTextField(
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false,
                animationType: AnimationType.none,
                cursorColor: Colors.black,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 40,
                  fieldWidth: 40,
                  activeFillColor: Colors.white38, //, 006817
                  activeColor: Colors.black,
                  disabledColor: Colors.deepPurple,
                  errorBorderColor: Colors.yellowAccent,
                  inactiveColor: Colors.black,
                  inactiveFillColor: Colors.white,
                  selectedFillColor: Colors.white38,
                  selectedColor: Colors.black,
                ),
                //  animationDuration: const Duration(milliseconds: 1000),
                enableActiveFill: true,
                controller: _otpController,
                onCompleted: (v) {},
                onChanged: (value) {
                  setState(() {
                    currentText = value;
                  });
                },
                beforeTextPaste: (text) {
                  return false;
                },
                appContext: context,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: TextButton(
                      onPressed: _countdownTime > 0 ? null : resetTimer,
                      child: Text(
                        'Resend OTP',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ': 00:$_countdownTime',
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                ],
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
                  onPressed: () async {
                   getData();
                    if (await baseWidget!.isInternet(context)) {
                      if (_formKey.currentState!.validate()) {
                        otp(_otpController.text);
                      }
                    }
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
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
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Profile()));
        return false;
      },
      child: Scaffold(
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
        body: SizedBox(
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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('asset/Add2.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
          child: Column(children: [
            _buildInput(),
          ])),
    );
  }
}
