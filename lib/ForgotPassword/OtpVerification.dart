import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgx/ForgotPassword/GetOTP.dart';
import 'package:sgx/Utility/api_endpoint.dart';
import 'package:http/http.dart' as http;

class OtpVerification extends StatefulWidget {
  String mobileNo, email;
  OtpVerification({required this.mobileNo, required this.email});
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  OTPVerification() async {
    String url = ApiEndPoint.otp;
    Map body = {"email": widget.email, "phone": widget.mobileNo};
    Map<String, dynamic> jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    jsonResponse = json.decode(res.body);
    if (res.statusCode == 201) {
      print(widget.email + widget.mobileNo);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please Enter OTP'),
        backgroundColor: Colors.red,
      ));
      // Navigator.push(
      //  context,
      // MaterialPageRoute(
      //   builder: (context) => OtpVerification(
      //   mobileNo: mobileNo,
      // email: _emailController.text,
      // )),
      //);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something went wrong!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget _buildMobileNumber() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Phone Number : ',
            style: TextStyle(
                color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              widget.mobileNo,
              style: const TextStyle(
                  color: Colors.indigo,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitBtn(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 08),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
              OTPVerification();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GetOTP(),
                ),
              );
            },
            child: const Text(
              "Get OTP",
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 1.5,
                fontSize: 20,
                fontFamily: 'Avenir',
              ),
            ),
          ),
        ),
      ],
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
                _buildMobileNumber(),
                _buildSubmitBtn(context),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
