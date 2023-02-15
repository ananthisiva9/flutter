import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CommingSoon/comminsoon.dart';
import 'Contest/Contest.dart';
import 'Dashboard/User.dart';
import 'Profile/Profile.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key, required int index}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State {
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

      } else if (jsonDecode(res.body)['status'] == 500) {
        // ignore: use_build_context_synchronously
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(jsonDecode(res.body)['message'].toString()),
        //   backgroundColor: Colors.red,
        // ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Login()),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  GlobalKey _NavKey = GlobalKey();

  var PagesAll = [Dashboard(),const Contest(),const ComminSoon(),const Profile()];

  var myindex =0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BottomBar(index: 0)));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            backgroundColor:  Colors.white,
            buttonBackgroundColor :const Color(0xff0093DD),
            height: 50,
            key: _NavKey,
            items: const [
              Image(image: AssetImage('asset/Bottom1.png'),
                height: 28),
              Image(image: AssetImage('asset/Bottom2.png'),
                  height: 28),
              Image(image: AssetImage('asset/Bottom3.png'),
                  height: 28),
              Image(image: AssetImage('asset/Bottom5.png'),
                  height: 28),
            ],
            onTap: (index){
              setState(() {
                myindex = index;
                postData();
              });
            },
           animationCurve: Curves.ease, color: const Color(0xff0093DD),
          ),
          body: PagesAll[myindex],
        ),
      ),
    );
  }
}

