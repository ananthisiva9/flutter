import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';

class ExerciseCustomized extends StatefulWidget {
  String? customerid;
  ExerciseCustomized(this.customerid);
  @override
  ExerciseCustomizedState createState() => ExerciseCustomizedState();
}

class ExerciseCustomizedState extends State<ExerciseCustomized> {
  TextEditingController _urlController = TextEditingController();
  bool isLoading = true;
  postData(String url) async {
    int CustomerId = widget.customerid as int;
    String url = doctorApi.customized_diet;
    Map body = {
      "customer": CustomerId.toString(),
      "module": "exercise",
      "url": url
    };
    String? token = await getToken();
    if (token != null) {
      var res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Exercise Plan Submitted Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Exercise Plan Submitted ,Please try again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      }
    }
  }

  late String url;
  Widget _buildNote() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        'To Upload the Customized Exercise, Please Paste the Google Drive Link Here',
        style: GoogleFonts.poppins(
          fontSize: 15,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
        maxLines: 2,
      ),
    );
  }

  Widget _buildUrl() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            url = value;
          });
        },
        controller: _urlController,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNextBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 5 * (MediaQuery.of(context).size.width / 09),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
    ),
            onPressed:
            _urlController.text == "" + widget.customerid.toString() + "exercise"
                ? null
                : () {
              setState(() {
                isLoading = true;
              });
              postData(
                _urlController.text,
              );
            },
            child: Text(
              "Upload",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset('assets/Background.png').image,
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildNote(),
              _buildUrl(),
              _buildNextBtn(),
            ],
          ),
        ],
      ),
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }
}