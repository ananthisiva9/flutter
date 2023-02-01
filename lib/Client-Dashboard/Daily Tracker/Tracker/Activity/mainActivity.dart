import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'ActivityTracker/Activity.dart';
import 'ActivityTracker/CustomActivity.dart';
import 'Activity_controller.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, ActivityController controller) async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (_datepicker != null && _datepicker != _date) {
      setState(() {
        _date = _datepicker;
        controller.changeDate(_date);
        controller.initialize();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(ActivityController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: TextButton(
              onPressed: () {
                setState(() {
                  _selectDate(context, controller);
                });
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              )),
        ),
        Text(
          _date.day.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.month.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.year.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                _selectDate(context, controller);
              });
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            )),
      ],
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Hi , SuperMom',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
                    )),
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
                _buildName(),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Image(
                    alignment: Alignment.bottomRight,
                    image: AssetImage('assets/Motherhood-bro.png'),
                  ),
                ),
                _buildContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return ChangeNotifierProvider(
      create: (context) => ActivityController(context)..initialize(),
      child:
          Consumer<ActivityController>(builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/Background.png').image,
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Divider(
                            height: 50,
                          ),
                          Expanded(
                            child: Text(
                              "Activity Tracker",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          _buildDate(controller),
                        ],
                      ),
                      DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              TabBar(indicatorColor: Color(0xffe14589), tabs: [
                                Tab(text: 'User defined Activity'),
                                Tab(text: 'Predefined Activity'),
                              ]),
                              SingleChildScrollView(
                                child: Container(
                                  height: 5000,
                                  child: TabBarView(
                                    children: <Widget>[
                                      Custom(controller),
                                      Predefined(controller),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}