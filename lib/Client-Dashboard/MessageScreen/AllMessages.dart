import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/Client-Dashboard/MessageScreen/ConsultantMessage/Chat_view.dart';
import 'package:shebirth/Client-Dashboard/MessageScreen/DoctorMessage/Chat_view.dart';
import 'package:shebirth/Client-Dashboard/MessageScreen/SalesMessage/Chat_view.dart';

class AllMessages extends StatefulWidget {
  @override
  _AllMessagesState createState() => _AllMessagesState();
}

class _AllMessagesState extends State<AllMessages> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appbar.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            elevation: 0,
            title: Text(
              'Messages',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            actions: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ClientDisplay(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
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
                _buildContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.92,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: <Widget>[
                        TabBar(indicatorColor: Color(0xffe41589), tabs: [
                          Tab(
                            text: 'Doctor',
                          ),
                          Tab(text: 'Consultant'),
                          Tab(text: 'Sales'),
                        ]),
                        SingleChildScrollView(
                          child: Container(
                            height: 700,
                            child: TabBarView(
                              children: <Widget>[
                                DoctorChat(),
                                ConsultantChat(),
                                SalesChat(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
