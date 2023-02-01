import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/ClientProfile/ClientProfile.dart';
import 'package:shebirth/Doctor-Dashboard/TodaysAppointment/TodaysAppointment_controller.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Reshedule/reshedule_view.dart';
import 'Search.dart';
import 'TodaysAppointment_model.dart';

class TodaysAppointment extends StatefulWidget {
  @override
  _ApprovedAppointmentState createState() => _ApprovedAppointmentState();
}

class _ApprovedAppointmentState extends State<TodaysAppointment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodaysAppointmentController(context),
      child: Consumer<TodaysAppointmentController>(
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
                elevation: 0,
                title: Text(
                  "Today's Appointment",
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
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showSearch(
                              context: context,
                              delegate: DataSearch(controller.model!.items!));
                        },
                      ),
                    ),
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
                controller.state == StateEnum.loading
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Center(child: LoadingIcon()),
                      )
                    : controller.state == StateEnum.success
                        ? controller.model!.items!.isEmpty
                            ? Center(
                                child: Text(
                                  'No appointments available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                child: new ListView.builder(
                                  itemBuilder: (_, int index) => Data(
                                      controller.model!.items![index],
                                      controller),
                                  itemCount: controller.model!.items!.length,
                                ),
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchTodaysAppointment();
                            }),
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Data extends StatelessWidget {
  Data(this.model, this.controller);
  TodaysAppointmentItem model;
  TodaysAppointmentController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 220,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: model.client_profile_pic == null
                    ? CircleAvatar(
                  backgroundColor: Colors.cyan[100],
                  backgroundImage: AssetImage('assets/Client dummy.png'),
                  radius: 35,
                )
                    : CircleAvatar(
                  backgroundColor: Colors.cyan[100],
                  backgroundImage: NetworkImage(
                    model.client_profile_pic.toString(),
                  ),
                  radius: 35,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Text(
                          (model.firstname.toString().capitalize()) +
                              " " +
                              (model.lastname.toString().capitalize()),
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            model.location.toString().capitalize(),
                            style: GoogleFonts.poppins(
                              color: Colors.lightBlueAccent,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                text: model.week.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: " and ",
                                style: GoogleFonts.poppins(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: model.days.toString(),
                                style: GoogleFonts.poppins(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: "days left",
                                style: GoogleFonts.poppins(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Date : " + (model.date ?? "Not available"),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.lightBlueAccent,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        thickness: .8,
                        color: Colors.white,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 25,
                                width: 150,
                                margin: EdgeInsets.only(bottom: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffe14589) ,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Reshedule(model)),
                                    );
                                  },
                                  child: Text(
                                    "Reschedule",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 25,
                                    width: 150,
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Text(
                                      "Time : " +
                                          (model.time ?? "Not available"),
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                width: 75,
                                margin: EdgeInsets.only(bottom: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue ,
                                  ),
                                  onPressed: () {
                                    if (model.meetingUrl != null) {
                                      controller
                                          .launchMeeting(model.meetingUrl!);
                                    }
                                  },
                                  child: Text(
                                    model.meetingUrl == null
                                        ? "No meeting link found"
                                        : "Join",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
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
}
