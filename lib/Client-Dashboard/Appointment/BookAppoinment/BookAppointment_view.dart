import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/DoctorList/DoctorList_model.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'BookAppoinment_controller.dart';

class BookAppointment extends StatefulWidget {
  BookAppointment(this.doctorInfo);
  final DoctorListItem doctorInfo;

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            BookAppoinmentController(context, widget.doctorInfo),
        child: Consumer<BookAppoinmentController>(
            builder: (context, controller, child) {
          return Scaffold(
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
                  'Book Appointment',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Background.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SfDateRangePicker(
                      view: DateRangePickerView.month,
                      onSelectionChanged:
                          (DateRangePickerSelectionChangedArgs args) {
                        controller.date = args.value;
                        // print(date);
                        print(Global.getSelectedDate(args.value));
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 30),
                      child: Text(
                        'Section 1',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffe14589),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 2.7,
                        children: [
                          DoctorTimingData("10:00", controller),
                          DoctorTimingData("10:30", controller),
                          DoctorTimingData("11:00", controller),
                          DoctorTimingData("11:30", controller),
                          DoctorTimingData("12:00", controller),
                          DoctorTimingData("12:30", controller),
                          DoctorTimingData("13:00", controller),
                          DoctorTimingData("13:30", controller),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 25, top: 30),
                      child: Text(
                        'Section 2',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffe14589),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: GridView.count(
                        shrinkWrap: true,
                        crossAxisCount: 3,
                        physics: NeverScrollableScrollPhysics(),
                        childAspectRatio: 2.6,
                        children: [
                          DoctorTimingData("18:00", controller),
                          DoctorTimingData("18:30", controller),
                          DoctorTimingData("19:00", controller),
                          DoctorTimingData("19:30", controller),
                          DoctorTimingData("20:00", controller),
                          DoctorTimingData("20:30", controller),
                          DoctorTimingData("21:00", controller),
                          DoctorTimingData("21:30", controller),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.state != StateEnum.loading)
                          controller.onMakeAnAppointmentPressed();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        height: 54,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color(0xffe41589),
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0x17000000),
                              offset: Offset(0, 15),
                              blurRadius: 15,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: controller.state == StateEnum.loading
                            ? CircularProgressIndicator()
                            : Text(
                                'Book Appointment',
                                style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }));
  }
}

class DoctorTimingData extends StatelessWidget {
  DoctorTimingData(
    this.thisTime,
    this.controller, {
    Key? key,
  }) : super(key: key);
  String thisTime;
  BookAppoinmentController controller;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(thisTime);
        controller.selectTime(thisTime);
      },
      child: Container(
        margin: EdgeInsets.only(left: 20, top: 10),
        decoration: BoxDecoration(
          color: (controller.time == thisTime)
              ? Color(0xffe14589)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 2),
              child: Icon(
                Icons.access_time,
                color: Colors.black,
                size: 15,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 2),
              child: Text(
                thisTime,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}