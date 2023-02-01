import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Diet/Diet_model.dart';

class DietTracker extends StatefulWidget {
  DietTracker(this.dietList);
  List<Diet>? dietList;
  @override
  _DietTrackerState createState() => _DietTrackerState();
}

class _DietTrackerState extends State<DietTracker> {
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
          width: 425,
          child: (this.widget.dietList == null || this.widget.dietList!.isEmpty)
              ? Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(
                'No data available',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontFamily: 'Arial',
                ),
              ),
            ),
          )
              : Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      _buildEarlyMorning(filterDiet("early morning")),
                      _buildBreakfast(filterDiet("breakfast")),
                      _buildMidDaySnack(filterDiet("mid day snack")),
                      _buildLunch(filterDiet("lunch")),
                      _buildAfternoon(filterDiet("afternoon snack")),
                      _buildDinner(filterDiet("dinner")),
                      _buildDinnerDrink(filterDiet("dinner drink")),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Diet? filterDiet(String mealname) {
    List filteredList = this
        .widget
        .dietList!
        .where((element) => element.mealName == mealname)
        .toList();
    if (filteredList.isEmpty) {
      return null;
    } else {
      return filteredList.last;
    }
  }

  Widget _buildEarlyMorning(Diet? diet) {
    return diet == null
        ? SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Text(
                    diet.mealName.toString().capitalize() == null
                        ? "Not Available"
                        : diet.mealName!.toString().capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      diet.food.toString().capitalize() == null
                          ? "Not Available"
                          : diet.food!.toString().capitalize(),
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakfast(Diet? diet) {
    return diet == null
        ? SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Text(
                    diet.mealName.toString().capitalize() == null
                        ? "Not Available"
                        : diet.mealName!.toString().capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      diet.food.toString().capitalize() == null
                          ? "Not Available"
                          : diet.food!.toString().capitalize(),
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMidDaySnack(Diet? diet) {
    return diet == null
        ? SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Text(
                    diet.mealName.toString().capitalize() == null
                        ? "Not Available"
                        : diet.mealName!.toString().capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      diet.food.toString().capitalize() == null
                          ? "Not Available"
                          : diet.food!.toString().capitalize(),
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLunch(Diet? diet) {
    return diet == null
        ? SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Text(
                    diet.mealName.toString().capitalize() == null
                        ? "Not Available"
                        : diet.mealName!.toString().capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      diet.food.toString().capitalize() == null
                          ? "Not Available"
                          : diet.food!.toString().capitalize(),
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAfternoon(Diet? diet) {
    return diet == null
        ? SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Text(
                    diet.mealName.toString().capitalize() == null
                        ? "Not Available"
                        : diet.mealName!.toString().capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      diet.food.toString().capitalize() == null
                          ? "Not Available"
                          : diet.food!.toString().capitalize(),
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDinner(Diet? diet) {
    return diet == null
        ? SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Text(
                    diet.mealName.toString().capitalize() == null
                        ? "Not Available"
                        : diet.mealName!.toString().capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      diet.food.toString().capitalize() == null
                          ? "Not Available"
                          : diet.food!.toString().capitalize(),
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDinnerDrink(Diet? diet) {
    return diet == null
        ? SizedBox.shrink()
        : Padding(
      padding: const EdgeInsets.all(5.0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Text(
                    diet.mealName.toString().capitalize() == null
                        ? "Not Available"
                        : diet.mealName!.toString().capitalize(),
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      diet.food.toString().capitalize() == null
                          ? "Not Available"
                          : diet.food!.toString().capitalize(),
                      style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent, fontSize: 12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
