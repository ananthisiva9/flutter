import 'dart:ui';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'Diet_controller.dart';
import 'Diet_model.dart';

class diet extends StatefulWidget {
  int id;
  diet(this.id);
  @override
  _dietState createState() => _dietState();
}

class _dietState extends State<diet> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, DietController controller) async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (_datepicker != null && _datepicker != _date) {
      controller.changeSelectedDate(_datepicker);
      setState(() {
        _date = _datepicker;
        controller.setSelectedDate(_date);
        controller.fetchDiet();
      });
    }
  }

  Widget _buildDate(DietController controller) {
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
          style: TextStyle(color: Colors.white, fontSize: 15),
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
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return ChangeNotifierProvider(
      create: (context) => DietController(context: context,customerid: widget.id.toString()),
      child: Consumer<DietController>(builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10)),
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
                          Expanded(
                            child: Text(
                              "Diet Tracker",
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
                      const Divider(
                        height: 5,
                        thickness: .2,
                        color: Colors.white,
                      ),
                      controller.state == StateEnum.loading
                          ? const Center(child: LoadingIcon())
                          : controller.state == StateEnum.success
                              ? SingleChildScrollView(
                                  child: Container(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Stack(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              _buildEarlyMorning(
                                                  controller.filterDiet(
                                                      "early morning"),
                                                  controller),
                                              _buildBreakfast(
                                                  controller
                                                      .filterDiet("breakfast"),
                                                  controller),
                                              _buildMidDay(
                                                  controller.filterDiet(
                                                      "mid day snack"),
                                                  controller),
                                              _buildLunch(
                                                  controller
                                                      .filterDiet("lunch"),
                                                  controller),
                                              _buildEveningSnack(
                                                  controller.filterDiet(
                                                      "afternoon snack"),
                                                  controller),
                                              _buildDinner(
                                                  controller
                                                      .filterDiet("dinner"),
                                                  controller),
                                              _buildDinnerDrink(
                                                  controller.filterDiet(
                                                      "dinner drink"),
                                                  controller),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    children: [
                                      ErrorRefreshIcon(onPressed: () {
                                        controller.fetchDiet();
                                      }),
                                      Text(controller.errorMessage ?? "")
                                    ],
                                  ),
                                )
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

Widget _buildEarlyMorning(Diet? diet, DietController controller) {
  controller.morningDrinkEnergyController.text =
      diet == null ? "" : diet.food ?? "";
  controller.morningDrinkTimeController.text =
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
            const Image(
              image: AssetImage('assets/Morning.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Morning",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                        textStyle: const TextStyle(
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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: controller.morningDrinkEnergyController,
                    decoration: const InputDecoration(
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
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: controller.morningDrinkTimeController,
                        decoration: const InputDecoration(
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
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.onAddPressed(
                    mealType: MealNames.early_morning,
                    food: controller.morningDrinkEnergyController.text,
                    time: controller.morningDrinkTimeController.text);
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 50,
                ),
                alignment: Alignment.center,
                child: const Text(
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

Widget _buildBreakfast(Diet? diet, DietController controller) {
  controller.breakfastEnergyController.text =
      diet == null ? "" : diet.food ?? "";
  controller.breakfastTimeController.text = diet == null ? "" : diet.time ?? "";
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
            const Image(
              image: AssetImage('assets/Breakfast.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Breakfast",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: controller.breakfastEnergyController,
                    decoration: const InputDecoration(
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
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: controller.breakfastTimeController,
                        decoration: const InputDecoration(
                          hintText: 'Time',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Avenir'),
                          enabledBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder:  UnderlineInputBorder(
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
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.onAddPressed(
                    mealType: MealNames.breakfast,
                    food: controller.breakfastEnergyController.text,
                    time: controller.breakfastTimeController.text);
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 50,
                ),
                alignment: Alignment.center,
                child: const Text(
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

Widget _buildMidDay(Diet? diet, DietController controller) {
  controller.middaySnackEnergyController.text =
      diet == null ? "" : diet.food ?? "";
  controller.middaySnackTimeController.text =
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
            const Image(
              image: AssetImage('assets/Mornig Snack.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Mid-Day",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                        textStyle: const TextStyle(
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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: controller.middaySnackEnergyController,
                    decoration: const InputDecoration(
                      hintText: 'Energy',
                      hintStyle:  TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Avenir'),
                      enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder:  UnderlineInputBorder(
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
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: controller.middaySnackTimeController,
                        decoration: const InputDecoration(
                          hintText: 'Time',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Avenir'),
                          enabledBorder: UnderlineInputBorder(
                            borderSide:  BorderSide(color: Colors.white),
                          ),
                          focusedBorder:  UnderlineInputBorder(
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
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.onAddPressed(
                    mealType: MealNames.mid_day_snack,
                    food: controller.middaySnackEnergyController.text,
                    time: controller.middaySnackTimeController.text);
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 50,
                ),
                alignment: Alignment.center,
                child: const Text(
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

Widget _buildLunch(Diet? diet, DietController controller) {
  controller.lunchEnergyController.text = diet == null ? "" : diet.food ?? "";
  controller.lunchTimeController.text = diet == null ? "" : diet.time ?? "";
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
            const Image(
              image: AssetImage('assets/Lunch.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Lunch",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: controller.lunchEnergyController,
                    decoration: const InputDecoration(
                      hintText: 'Energy',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Avenir'),
                      enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder:  UnderlineInputBorder(
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
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: controller.lunchTimeController,
                        decoration: const InputDecoration(
                          hintText: 'Time',
                          hintStyle:  TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Avenir'),
                          enabledBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder:  UnderlineInputBorder(
                            borderSide:  BorderSide(color: Colors.white),
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
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.onAddPressed(
                    mealType: MealNames.lunch,
                    food: controller.lunchEnergyController.text,
                    time: controller.lunchTimeController.text);
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 50,
                ),
                alignment: Alignment.center,
                child: const Text(
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

Widget _buildEveningSnack(Diet? diet, DietController controller) {
  controller.eveningSnackEnergyController.text =
      diet == null ? "" : diet.food ?? "";
  controller.eveningSnackTimeController.text =
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
            const Image(
              image: AssetImage('assets/Evening Snack.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Evening",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                        textStyle: const TextStyle(
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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: controller.eveningSnackEnergyController,
                    decoration: const InputDecoration(
                      hintText: 'Energy',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Avenir'),
                      enabledBorder:  UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder:  UnderlineInputBorder(
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
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: controller.eveningSnackTimeController,
                        decoration: const InputDecoration(
                          hintText: 'Time',
                          hintStyle:  TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Avenir'),
                          enabledBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder:  UnderlineInputBorder(
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
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.onAddPressed(
                    mealType: MealNames.afternoon_snack,
                    food: controller.eveningSnackEnergyController.text,
                    time: controller.eveningSnackTimeController.text);
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 50,
                ),
                alignment: Alignment.center,
                child: const Text(
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

Widget _buildDinner(Diet? diet, DietController controller) {
  controller.dinnerEnergyController.text = diet == null ? "" : diet.food ?? "";
  controller.dinnerTimeController.text = diet == null ? "" : diet.time ?? "";

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
            const Image(
              image: AssetImage('assets/Dinner.png'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    "Dinner",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: controller.dinnerEnergyController,
                    decoration: const InputDecoration(
                      hintText: 'Energy',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Avenir'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
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
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: controller.dinnerTimeController,
                        decoration: const InputDecoration(
                          hintText: 'Time',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Avenir'),
                          enabledBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder:  UnderlineInputBorder(
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
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.onAddPressed(
                    mealType: MealNames.dinner,
                    food: controller.dinnerEnergyController.text,
                    time: controller.dinnerTimeController.text);
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 50,
                ),
                alignment: Alignment.center,
                child: const Text(
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

Widget _buildDinnerDrink(Diet? diet, DietController controller) {
  controller.dinnerDrinkEnergyController.text =
      diet == null ? "" : diet.food ?? "";
  controller.dinnerDrinkTimeController.text =
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
            const Image(
              image: AssetImage('assets/Dinner Drink.png'),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Text(
                    "Dinner",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                        textStyle: const TextStyle(
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
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    controller: controller.dinnerDrinkEnergyController,
                    decoration: const InputDecoration(
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
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        keyboardType: TextInputType.text,
                        controller: controller.dinnerDrinkTimeController,
                        decoration: const InputDecoration(
                          hintText: 'Time',
                          hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Avenir'),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
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
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                controller.onAddPressed(
                    mealType: MealNames.dinner_drink,
                    food: controller.dinnerDrinkEnergyController.text,
                    time: controller.dinnerDrinkTimeController.text);
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 25,
                  maxWidth: 50,
                ),
                alignment: Alignment.center,
                child: const Text(
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
