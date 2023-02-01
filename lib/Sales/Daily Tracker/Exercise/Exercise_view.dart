import 'dart:ui';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'CustomizedTracker/CustomizedTracker_view.dart';
import 'Exercise_Tracker/exercise_Tracker_view.dart';
import 'Exercise_controller.dart';

class Exercise extends StatefulWidget {
  int id;
  Exercise(this.id);
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, ExerciseController controller) async {
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

  Widget _buildDate(ExerciseController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextButton(
              onPressed: () {
                setState(() {
                  _selectDate(context, controller);
                });
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              )),
        ),
        Text(
          _date.day.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const Text(
          '/',
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.month.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.year.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                _selectDate(context, controller);
              });
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            )),
      ],
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
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
                      margin: const EdgeInsets.only(right: 15),
                      child: IconButton(
                        icon: const Icon(
                          Icons.home,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalesDisplay(),
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
                  _buildContainer(),
                ],
              )
            ],
          )),
    );
  }

  Widget _buildContainer() {
    return ChangeNotifierProvider(
      create: (context) => ExerciseController(context: context,customerid: widget.id.toString()),
      child:
          Consumer<ExerciseController>(builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: const Radius.circular(10), topLeft: const Radius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.72,
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
                          const Divider(
                            height: 50,
                          ),
                          Expanded(
                            child: Text(
                              "Exercise Tracker",
                              maxLines: 2,
                              style: GoogleFonts.poppins(
                                textStyle: const TextStyle(
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
                          initialIndex: 0,
                          child: Column(
                            children: <Widget>[
                              const TabBar(indicatorColor: Color(0xffe14589), tabs: [
                                Tab(text: 'Exercise Tracker'),
                                Tab(text: 'Customized Tracker')
                              ]),
                              SingleChildScrollView(
                                child: Container(
                                  height: 2500,
                                  child: TabBarView(
                                    children: <Widget>[
                                      ExerciseTracker(controller),
                                      CostomizedTracker(controller),
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
