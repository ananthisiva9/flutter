import 'package:admin_dashboard/Sales/Daily%20Tracker/Diet/Diet_view.dart';
import 'package:admin_dashboard/Sales/Daily%20Tracker/Exercise/Exercise_view.dart';
import 'package:admin_dashboard/Sales/Daily%20Tracker/Medicine/Medicine_view.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Activity/mainActivity.dart';
import 'Medical/Medical_view.dart';
import 'Symptoms/Symptoms.dart';

class UpdateTracker extends StatefulWidget {
  UpdateTracker(this.clientId);
  int clientId;
  @override
  _UpdateTrackerState createState() => _UpdateTrackerState();
}

class _UpdateTrackerState extends State<UpdateTracker> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image:  DecorationImage(
                image:  AssetImage('assets/appbar.jpeg'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          elevation: 0,
          title: Text(
            'Sukh Prasavam',
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
                  margin: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SalesDisplay(),
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
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/Background.png').image,
                        fit: BoxFit.cover),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: GridView.count(
                  mainAxisSpacing: 50,
                  crossAxisSpacing: 50,
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
                              const Image(
                                image:  AssetImage('assets/Diet.png'),
                                height: 60,
                              ),
                              const Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => diet(widget.clientId)),
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
                          MaterialPageRoute(builder: (context) => diet(widget.clientId)),
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
                              const Image(
                                image: AssetImage('assets/med.png'),
                                height: 60,
                              ),
                              const Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Medicine(widget.clientId)),
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
                          MaterialPageRoute(builder: (context) => Medicine(widget.clientId)),
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
                              const Image(
                                image:  AssetImage('assets/execise.png'),
                                height: 60,
                              ),
                              const Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Exercise(widget.clientId)),
                                  );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Exercise(widget.clientId)),
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
                              const Image(
                                image:  AssetImage('assets/activity.png'),
                                height: 60,
                              ),
                              const Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Activity(widget.clientId)),
                                  );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Activity(widget.clientId)),
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
                              const Image(
                                image:  AssetImage('assets/symp.png'),
                                height: 60,
                              ),
                              const Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Symptoms(widget.clientId)),
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
                          MaterialPageRoute(builder: (context) => Symptoms(widget.clientId)),
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
                              const Image(
                                image: AssetImage('assets/medicalRecord.png'),
                                height: 60,
                              ),
                              const Divider(
                                height: 25,
                                thickness: .01,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Medical(widget.clientId)),
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
                          MaterialPageRoute(builder: (context) => Medical(widget.clientId)),
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
