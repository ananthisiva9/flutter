import 'dart:ui';
import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:admin_dashboard/Admin/ExternalUser/AllDoctors/AllDoctors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'AllDoctors/AllDoctor_controller.dart';
import 'AllDoctors/Search.dart';
import 'ApprovedDoctors/ApprovedDoctors.dart';
import 'Hospitals/Hospitals.dart';

class ExternalUser extends StatefulWidget {
  @override
  _ExternalUserState createState() => _ExternalUserState();
}

class _ExternalUserState extends State<ExternalUser> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AllDoctorController(context),
      child:
          Consumer<AllDoctorController>(builder: (context, controller, child) {
        return SafeArea(
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/appbar.jpeg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                elevation: 0,
                title: Text(
                  'External User',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: DoctorSearch(controller.model!.items!));
                    },
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
      }),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.92,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DefaultTabController(
                    length: 3,
                    initialIndex: 0,
                    child: Column(
                      children: <Widget>[
                        const TabBar(indicatorColor: Color(0xffe41589), tabs: [
                          Tab(text: 'All Doctors'),
                          Tab(text: 'Doctors Request'),
                          Tab(text: 'Hospitals'),
                        ]),
                        SingleChildScrollView(
                          child: Container(
                            height: 700,
                            child: TabBarView(
                              children: <Widget>[
                                AllDoctor(),
                                ApproveDoctor(),
                                Hospitals()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
