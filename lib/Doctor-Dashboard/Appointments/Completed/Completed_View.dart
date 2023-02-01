import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/Appointments/AppointmentsModel.dart';
import 'package:shebirth/Doctor-Dashboard/Summary/Summary.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../../Summary/Summary.dart';
import '../AppointmentsController.dart';

class CompletedAppointment extends StatefulWidget {
  @override
  _CompletedAppointmentState createState() => _CompletedAppointmentState();
}

class _CompletedAppointmentState extends State<CompletedAppointment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppointmentsController(context),
      child: Consumer<AppointmentsController>(
          builder: (context, controller, child) {
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
                        ? controller.model!.completed!.isEmpty
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
                                  itemBuilder: (_, int index) =>
                                      Data(controller.model!.completed![index]),
                                  itemCount:
                                      controller.model!.completed!.length,
                                ),
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchFullAppointments();
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
  Data(this.model);
  AppointmentTypeModel model;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: model.client_profile_pic == null
                  ? CircleAvatar(
                      backgroundImage: AssetImage('assets/Client dummy.png'),
                      radius: 35,
                    )
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                        model.client_profile_pic.toString(),
                      ),
                      radius: 35,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Text(
                    (model.clientName.toString().capitalize()),
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.white),
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
                  Divider(
                    height: 20,
                    thickness: .8,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 25,
                                width: 150,
                                margin: EdgeInsets.only(bottom: 10),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffe14589),
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) =>
                                          Summary(value: model.id),
                                      backgroundColor: Colors.transparent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(20)),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Summary",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Date : " +
                                      (model.formatedDate ?? "Not available"),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  "Time : " +
                                      (model.formatedTime ?? "Not available"),
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
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
          ],
        ),
      ),
    );
  }
}
