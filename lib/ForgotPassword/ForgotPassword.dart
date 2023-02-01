import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/utility/api_endpoint.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  logIn(String email, BuildContext context) async {
    String url = ApiEndPoint.forgot_password;
    Map body = {"email": email};
    Map<String, dynamic> jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    jsonResponse = json.decode(res.body);
    if (res.statusCode == 200) {
      print("Response status:${res.statusCode}");
      print("Response status:${res.body}");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        if (jsonResponse.containsKey('status')) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('A password reset link has been sent to your mail'),
            backgroundColor: Colors.green,
          ));
        } else if (jsonResponse.containsKey('email')) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(jsonResponse['email'].first.toString()),
            backgroundColor: Colors.red,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong!'),
            backgroundColor: Colors.red,
          ));
        }
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      if (jsonResponse.containsKey('email')) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonResponse['email'].first.toString()),
          backgroundColor: Colors.red,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something went wrong!'),
          backgroundColor: Colors.red,
        ));
      }
      print("Response status:${res.statusCode}");
    }
  }

  Widget _buildWelcome() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Text(
              'Welcome To Our',
              maxLines: 2,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Sukh Prasavam',
              maxLines: 2,
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  late String email;

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        onChanged: (value) {
          setState(() {
            email = value;
          });
        },
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.email,
            color: Colors.white,
          ),
          labelText: 'E-mail',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 08),
          margin: EdgeInsets.only(bottom: 20),
          child:  ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _emailController.text == ""
                ? null
                : () {
                    setState(() {
                      _isLoading = true;
                    });
                    logIn(_emailController.text, context);
                  },
            child: _isLoading
                ? CircularProgressIndicator.adaptive()
                : Text(
                    "Submit",
                    style: TextStyle(
                      color: Colors.white,
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
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildWelcome(),
              _buildLogo(),
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
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Enter Your Email to Reset Your Password ",
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(
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
