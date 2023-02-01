import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Consultation-Dashboard/Tracker/Symptom/symptom_controller.dart';
import 'package:shebirth/Consultation-Dashboard/Tracker/Symptom/symptom_model.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';

class SymptomsView extends StatefulWidget {
  int id;
  SymptomsView(this.id);
  @override
  _SymptomsViewState createState() => _SymptomsViewState();
}

class _SymptomsViewState extends State<SymptomsView> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, SymptomsController controller) async {
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
        controller.fetchSymptom();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(SymptomsController controller) {
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
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Select Date:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ),
        ),
        Text(
          _date.day.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.month.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.year.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SymptomsController(
            context: context,
            customerid: widget.id.toString(),
            selectedDate: Global.getSelectedDate(_date)),
        child:
        Consumer<SymptomsController>(builder: (context, controller, child) {
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: <Widget>[
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
                      _buildDate(controller),
                      _buildContainer(controller.model),
                    ],
                  )
                      : Center(
                    child: ErrorRefreshIcon(onPressed: () {
                      controller.fetchSymptom();
                    }),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildContainer(SymptomsModel? model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
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
                  _buildSymptoms(model!.symptoms),
                  Divider(
                    height: 10,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildWeight(model.symptomsWithIputs),
                  Divider(
                    height: 10,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildBSL(model.symptomsWithIputs),
                  Divider(
                    height: 10,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildBPL(model.symptomsWithIputs),
                  Divider(
                    height: 10,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildReport(model.symptomsWithIputs),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildSymptoms(List<Symptoms>? symptom) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.black.withOpacity(0.1),
    ),
    height: 250,
    width: 370,
    child: Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ((symptom == null) ||
              (symptom.isEmpty) ||
              (symptom
                  .where((element) => element.positive == true)
                  .toList()
                  .length ==
                  0))
              ? Center(
            child: Text(
              'No symptoms',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Arial',
              ),
            ),
          )
              : Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Symptoms : ",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    height: 300,
                    width: 250,
                    child: ListView.builder(
                        itemCount: symptom.length,
                        itemBuilder: (_, int index) {
                          return (symptom[index].name == null ||
                              symptom[index].positive == false)
                              ? SizedBox.shrink()
                              : Column(
                            children: <Widget>[
                              Text(
                                symptom[index]
                                    .name!
                                    .toString()
                                    .capitalize(),
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontSize: 12,
                                    color: Colors.lightBlueAccent,
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildWeight(List<SymptomsWithIputs>? symptomsWithIputs) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Weight",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            (symptomsWithIputs == null || symptomsWithIputs.isEmpty)
                ? "No Data"
                : symptomsWithIputs.first.weight == null
                ? "No Data"
                : symptomsWithIputs.first.weight.toString(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBSL(List<SymptomsWithIputs>? symptomsWithIputs) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Blood Sugar Level",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            (symptomsWithIputs == null || symptomsWithIputs.isEmpty)
                ? "No Data"
                : symptomsWithIputs.first.bloodSugar == null
                ? "No Data"
                : symptomsWithIputs.first.bloodSugar.toString(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBPL(List<SymptomsWithIputs>? symptomsWithIputs) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Blood Pressure Level",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            (symptomsWithIputs == null || symptomsWithIputs.isEmpty)
                ? "No Data"
                : symptomsWithIputs.first.bloodPressure == null
                ? "No Data"
                : symptomsWithIputs.first.bloodPressure.toString(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildReport(List<SymptomsWithIputs>? symptomsWithIputs) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Last Week Report ",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            (symptomsWithIputs == null || symptomsWithIputs.isEmpty)
                ? "No Data"
                : symptomsWithIputs.first.report.toString().capitalize() == null
                ? "No Data"
                : symptomsWithIputs.first.report.toString().capitalize(),
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
