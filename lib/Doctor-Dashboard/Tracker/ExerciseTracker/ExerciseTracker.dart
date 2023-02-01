import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Exercise/Excercise_model.dart';

class ExerciseTracker extends StatefulWidget {
  ExerciseTracker(this.exercises, this.calorieBurnt);
  List<Exercises> exercises;
  String calorieBurnt;
  @override
  _ExerciseTrackerState createState() => _ExerciseTrackerState();
}

class _ExerciseTrackerState extends State<ExerciseTracker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black.withOpacity(0.1),
        ),
        height: 30,
        width: 425,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _buildExercise(this.widget.exercises),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Total Calories Burned",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.lightBlueAccent,
                              ),
                            ),
                          ),
                          Text(
                            this.widget.calorieBurnt,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: Colors.lightBlueAccent,
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
          ],
        ),
      ),
    );
  }

  Widget _buildExercise(List<Exercises>? excercise) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
      ),
      child: ((excercise == null) || (excercise.isEmpty))
          ? Center(
              child: Text(
                'No data available',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Arial',
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: (_, index) => Stack(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      excercise[index].completed == false
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                excercise[index].name.toString().capitalize(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    color: Colors.
                                    lightBlueAccent,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ],
              ),
              itemCount: excercise.length,
              scrollDirection: Axis.vertical,
            ),
    );
  }
}
