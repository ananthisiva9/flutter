import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shebirth/Client-Dashboard/Drawer.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/Dietician/Dietician_view.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/Obstreticion/Obstreticion_view.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/Paediatrician/Paediatrician_view.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/Phychiatrist/Phychiatrist_view.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/Phycologist/Phycologist_view.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: Image.asset('assets/Background.png').image,
              fit: BoxFit.cover),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                child: GridView.count(
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  crossAxisCount: 2,
                  primary: false,
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.black.withOpacity(0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/heart.png'),
                              height: 100,
                            ),
                            Text(
                              "Obstetrician",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Obstreticion()),
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.black.withOpacity(0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/no-fat.png'),
                              height: 100,
                            ),
                            Text(
                              "Dietitian",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dietician()),
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.black.withOpacity(0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/pregnant.png'),
                              height: 100,
                            ),
                            Text(
                              "Psychologist",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Phycologist()),
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.black.withOpacity(0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/baby.png'),
                              height: 100,
                            ),
                            Text(
                              "Paediatrician",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Paediatrician()),
                        );
                      },
                    ),
                    InkWell(
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.black.withOpacity(0.05),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('assets/Path 1295.png'),
                              height: 100,
                            ),
                            Text(
                              "Psychiatrist",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Phychiatrist()),
                        );
                      },
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
