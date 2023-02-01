import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import '../../../../../utility/state_enum.dart';
import '../Symptoms_controller.dart';
import 'Abdomen.dart';
import 'Chest.dart';
import 'Head.dart';
import 'Legs.dart';
import 'MentalHealth.dart';
import 'Others.dart';
import 'Pelvic.dart';

class Predefined extends StatelessWidget {
  Predefined(this.controller);

  SymptomController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.state == StateEnum.loading) {
      return Align(alignment: Alignment.topCenter, child: LoadingIcon());
    } else if (controller.state == StateEnum.success) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10), topLeft: Radius.circular(10)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
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
                        length: 7,

                        child: Column(
                          children: <Widget>[
                            TabBar(
                                indicatorColor: Color(0xffe14589),
                                labelStyle: GoogleFonts.poppins(
                                    fontSize: 12, color: Colors.white),
                                isScrollable: true,
                                tabs: [
                                  Tab(
                                    text: 'Head',
                                  ),
                                  Tab(text: 'Chest'),
                                  Tab(text: 'Abdomen'),
                                  Tab(text: 'Pelvic'),
                                  Tab(text: 'Legs'),
                                  Tab(text: 'Mental Health'),
                                  Tab(text: 'Other')
                                ]),
                            SingleChildScrollView(
                              child: Container(
                                height: 500,
                                child: TabBarView(
                                  children: <Widget>[
                                    Head(controller),
                                    Chest(controller),
                                    Abdomen(controller),
                                    Pelvis(controller),
                                    Legs(controller),
                                    MentalHealth(controller),
                                    Other(controller),
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
    } else {
      return ErrorRefreshIcon(onPressed: () {
        controller.fetchAllSymptom();
      });
    }
  }
}