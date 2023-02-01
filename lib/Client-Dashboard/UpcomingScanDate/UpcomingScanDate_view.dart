import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import '../DisplayScreen.dart';
import 'UpcomingScanDate_controller.dart';
import 'UpcomingScanDate_model.dart';

class ScanDates extends StatefulWidget {
  @override
  _ScanDatesState createState() => _ScanDatesState();
}

class _ScanDatesState extends State<ScanDates> {
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => UpcomingScanDateController(context),
        child: Consumer<UpcomingScanDateController>(
            builder: (context, controller, child) {
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
                  title: Text(
                    "UpComing Scan Dates",
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
              body: Stack(children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset('assets/Background.png').image,
                          fit: BoxFit.cover)),
                ),
                controller.state == StateEnum.loading
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Center(child: LoadingIcon()),
                      )
                    : controller.state == StateEnum.success
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              _buildContainer(controller.model!),
                            ],
                          )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchAllUpcomingScanDate();
                            }),
                          ),
              ]),
            ),
          );
        }));
  }

  Widget _buildContainer(UpcomingScanDateModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Consulting Doctor :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildDoctorName(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Estimated Due Date :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildEstimatedDate(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Last Menstrual Date :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildLastMenstrualDate(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Probable Due Date :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildConceptionDate(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Foetal Age :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildFoetalAge(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Best Date Range For Dating Scan (8th Week) :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildDatingScan(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Best Date range for NT Scan (12th-13th Week) :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildNTScan(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Best Date range for Morphology Scan (19th Week) :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildMorphologyScan(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Best Date range for Anomaly Scan (20th-22th Week) :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildAnomalyScan(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Best Date Range For Growth Scan (32th-34th Week) :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildGrowthScan(model),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Previous UltraSound Date and Foetal Age on that Day :",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                          fontWeight: FontWeight.bold),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  _buildUTScan(model),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildDoctorName(UpcomingScanDateModel model) {
  return Container(
    height: 75,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.doctor == null ? "Not Available" : ("Dr" + model.doctor!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget _buildEstimatedDate(UpcomingScanDateModel model) {
  return Container(
    height: 75,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.dueDate == null ? "Not Available" : (model.dueDate!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget _buildLastMenstrualDate(UpcomingScanDateModel model) {
  return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.lastMenstrualDate == null
                  ? "Not Available"
                  : (model.lastMenstrualDate!),
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
}

Widget _buildConceptionDate(UpcomingScanDateModel model) {
  return Container(
    height: 75,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.probableDate == null
                ? "Not Available"
                : (model.probableDate!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget _buildFoetalAge(UpcomingScanDateModel model) {
  return Container(
      height: 100,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              model.foetalDays == null
                  ? "Not Available"
                  : (model.foetalDays!.toString()),
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ));
}

Widget _buildDatingScan(UpcomingScanDateModel model) {
  return Container(
    height: 100,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.datingScan == null ? "Not Available" : (model.datingScan!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget _buildNTScan(UpcomingScanDateModel model) {
  return Container(
    height: 100,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.ntScan == null ? "Not Available" : (model.ntScan!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget _buildMorphologyScan(UpcomingScanDateModel model) {
  return Container(
    height: 125,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.morphologyScan == null
                ? "Not Available"
                : (model.morphologyScan!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget _buildAnomalyScan(UpcomingScanDateModel model) {
  return Container(
    height: 125,
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      width: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          model.anomalyScan == null ? "Not Available" : (model.anomalyScan!),
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}

Widget _buildGrowthScan(UpcomingScanDateModel model) {
  return Container(
    height: 125,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.growthScan == null ? "Not Available" : (model.growthScan!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}

Widget _buildUTScan(UpcomingScanDateModel model) {
  return Container(
    height: 125,
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            model.lastScanDetails == null
                ? "Not Available"
                : (model.lastScanDetails!),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 15,
                color: Colors.white,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ),
  );
}
