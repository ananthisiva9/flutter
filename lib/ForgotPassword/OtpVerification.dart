import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpVerification extends StatefulWidget {
  String mobileNo;
  OtpVerification({required this.mobileNo});
  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {
  @override
  late String email;
  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Container(
            height: 50,
            width: 100,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Text(widget.mobileNo),
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
            onPressed: () {},
            child: const Text(
              "Submit",
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
