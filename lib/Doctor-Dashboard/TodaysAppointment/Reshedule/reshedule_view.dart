import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/TodaysAppointment/Reshedule/reshedule_controller.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../TodaysAppointment_model.dart';

class Reshedule extends StatefulWidget {
  Reshedule(this.doctorInfo);
  final TodaysAppointmentItem doctorInfo;

  @override
  _ResheduleState createState() => _ResheduleState();
}

class _ResheduleState extends State<Reshedule> {
  @override

  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) =>
            ResheduleController(context, widget.doctorInfo),
        child: Consumer<ResheduleController>(
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
                            style: TextStyle(
                              color: Color(0xffe41589),
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
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
                            style: TextStyle(
                              color: Color(0xffe41589),
                              fontSize: 25,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w700,
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
                              'Make An Appointment',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
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
  ResheduleController controller;
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
                size: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 2),
              child: Text(
                thisTime,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
