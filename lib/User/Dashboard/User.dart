import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/User/Bottombar.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:railway_super_app/User/CommingSoon/comminsoon.dart';
import 'package:railway_super_app/User/Contest/Contest.dart';
import 'package:railway_super_app/User/WiFi/Wifi.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isLoading = false;
  // ignore: prefer_typing_uninitialized_variables
  var id, name, url, message;
  BaseWidget? baseWidget;
  @override
  void initState() {
    super.initState();
    logStart();
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

  logStart() async {
    String url =
        '${ApiEndPoint.log_start}?app_label=Railway&Module_name=Dashboard';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      message = jsonDecode(res.body)['message'];
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  logEnd() async {
    String url = '${ApiEndPoint.log_end}?id=$message';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: SafeArea(
          child: Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              title: const Image(
                image: AssetImage('asset/Logo.png'),
                height: 30,
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu),
                tooltip: 'Menu Icon',
                onPressed: () {},
              ),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.account_balance_wallet_outlined),
                  color: Colors.white,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications),
                  color: Colors.white,
                ),
              ],
              backgroundColor: Colors.transparent,
            ),
            // drawer: NavigationDrawer(),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("asset/Dashboard.png"),
                            fit: BoxFit.cover)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                              height: MediaQuery.of(context).size.height / 12,
                              width: MediaQuery.of(context).size.width / 1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.black.withOpacity(0.5)),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Good Day, Special App Exclusive Welcome',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Offers Waiting for you. Pick Up Now!',
                                      style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                        Stack(
                          fit: StackFit.passthrough,
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                height: MediaQuery.of(context).size.height / 12,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white),
                                margin: const EdgeInsets.only(
                                    top: 5.0, left: 10, right: 10, bottom: 5),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 20,
                                        backgroundImage:
                                            AssetImage('asset/Wi-Fi.png'),
                                      ),
                                      onTap: () {
                                        logEnd();
                                        postData();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const WifiConnect()),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              22,
                                      width: MediaQuery.of(context).size.width /
                                          5.5,
                                      child: Center(
                                        child: Text(
                                          'Wi-Fi',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 20,
                                        backgroundImage:
                                        AssetImage('asset/Travel.png'),
                                      ),
                                      onTap: () {
                                        logEnd();
                                        postData();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ComminSoon()),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          22,
                                      width: MediaQuery.of(context).size.width /
                                          5.5,
                                      child: Center(
                                        child: Text(
                                          'Travel',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ), Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 20,
                                        backgroundImage:
                                        AssetImage('asset/E-Commarce.png'),
                                      ),
                                      onTap: () {
                                        logEnd();
                                        postData();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ComminSoon()),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          22,
                                      width: MediaQuery.of(context).size.width /
                                          5.5,
                                      child: Center(
                                        child: Text(
                                          'EComm',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ), Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        radius: 20,
                                        backgroundImage:
                                        AssetImage('asset/Support.png'),
                                      ),
                                      onTap: () {
                                        logEnd();
                                        postData();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const ComminSoon()),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                      MediaQuery.of(context).size.height /
                                          22,
                                      width: MediaQuery.of(context).size.width /
                                          5.5,
                                      child: Center(
                                        child: Text(
                                          'Support',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Top Categories',
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffDBFDFF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      height: MediaQuery.of(context).size.height / 10,
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 18.0, left: 18.0),
                            child: InkWell(
                              child: const Image(
                                image: AssetImage('asset/train.png'),
                                height: 60,
                              ),
                              onTap: () {
                               logEnd();
                                postData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ComminSoon()),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 18.0, left: 18.0),
                            child: InkWell(
                              child: const Image(
                                  image: AssetImage('asset/flight.png'),
                                  height: 60),
                              onTap: () {
                                logEnd();
                                postData();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ComminSoon()),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 18.0, left: 18.0),
                            child: InkWell(
                              child: const Image(
                                  image: AssetImage('asset/bus.png'),
                                  height: 60),
                              onTap: () {
                                logEnd();
                                postData();
                                Navigator.push(
                                 context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ComminSoon()),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.only(left: 25.0, right: 25),
                    child: Image(image: AssetImage('asset/Add1.png')),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: InkWell(
                      child: const Image(image: AssetImage('asset/Contest.png')),
                      onTap: () async {
                        if (await baseWidget!.isInternet(context)) {
                          logEnd();
                          postData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Contest()));
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Services',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topRight,
                                padding: const EdgeInsets.all(8),
                                child: TextButton(
                                    onPressed: () {
                                      logEnd();
                                      postData();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ComminSoon()),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "See More ",
                                          style: GoogleFonts.poppins(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        const Icon(
                                          Icons.arrow_forward,
                                          size: 16,
                                          color: Colors.black,
                                        ),
                                      ],
                                    )),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 20,
                                width: MediaQuery.of(context).size.width / 2.5,
                                decoration: BoxDecoration(
                                  color: const Color(0xffDBFDFF),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: TextButton(
                                    child: Text(
                                      'Food ',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    onPressed: () {
                                      logEnd();
                                      postData();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ComminSoon()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffDBFDFF),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: TextButton(
                                      child: Text(
                                        'Tourism',
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      onPressed: () {
                                        logEnd();
                                        postData();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ComminSoon()),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDBFDFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          'Help Desk',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          logEnd();
                                          postData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ComminSoon()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDBFDFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          'Taxi',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          logEnd();
                                          postData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ComminSoon()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDBFDFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          'Meet & Greet',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          logEnd();
                                          postData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ComminSoon()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDBFDFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          'Shopping',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          logEnd();
                                          postData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ComminSoon()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDBFDFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          'Infotainment',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          logEnd();
                                          postData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ComminSoon()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffDBFDFF),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: TextButton(
                                        child: Text(
                                          'Hotel',
                                          style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        onPressed: () {
                                          logEnd();postData();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const ComminSoon()),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      elevation: 5,
                      color: Colors.white,
                      child: SizedBox(
                          child: Image.asset(
                        'asset/Add3.png',
                      ))),
                  SizedBox(height: MediaQuery.of(context).size.height / 60)
                ],
              ),
            ),
           //bottomNavigationBar: const BottomBar(),
          ),
        ),
      );
    });
  }
}
