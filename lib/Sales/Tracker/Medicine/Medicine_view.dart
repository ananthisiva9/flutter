import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Medicine_controller.dart';
import 'Medicine_model.dart';

class Medicine extends StatefulWidget {
  int id;
  Medicine(this.id);
  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, MedicineController controller) async {
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
        controller.fetchMedicine();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(MedicineController controller) {
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
      create: (context) => MedicineController(
          context: context,
          customerid: widget.id.toString(),
          selectedDate: Global.getSelectedDate(_date)),
      child:
          Consumer<MedicineController>(builder: (context, controller, child) {
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
                            _buildContainer(controller),
                          ],
                        )
                      : Center(
                          child: ErrorRefreshIcon(onPressed: () {
                            controller.fetchMedicine();
                          }),
                        ),
            ],
          )),
        );
      }),
    );
  }

  Widget _buildContainer(MedicineController controller) {
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
                  Text(
                    "Morning Before Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildMorningbf(
                      controller.filterMedicine("morning before food")),
                  Text(
                    "Morning After Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildMorningaf(
                      controller.filterMedicine("morning after food")),
                  Text(
                    "Lunch Before Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildLunchbf(
                      controller.filterMedicine("afternoon before food")),
                  Text(
                    "Lunch After Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildLunchaf(
                      controller.filterMedicine("afternoon after food")),
                  Text(
                    "Night Before Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildNightbf(controller.filterMedicine("night before food")),
                  Text(
                    "Night After Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildNightaf(controller.filterMedicine("night after food")),
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

Widget _buildMorningbf(MedicineModelItem? model) {
  return SingleChildScrollView(
    child: Container(
      height: 100,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
      ),
      child: (model == null)
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
          : (model.medicines == null ||
                  model.medicines!.isEmpty ||
                  (model.medicines!
                          .where((element) => element.taken == true)
                          .toList()
                          .length ==
                      0))
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
                          model.medicines![index].taken == false
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  itemCount: model.medicines!.length,
                  scrollDirection: Axis.vertical,
                ),
    ),
  );
}

Widget _buildMorningaf(MedicineModelItem? model) {
  return SingleChildScrollView(
    child: Container(
      height: 100,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
      ),
      child: (model == null)
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
          : (model.medicines == null ||
                  model.medicines!.isEmpty ||
                  (model.medicines!
                          .where((element) => element.taken == true)
                          .toList()
                          .length ==
                      0))
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
                          model.medicines![index].taken == false
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  itemCount: model.medicines!.length,
                  scrollDirection: Axis.vertical,
                ),
    ),
  );
}

Widget _buildLunchbf(MedicineModelItem? model) {
  return SingleChildScrollView(
    child: Container(
      height: 100,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
      ),
      child: (model == null)
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
          : (model.medicines == null ||
                  model.medicines!.isEmpty ||
                  (model.medicines!
                          .where((element) => element.taken == true)
                          .toList()
                          .length ==
                      0))
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
                          model.medicines![index].taken == false
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  itemCount: model.medicines!.length,
                  scrollDirection: Axis.vertical,
                ),
    ),
  );
}

Widget _buildLunchaf(MedicineModelItem? model) {
  return SingleChildScrollView(
    child: Container(
      height: 100,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
      ),
      child: (model == null)
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
          : (model.medicines == null ||
                  model.medicines!.isEmpty ||
                  (model.medicines!
                          .where((element) => element.taken == true)
                          .toList()
                          .length ==
                      0))
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
                          model.medicines![index].taken == false
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  itemCount: model.medicines!.length,
                  scrollDirection: Axis.vertical,
                ),
    ),
  );
}

Widget _buildNightbf(MedicineModelItem? model) {
  return SingleChildScrollView(
    child: Container(
      height: 100,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
      ),
      child: (model == null)
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
          : (model.medicines == null ||
                  model.medicines!.isEmpty ||
                  (model.medicines!
                          .where((element) => element.taken == true)
                          .toList()
                          .length ==
                      0))
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
                          model.medicines![index].taken == false
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  itemCount: model.medicines!.length,
                  scrollDirection: Axis.vertical,
                ),
    ),
  );
}

Widget _buildNightaf(MedicineModelItem? model) {
  return SingleChildScrollView(
    child: Container(
      height: 100,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withOpacity(0.1),
      ),
      child: (model == null)
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
          : (model.medicines == null ||
                  model.medicines!.isEmpty ||
                  (model.medicines!
                          .where((element) => element.taken == true)
                          .toList()
                          .length ==
                      0))
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
                          model.medicines![index].taken == false
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.lightBlueAccent,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                  itemCount: model.medicines!.length,
                  scrollDirection: Axis.vertical,
                ),
    ),
  );
}
