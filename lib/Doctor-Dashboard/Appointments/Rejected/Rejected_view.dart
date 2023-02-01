import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/Appointments/AppointmentsModel.dart';
import 'package:shebirth/Doctor-Dashboard/ClientProfile/ClientProfile.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../AppointmentsController.dart';

class RejectedAppointment extends StatefulWidget {
  @override
  _RejectedAppointmentState createState() => _RejectedAppointmentState();
}

class _RejectedAppointmentState extends State<RejectedAppointment> {
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
                        ? controller.model!.rejected!.isEmpty
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
                                      Data(controller.model!.rejected![index]),
                                  itemCount: controller.model!.rejected!.length,
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
          height: 180,
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
                        Text(
                          model.week.toString() +
                              " Weeks " +
                              model.days.toString() +
                              " Days Left", //TODO:
                          style: GoogleFonts.poppins(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 50,
                      thickness: .8,
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Date : " + (model.formatedDate ?? "Not available"),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Time : " + (model.formatedTime ?? "Not available"),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                          ),
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
