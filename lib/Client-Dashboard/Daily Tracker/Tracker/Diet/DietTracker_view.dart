import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Diet/Diet_controller.dart';
import 'Diet/Diet_model.dart';

class DietTracker extends StatefulWidget {
  DietTracker(this.controller);
  DietController controller;
  @override
  _DietTrackerState createState() => _DietTrackerState();
}

class _DietTrackerState extends State<DietTracker> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildEarlyMorning(
                      widget.controller.filterDiet("early morning")),
                  _buildBreakfast(widget.controller.filterDiet("breakfast")),
                  _buildMidDay(widget.controller.filterDiet("mid day snack")),
                  _buildLunch(widget.controller.filterDiet("lunch")),
                  _buildEveningSnack(
                      widget.controller.filterDiet("afternoon snack")),
                  _buildDinner(widget.controller.filterDiet("dinner")),
                  _buildDinnerDrink(
                      widget.controller.filterDiet("dinner drink")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEarlyMorning(Diet? diet) {
    widget.controller.morningDrinkEnergyController.text =
        diet == null ? "" : diet.food ?? "";
    widget.controller.morningDrinkTimeController.text =
        diet == null ? "" : diet.time ?? "";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 380,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Morning.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Morning",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Drink",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 75,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller:
                          widget.controller.morningDrinkEnergyController,
                      decoration: InputDecoration(
                        hintText: 'Energy',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Avenir'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 75,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          controller:
                              widget.controller.morningDrinkTimeController,
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Avenir'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),// foreground (text) color
                ),
                onPressed: () {
                  widget.controller.onAddPressed(
                      mealType: MealNames.early_morning,
                      food: widget.controller.morningDrinkEnergyController.text,
                      time: widget.controller.morningDrinkTimeController.text);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreakfast(Diet? diet) {
    widget.controller.breakfastEnergyController.text =
        diet == null ? "" : diet.food ?? "";
    widget.controller.breakfastTimeController.text =
        diet == null ? "" : diet.time ?? "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 380,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Breakfast.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Breakfast",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 75,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: widget.controller.breakfastEnergyController,
                      decoration: InputDecoration(
                        hintText: 'Energy',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Avenir'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 75,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          controller: widget.controller.breakfastTimeController,
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Avenir'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),// foreground (text) color
                ),
                onPressed: () {
                  widget.controller.onAddPressed(
                      mealType: MealNames.breakfast,
                      food: widget.controller.breakfastEnergyController.text,
                      time: widget.controller.breakfastTimeController.text);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMidDay(Diet? diet) {
    widget.controller.middaySnackEnergyController.text =
        diet == null ? "" : diet.food ?? "";
    widget.controller.middaySnackTimeController.text =
        diet == null ? "" : diet.time ?? "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 380,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Mornig Snack.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Mid-Day",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Snack",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 75,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: widget.controller.middaySnackEnergyController,
                      decoration: InputDecoration(
                        hintText: 'Energy',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Avenir'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 75,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          controller:
                              widget.controller.middaySnackTimeController,
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Avenir'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),// foreground (text) color
                ),
                onPressed: () {
                  widget.controller.onAddPressed(
                      mealType: MealNames.mid_day_snack,
                      food: widget.controller.middaySnackEnergyController.text,
                      time: widget.controller.middaySnackTimeController.text);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLunch(Diet? diet) {
    widget.controller.lunchEnergyController.text =
        diet == null ? "" : diet.food ?? "";
    widget.controller.lunchTimeController.text =
        diet == null ? "" : diet.time ?? "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 380,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Lunch.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Lunch",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 75,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: widget.controller.lunchEnergyController,
                      decoration: InputDecoration(
                        hintText: 'Energy',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Avenir'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 75,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          controller: widget.controller.lunchTimeController,
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Avenir'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),// foreground (text) color
                ),
                onPressed: () {
                  widget.controller.onAddPressed(
                      mealType: MealNames.lunch,
                      food: widget.controller.lunchEnergyController.text,
                      time: widget.controller.lunchTimeController.text);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEveningSnack(Diet? diet) {
    widget.controller.eveningSnackEnergyController.text =
        diet == null ? "" : diet.food ?? "";
    widget.controller.eveningSnackTimeController.text =
        diet == null ? "" : diet.time ?? "";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 380,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Evening Snack.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Evening",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Snack",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 75,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller:
                          widget.controller.eveningSnackEnergyController,
                      decoration: InputDecoration(
                        hintText: 'Energy',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Avenir'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 75,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          controller:
                              widget.controller.eveningSnackTimeController,
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Avenir'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),// foreground (text) color
                ),
                onPressed: () {
                  widget.controller.onAddPressed(
                      mealType: MealNames.afternoon_snack,
                      food: widget.controller.eveningSnackEnergyController.text,
                      time: widget.controller.eveningSnackTimeController.text);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDinner(Diet? diet) {
    widget.controller.dinnerEnergyController.text =
        diet == null ? "" : diet.food ?? "";
    widget.controller.dinnerTimeController.text =
        diet == null ? "" : diet.time ?? "";

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 380,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Dinner.png'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      "Dinner",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 75,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: widget.controller.dinnerEnergyController,
                      decoration: InputDecoration(
                        hintText: 'Energy',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Avenir'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 75,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          controller: widget.controller.dinnerTimeController,
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Avenir'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),// foreground (text) color
                ),
                onPressed: () {
                  widget.controller.onAddPressed(
                      mealType: MealNames.dinner,
                      food: widget.controller.dinnerEnergyController.text,
                      time: widget.controller.dinnerTimeController.text);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDinnerDrink(Diet? diet) {
    widget.controller.dinnerDrinkEnergyController.text =
        diet == null ? "" : diet.food ?? "";
    widget.controller.dinnerDrinkTimeController.text =
        diet == null ? "" : diet.time ?? "";
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 110,
        width: 380,
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Dinner Drink.png'),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      "Dinner",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Drink",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 75,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.text,
                      controller: widget.controller.dinnerDrinkEnergyController,
                      decoration: InputDecoration(
                        hintText: 'Energy',
                        hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Avenir'),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        width: 75,
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.text,
                          controller:
                              widget.controller.dinnerDrinkTimeController,
                          decoration: InputDecoration(
                            hintText: 'Time',
                            hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'Avenir'),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),// foreground (text) color
                ),
                onPressed: () {
                  widget.controller.onAddPressed(
                      mealType: MealNames.dinner_drink,
                      food: widget.controller.dinnerDrinkEnergyController.text,
                      time: widget.controller.dinnerDrinkTimeController.text);
                },
                child: Container(
                  constraints: BoxConstraints(
                    maxHeight: 25,
                    maxWidth: 50,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Add",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 20,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
