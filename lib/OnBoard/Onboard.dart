import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _OnBoardState createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
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

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      double _height = MediaQuery.of(context).size.height;
      double _width = MediaQuery.of(context).size.width;
      return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Image(
                      image: AssetImage('asset/Logo.png'),
                      height: 128,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Railmitraa",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            fontSize: 26.sp,
                            color: const Color(0xff0093DD))),
                  ),
                  const SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                          image: const AssetImage('asset/Splash1.png'),
                          height: MediaQuery.of(context).size.height / 3),
                    ],
                  ),
                  //const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 30, right: 20, left: 10, bottom: 10),
                        child: InkWell(
                          child: Container(
                            height: MediaQuery.of(context).size.height / 13,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                color: const Color(0xff0093DD),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Get Started',
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_circle_right_outlined,
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          onTap: () async {
                            if (await baseWidget!.isInternet(context)) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
