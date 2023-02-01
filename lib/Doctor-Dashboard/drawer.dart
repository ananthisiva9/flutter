import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Doctor-Dashboard/Approval%20Request/ApprovalRequest_view.dart';
import 'package:shebirth/Login/Login.dart';
import 'Appointments/Appointment.dart';
import 'ClientThisMonth/ClientThisMonth_view.dart';
import 'ClientsList/ClientList_view.dart';
import 'DisplayScreen/DisplayScreen_view.dart';
import 'MessageScreen/Chat/Chat_view.dart';
import 'Profile/Profile.dart';
import 'TodaysAppointment/TodaysAppointment_view.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> exitDialog() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: Text('Are you Sure?'),
          content: Text('Do You want to exit from the app?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Login(),
                  ),
                );
              },
              child: Text("Exit"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Display(),
                  ),
                );
              },
              child: Text("Cancel"),
            ),
          ],
        ),
      );
    }

    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/Background.png').image,
              fit: BoxFit.cover),
        ),
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Color(0xffe14589),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Hi, Doctor",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            "Profile & Other Setting",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorProfile()),
                            );
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            ListTile(
                leading: Icon(Icons.apps, color: Colors.white),
                title: Text(
                  "Overview",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Display(),
                    ),
                  );
                }),
            ListTile(
                leading:
                    Icon(Icons.calendar_today_rounded, color: Colors.white),
                title: Text(
                  "Appointment",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Appointment(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  "Patient this Month",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientThisMonth(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.today_outlined, color: Colors.white),
                title: Text(
                  "Today's Appointment",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TodaysAppointment(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.approval, color: Colors.white),
                title: Text(
                  "Approval Request",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ApprovalRequest(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.person_add_alt_1_outlined, color: Colors.white),
                title: Text(
                  "All Client List",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClientList(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.message, color: Colors.white),
                title: Text(
                  "Message",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  "LogOut",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  exitDialog();
                }),
          ],
        ),
      ),
    );
  }
}

class CustomListTile extends StatefulWidget {
  IconData icon;
  String text;
  Function onTap;
  CustomListTile(this.icon, this.text, this.onTap);

  @override
  _CustomListTileState createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: InkWell(
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(widget.icon, color: Colors.white),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: Text(
                  widget.text,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
