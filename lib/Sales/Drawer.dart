import 'package:admin_dashboard/Login/Login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Appointment/Doctor/Doctor.dart';
import 'Display/Display.dart';
import 'MessageScreen/Chat/Chat_view.dart';

class SalesDrawer extends StatefulWidget {
  @override
  _SalesDrawerState createState() => _SalesDrawerState();
}

class _SalesDrawerState extends State<SalesDrawer> {
  @override
  Widget build(BuildContext context) {
    Future<dynamic> exitDialog() {
      return showDialog(
        context: context,
        builder: (context) =>  AlertDialog(
          title:  const Text('Are you Sure?'),
          content:  const Text('Do You want to exit from the app?'),
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
              child: const Text("Exit"),
            ),
            TextButton(
              onPressed: () {},
              child: const Text("Cancel"),
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
                decoration: const BoxDecoration(
                  borderRadius:  BorderRadius.all(Radius.circular(20)),
                  color:  Color(0xffe14589),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "Hi" ,
                        style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
                leading: const Icon(Icons.apps, color: Colors.white),
                title: Text(
                  "Overview",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SalesDisplay()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.calendar_today_rounded, color: Colors.white),
                title: Text(
                  "Appointments",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetDoctor()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.message, color: Colors.white),
                title: Text(
                  "Message",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Chat()),
                  );
                }),
            ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: Text(
                  "LogOut",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
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


