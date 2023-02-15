import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway_super_app/User/Bottombar.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/User/Dashboard/User.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ComminSoon extends StatefulWidget {
  const ComminSoon({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ComminSoonState createState() => _ComminSoonState();
}

class _ComminSoonState extends State<ComminSoon> {
  // ignore: prefer_typing_uninitialized_variables
  var message;
  @override
  void initState(){
    super.initState();
  }
  postData() async {
    String url = ApiEndPoint.token;
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    Map body = {
      "token": token,
    };
    var res = await http.post(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
      body: body,
    );
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)['status'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(res.body)['description'].toString()),
          backgroundColor: Colors.red,
        ));
      } else if (jsonDecode(res.body)['status'] == 500) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(res.body)['description'].toString()),
          backgroundColor: Colors.red,
        ));
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => BottomBar(index: 0)));
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
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('asset/Logo.png'), height: 100),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Railmitraa",
                      style: GoogleFonts.poppins(
                          fontSize: 30, color: const Color(0xff0093DD),fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 10),
                const Image(
                  image: AssetImage('asset/CommingSoon1.png'),
                ),
                const Image(
                  image: AssetImage('asset/CommingSoon2.png'),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('asset/Add3.png'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height/80,
                ),
              ],
            ),
          ),
        ),
      // bottomNavigationBar:  const BottomBar(),
      ),
    );
  }
}