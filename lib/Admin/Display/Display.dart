import 'package:admin_dashboard/Admin/AddNewUser/AddNewUser.dart';
import 'package:admin_dashboard/Admin/AppBar/Consultant/Consultant_view.dart';
import 'package:admin_dashboard/Admin/AppBar/Hospitals/Hospitals.dart';
import 'package:admin_dashboard/Admin/AppBar/Sales/Sales_view.dart';
import 'package:admin_dashboard/Admin/Drawer.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../AppBar/AllCLients/Allclients.dart';
import '../AppBar/AllDoctors/AllDoctors.dart';
import 'Display_controller.dart';
import 'Display_model.dart';

class AdminDisplay extends StatefulWidget {
  @override
  _AdminDisplayState createState() => _AdminDisplayState();
}

class _AdminDisplayState extends State<AdminDisplay> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DisplayController(context),
        child:
            Consumer<DisplayController>(builder: (context, controller, child) {
          return Scaffold(
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
                    'Sukh Prasavam',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              drawer: AdminDrawer(),
              body: Stack(children: <Widget>[
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
                        child: const Center(child: LoadingIcon()),
                      )
                    : controller.state == StateEnum.success
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120,
                                  decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/appbar.jpeg'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: controller.userDataState ==
                                          StateEnum.loading
                                      ? const Center(child: LoadingIcon())
                                      : controller.userDataState ==
                                              StateEnum.success
                                          ? Container(
                                              margin: const EdgeInsets.only(
                                                  left: 30, bottom: 30),
                                              child: Row(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 30),
                                                        child: Text(
                                                          (controller.userDataModel!
                                                                      .firstname ==
                                                                  null)
                                                              ? "Name unavailable"
                                                              : controller
                                                                  .userDataModel!
                                                                  .firstname!,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                      ),
                                                      (controller.userDataModel!
                                                                  .email ==
                                                              null)
                                                          ? const SizedBox
                                                              .shrink()
                                                          : Container(
                                                              margin:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10),
                                                              child: Text(
                                                                controller
                                                                    .userDataModel!
                                                                    .email!,
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 100.0, top: 20),
                                                    child: Image(
                                                      image: AssetImage(
                                                          'assets/Consultant.png'),
                                                      height: 150,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Center(
                                              child: ErrorRefreshIcon(
                                                  onPressed: () {
                                                controller.fetchLoginDetails();
                                              }),
                                            ),
                                ),
                                _buildTotal1(controller.model),
                                _buildTotal2(controller.model),
                                _buildTotal3(controller.model),
                                _buildTotal4(controller.model),
                              ],
                            ),
                          )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchDisplayActivity();
                            }),
                          ),
              ]));
        }));
  }
  Widget _buildTotal1(AllClientsModel? model) {
    return Container(
        height: 150,
        width: 500,
        child:
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10.0)),
                      height: 140,
                      width: 140,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                          Text(
                            model!.counts!.totalClients == null
                                ? "Not Available"
                                : model.counts!.totalClients.toString(),
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            "Total Clients",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
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
                        MaterialPageRoute(builder: (context) => Client()),
                      );
                    }),
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    alignment: Alignment.center,
                    height: 140,
                    width: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          model.counts!.totalDoctors == null
                              ? "Not Available"
                              : model.counts!.totalDoctors.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Total Doctors",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
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
                      MaterialPageRoute(builder: (context) => Doctor()),
                    );
                  },
                ),
              ],
            )
    );
  }
  Widget _buildTotal2(AllClientsModel? model) {
    return Container(
      height: 150,
      width: 500,
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10.0)),
                  alignment: Alignment.center,
                  height: 140,
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        model!.counts!.totalHospitals == null
                            ? "Not Available"
                            : model.counts!.totalHospitals.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Total Hospitals",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
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
                    MaterialPageRoute(builder: (context) => AllHospital()),
                  );
                },
              ),
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 140,
                    width: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          model.counts!.totalSalesTeam == null
                              ? "Not Available"
                              : model.counts!.totalSalesTeam.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Total Sales Team",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
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
                      MaterialPageRoute(builder: (context) => AllSales()),
                    );
                  }),
            ],
          )
    );
  }
  Widget _buildTotal3(AllClientsModel? model) {
    return Container(
      height: 150,
      width: 500,
      child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10.0)),
                  alignment: Alignment.center,
                  height: 140,
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        model!.counts!.totalConsultant == null
                            ? "Not Available"
                            : model.counts!.totalConsultant.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Total Consultant",
                        style: GoogleFonts.poppins(
                          fontSize: 15,
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
                    MaterialPageRoute(builder: (context) => AllConsultant()),
                  );
                },
              ),
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 140,
                    width: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          model.counts!.activeClients == null
                              ? "Not Available"
                              : model.counts!.activeClients.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Active Clients",
                          style: GoogleFonts.poppins(
                            fontSize: 15,
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
                      MaterialPageRoute(builder: (context) => Client()),
                    );
                  }),
            ],
          )
    );
  }
  Widget _buildTotal4(AllClientsModel? model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 35,
          width: 125,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewUser()),
              );
            },
            child: Text(
              "Add New Users",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
