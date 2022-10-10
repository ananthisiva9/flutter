import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetOTP extends StatefulWidget {
  //String mobileNo;
 // GetOTP({required this.mobileNo});
  @override
  _GetOTPState createState() => _GetOTPState();
}

class _GetOTPState extends State<GetOTP> {
  TextEditingController _otpController = TextEditingController();
//  FirebaseAuth auth = FirebaseAuth.instance;
  String verificationIDRecevived = "";

  @override
  Widget _buildOTP() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        controller: _otpController,
        onChanged: (value) {},
        decoration: const InputDecoration(
          labelText: 'Enter OTP',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery
              .of(context)
              .size
              .height / 20),
          width: 5 * (MediaQuery
              .of(context)
              .size
              .width / 08),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            onPressed: () {
             // verifyNumber();
            },
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
                  image: Image
                      .asset('assets/login.jpg')
                      .image,
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
            height: MediaQuery
                .of(context)
                .size
                .height * 0.5,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Forgot Password",
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
                const Text(
                  'Please Enter OPT ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                _buildOTP(),
                _buildSubmitBtn(context),
              ],
            ),
          ),
        ),
      ],
    );
  }

//void verifyNumber() {
// auth.verifyPhoneNumber(
//   phoneNumber: widget.mobileNo,
// verificationCompleted: (PhoneAuthCredential cerdential) async {
// await auth.signInWithCredential(cerdential).then((value) {
// print("You Are Logged in Successfully");
// });
// },
// verificationFailed: (FirebaseAuthException exception) {
// print(exception.message);
// },
// codeSent: (String verificationID, int? resendToken) {
// verificationIDRecevived = verificationID;
// setState(() {});
// },
//    codeAutoRetrievalTimeout: (String verificationID) {});
//}
//}
}