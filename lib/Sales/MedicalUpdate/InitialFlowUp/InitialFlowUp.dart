import 'dart:ui';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'InitialFlowUp_controller.dart';
import 'Medical Details/MedicalDetails.dart';
import 'Personal Details/PersonalDetails.dart';

class FlowUp extends StatefulWidget {
  int id;
  FlowUp(this.id);
  @override
  _FlowUpState createState() => _FlowUpState();
}

class _FlowUpState extends State<FlowUp> {
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
            title: Text(
              'Initial FlowUp',
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
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _buildContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return ChangeNotifierProvider(
      create: (context) => FlowUpController(context)..initialize(),
      child: Consumer<FlowUpController>(builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: const Radius.circular(10), topLeft: const Radius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.89,
                width: MediaQuery.of(context).size.width * 1.0,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('assets/Background.png').image,
                        fit: BoxFit.cover)),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      DefaultTabController(
                          length: 2,
                          child: Column(
                            children: <Widget>[
                              const TabBar(indicatorColor: Color(0xffe14589), tabs: [
                                 Tab(text: 'Personal Details'),
                                 Tab(text: 'Medical Details')
                              ]),
                              SingleChildScrollView(
                                child: Container(
                                  height: 800,
                                  child:  TabBarView(
                                    children: <Widget>[
                                      PersonalDetails(widget.id),
                                      MedicalDetails(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}