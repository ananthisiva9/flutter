import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Contraction/Contraction.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Medical/Medical_view.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Medicine/Medicine_controller.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Medicine/Medicine_view.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Symptoms/Symptoms.dart';
import 'package:shebirth/Packages/FullPackage.dart';
import '../Client-Dashboard/Daily Tracker/Tracker/Diet/Diet/Diet_view.dart';
import 'Package-Display.dart';

class Tracker extends StatefulWidget {
  @override
  _TrackerState createState() => _TrackerState();
}

class _TrackerState extends State<Tracker> {
  Future<dynamic> ExerciseDialog() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text(
          "For Track Your Calories Please Subscribe our Full Package",
          style: GoogleFonts.poppins(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        content: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullPackage(),
                ));
          },
          child: Text(
            "Subscribe Now",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Future<dynamic> ActivityDialog() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: Text(
          "For Tracker Your Activity Please Subscribe our Package",
          style: GoogleFonts.poppins(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        content: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FullPackage(),
                ));
          },
          child: Text(
            "Subscribe Now",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hi , SuperMom',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDiet() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 180,
          width: 200,
          color: Colors.black.withOpacity(0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/Diet.png'),
                height: 100,
              ),
              Divider(
                height: 25,
                thickness: .01,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589), // foreground (text) color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => diet()),
                  );
                },
                child: Text(
                  "Diet",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMedicine() {
    return ChangeNotifierProvider(
      create: (context) => MedicationController(context)..initialize(),
      child:
          Consumer<MedicationController>(builder: (context, controller, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              height: 180,
              width: 200,
              color: Colors.black.withOpacity(0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image(
                    image: AssetImage('assets/med.png'),
                    height: 100,
                  ),
                  Divider(
                    height: 25,
                    thickness: .01,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe14589), // foreground (text) color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Medicine(),
                        ),
                      );
                    },
                    child: Text(
                      "Medicine",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildActivity() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          height: 180,
          width: 200,
          color: Colors.black.withOpacity(0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(FontAwesomeIcons.crown, color: Colors.white, size: 15),
              Image(
                image: AssetImage('assets/activity.png'),
                height: 100,
              ),
              Divider(
                height: 25,
                thickness: .01,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589), // foreground (text) color
                ),
                onPressed: () {
                  ActivityDialog();
                },
                child: Text(
                  "Activity",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildExercise() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.black.withOpacity(0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(FontAwesomeIcons.crown, color: Colors.white, size: 15),
          Image(
            image: AssetImage('assets/execise.png'),
            height: 100,
          ),
          Divider(
            height: 25,
            thickness: .01,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589), // foreground (text) color
            ),
            onPressed: () {
              ExerciseDialog();
            },
            child: Text(
              "Exercise",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContraction() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.black.withOpacity(0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/contractions.png'),
            height: 100,
          ),
          Divider(
            height: 25,
            thickness: .01,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589), // foreground (text) color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Contraction()),
              );
            },
            child: Text(
              "Contraction",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSymptoms() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.black.withOpacity(0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/symp.png'),
            height: 100,
          ),
          Divider(
            height: 25,
            thickness: .01,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589), // foreground (text) color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Symptoms()),
              );
            },
            child: Text(
              "Symptoms",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedical() {
    return Container(
      height: 200,
      width: 200,
      color: Colors.black.withOpacity(0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/medicalRecord.png'),
            height: 100,
          ),
          Divider(
            height: 25,
            thickness: .01,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589), // foreground (text) color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Medical()),
              );
            },
            child: Text(
              "Medical Record",
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
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
          title: Text(
            'Sukh Prasavam',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.start,
          ),
          elevation: 0,
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
                          builder: (context) => PackageDisplay(),
                        ),
                      );
                    },
                  )),
            ),
          ],
        ),
      ),
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
            _buildName(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Image(
                alignment: Alignment.topRight,
                image: AssetImage('assets/Motherhood-bro.png'),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/Background.png').image,
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: GridView.count(
                  mainAxisSpacing: 100,
                  crossAxisSpacing: 100,
                  crossAxisCount: 2,
                  primary: false,
                  children: <Widget>[
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/Diet.png'),
                                height: 60,
                              ),
                              Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(
                                      0xffe14589), // foreground (text) color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => diet()),
                                  );
                                },
                                child: Text(
                                  "Diet",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => diet()),
                        );
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/med.png'),
                                height: 60,
                              ),
                              Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Medicine()),
                                  );
                                },
                                child: Text(
                                  "Medicine",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Medicine()),
                        );
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/execise.png'),
                                height: 60,
                              ),
                              Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  ExerciseDialog();
                                },
                                child: Text(
                                  "Exercise",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        ExerciseDialog();
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/activity.png'),
                                height: 60,
                              ),
                              Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  ActivityDialog();
                                },
                                child: Text(
                                  "Activity",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        ActivityDialog();
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/contractions.png'),
                                height: 60,
                              ),
                              Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Contraction()),
                                  );
                                },
                                child: Text(
                                  "Contraction",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Contraction()),
                        );
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/symp.png'),
                                height: 60,
                              ),
                              Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Symptoms()),
                                  );
                                },
                                child: Text(
                                  "Symptoms",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Symptoms()),
                        );
                      },
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 175,
                          width: 175,
                          color: Colors.white.withOpacity(0.05),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Image(
                                image: AssetImage('assets/medicalRecord.png'),
                                height: 60,
                              ),
                              Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Medical()),
                                  );
                                },
                                child: Text(
                                  "Medical Record",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Medical()),
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
