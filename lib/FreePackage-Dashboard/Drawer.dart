import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/Appointment/Appointment.dart';
import 'package:shebirth/Client-Dashboard/MessageScreen/AllMessages.dart';
import 'package:shebirth/Client-Dashboard/MyDoctor/MyDoctor_view.dart';
import 'package:shebirth/Client-Dashboard/Payments/Payments_view.dart';
import 'package:shebirth/Client-Dashboard/Privacy%20Policy/Tearms%20and%20Conditions.dart';
import 'package:shebirth/Client-Dashboard/Profile/Detail.dart';
import 'package:shebirth/Client-Dashboard/Report/Report.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/SupportTeam.dart';
import 'package:shebirth/Client-Dashboard/UpcomingScanDate/UpcomingScanDate_view.dart';
import 'package:shebirth/FreePackage-Dashboard/Package-Display.dart';
import 'package:shebirth/Login/Login.dart';

class NavigationDrawer extends StatefulWidget {
  final int? value;
  NavigationDrawer({Key? key, this.value}) : super(key: key);
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
            ElevatedButton(
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
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PackageDisplay(),
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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Color(0xffe14589),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Hi, Super Mom",
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Divider(
                        height: 10,
                        thickness: .01,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            child: Text(
                              "Profile & Other Setting",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Profile()),
                              );
                            },
                          )
                        ],
                      )
                    ],
                  ),
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
                      builder: (context) => PackageDisplay(),
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
                leading: Icon(Icons.medical_services, color: Colors.white),
                title: Text(
                  "Support Team",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SupportTeam(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.person, color: Colors.white),
                title: Text(
                  "My Doctor",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyDoctor(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.payment, color: Colors.white),
                title: Text(
                  "Payment",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Payment(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.scanner, color: Colors.white),
                title: Text(
                  "Scan Details",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ScanDates(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.scanner, color: Colors.white),
                title: Text(
                  "Last Week Report",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Report(),
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
                      builder: (context) => AllMessages(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.speaker_notes_sharp, color: Colors.white),
                title: Text(
                  "Terms of Use",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Terms(),
                    ),
                  );
                }),
            ListTile(
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text(
                  "Logout",
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