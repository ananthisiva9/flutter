import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/global.dart';
import 'package:string_capitalize/string_capitalize.dart';

class Notes extends StatefulWidget {
  final String value;
  const Notes({Key? key, required this.value}) : super(key: key);
  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(child: _buildContainer()),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Text(
            widget.value == "" ? "Notes Not available" : widget.value.toString().capitalize(),
            maxLines: 100,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Notes',
                    style: GoogleFonts.poppins(
                        color: Colors.lightBlueAccent, fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                  _buildName(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
