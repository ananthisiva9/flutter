import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/Appointment/resheduleAppointment/Reshedule_view.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'Upcoming_Controller.dart';
import 'Upcoming_Model.dart';

class UpComing extends StatefulWidget {
  @override
  _UpComingState createState() => _UpComingState();
}

class _UpComingState extends State<UpComing> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UpcomingController(context),
      child:
          Consumer<UpcomingController>(builder: (context, controller, child) {
        return Scaffold(
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
                      ? (controller.model != null &&
                              controller.model!.items != null &&
                              controller.model!.items!.isNotEmpty)
                          ? new ListView.builder(
                              itemBuilder: (_, int index) => Data(
                                  controller.model!.items![index], controller),
                              itemCount: controller.model!.items!.length)
                          : Center(
                              child: Text(
                                "No appointments available",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                      : Center(child: ErrorRefreshIcon(onPressed: () {
                          controller.fetchAllUpcoming()();
                        })),
            ],
          ),
        );
      }),
    );
  }
}

class Data extends StatelessWidget {
  UpcomingItem item;
  UpcomingController controller;
  Data(this.item, this.controller);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 225,
        width: 380,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: item.doctor_profile_pic == null
                  ? CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: AssetImage('assets/Client dummy.png'),
                radius: 35,
              )
                  : CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: NetworkImage(
                  item.doctor_profile_pic.toString(),
                ),
                radius: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      item.doctorFirstname == null ||
                              item.doctorLastname == null
                          ? "Not Available"
                          : ("Dr " +
                              item.doctorFirstname! +
                              " " +
                              item.doctorLastname!),
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        item.doctorQualification ?? "Not Available",
                        style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          item.doctorExperience == null
                              ? "Not Available"
                              : (item.doctorExperience!.toString() +
                                  " years of Experience"),
                          style: GoogleFonts.poppins(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 10,
                    thickness: .8,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 100,
                            color: Color(0xffe14589),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Slot",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.date ?? "Not Available",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      item.time ?? "Not Available",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 25,
                                width: 125,
                                margin: EdgeInsets.only(bottom: 20),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.blue // foreground (text) color
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Reschedule(item),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Reschedule",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        height: 10,
                        thickness: .1,
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            height: 25,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.blue // foreground (text) color
                              ),
                              onPressed: () {
                                if (item.meetingUrl != null) {
                                  controller.launchMeeting(item.meetingUrl!);
                                }
                              },
                              child: Text(
                                item.meetingUrl == null
                                    ? "No meeting link found"
                                    : "Join",
                                style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 15,
                                    fontFamily: 'Gilroy'),
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
          ],
        ),
      ),
    );
  }
}
