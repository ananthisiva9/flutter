import 'package:flutter/material.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'Contraction/Contraction_view.dart';
import 'DietTracker/Diet/Diet_view.dart';
import 'ExerciseTracker/Exercise/Exercise_view.dart';
import 'Medical/Medical_view.dart';
import 'Medicine/Medicine_view.dart';
import 'Symptom/Symptom_view.dart';

class DailyTracker extends StatefulWidget {
  DailyTracker(this.clientId);
  int clientId;
  @override
  _DailyTrackerState createState() => _DailyTrackerState();
}

class _DailyTrackerState extends State<DailyTracker> {
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
              'Daily Tracker',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Arial',
              ),
              textAlign: TextAlign.start,
            ),
            actions: [
              GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: Icon(Icons.home,
                      color: Colors.white,),
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Display()),
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
            height: MediaQuery.of(context).size.height * 0.93,
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
                      length: 6,
                      initialIndex: 0,
                      child: Column(
                        children: <Widget>[
                          TabBar(
                              isScrollable: true,
                              indicatorColor: Color(0xffe41589),
                              tabs: [
                                Tab(
                                  text: 'Diet',
                                ),
                                Tab(text: 'Exercise'),
                                Tab(
                                  text: 'Medical',
                                ),
                                Tab(text: 'Medicine'),
                                Tab(
                                  text: 'Symptoms',
                                ),
                                Tab(text: 'Contraction Counter'),
                              ]),
                          SingleChildScrollView(
                            child: Container(
                              height: 800,
                              child: TabBarView(
                                children: <Widget>[
                                  Diet(widget.clientId),
                                  Exercise(widget.clientId),
                                  Medical(widget.clientId),
                                  Medicine(widget.clientId),
                                  SymptomsView(widget.clientId),
                                  Contraction(widget.clientId),
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