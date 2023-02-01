import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/Approval%20Request/ApprovalRequest_view.dart';
import 'package:shebirth/Doctor-Dashboard/ClientThisMonth/ClientThisMonth_view.dart';
import 'package:shebirth/Doctor-Dashboard/ClientsList/ClientList_view.dart';
import 'package:shebirth/Doctor-Dashboard/TodaysAppointment/TodaysAppointment_view.dart';
import 'package:shebirth/Doctor-Dashboard/drawer.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../Chart.dart';
import 'DisplayScreen_controller.dart';
import 'DisplayScreen_model.dart';

class Display extends StatefulWidget {
  @override
  _DisplayState createState() => _DisplayState();
}

class _DisplayState extends State<Display> {
  @override
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(BuildContext context) async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (_datepicker != null && _datepicker != _date) {
      setState(() {
        _date = _datepicker;
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: TextButton(
              onPressed: () {
                setState(() {
                  _selectDate(context);
                });
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              )),
        ),
        Text(
          _date.day.toString(),
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        Text(
          _date.month.toString(),
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        Text(
          _date.year.toString(),
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        TextButton(
            onPressed: () {
              setState(() {
                _selectDate(context);
              });
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 25,
            )),
      ],
    );
  }

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
              drawer: NavigationDrawer(),
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
                        child: Center(child: LoadingIcon()),
                      )
                    : controller.state == StateEnum.success
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/appbar.jpeg'),
                                        fit: BoxFit.fill,
                                      ),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30))),
                                  child: controller.userDataState ==
                                          StateEnum.loading
                                      ? Center(child: LoadingIcon())
                                      : controller.userDataState ==
                                              StateEnum.success
                                          ? Container(
                                              margin: EdgeInsets.only(
                                                  left: 30, bottom: 30),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Container(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(10.0),
                                                        child: controller.model!
                                                                    .profile_pic ==
                                                                null
                                                            ? CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.cyan[
                                                                        100],
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        'assets/Client dummy.png'),
                                                                radius: 30,
                                                              )
                                                            : CircleAvatar(
                                                                backgroundColor:
                                                                    Colors.cyan[
                                                                        100],
                                                                backgroundImage:
                                                                    NetworkImage(
                                                                  controller
                                                                      .model!
                                                                      .profile_pic
                                                                      .toString(),
                                                                ),
                                                                radius: 30,
                                                              ),
                                                      ),
                                                    ),
                                                  ),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            top: 30),
                                                        child: Text(
                                                          (controller.userDataModel!
                                                                      .firstname ==
                                                                  null)
                                                              ? "Name unavailable"
                                                              : 'Dr. ' +
                                                                  controller
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
                                                          ? SizedBox.shrink()
                                                          : Container(
                                                              margin: EdgeInsets
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
                                _buildClient(controller.model),
                                _buildDate(),
                                Center(
                                    child: Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text("Latest Consultations",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              color: Colors.white,
                                            )))),
                                _buildAppointment(
                                    controller.model!.latestConsultation),
                                _buildGraph(controller.model!.graphData),
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

  Widget _buildClient(DisplayModel? model) {
    return Container(
      height: 250,
      width: 500,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              alignment: Alignment.center,
              height: 160,
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    model!.approvalRequests == null
                        ? "Not Available"
                        : model.approvalRequests.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Request Waiting To Approve",
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
                  MaterialPageRoute(
                    builder: (context) => ApprovalRequest(),
                  ));
            },
          ),
          InkWell(
            child: Container(
              padding: const EdgeInsets.all(5.0),
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )),
              height: 160,
              width: 160,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                  Text(
                    model.totalClients == null
                        ? "Not Available"
                        : model.totalClients.toString(),
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Total Patient all Time",
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
                MaterialPageRoute(builder: (context) => ClientList()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGraph(List<GraphData>? model) {
    return Container(
      alignment: Alignment.center,
      height: 800,
      child: (model == null || model.isEmpty)
          ? Center(
              child: Text(
                "No appointments available",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: BarChartSample2(
                    model: model,
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildAppointment(List<LatestConsultation>? itemList) {
    return Center(
      child: Container(
          height: 300,
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.1),
            ),
            width: 400,
            child: (itemList == null || itemList.isEmpty)
                ? Center(
                    child: Text(
                      "No appointments available",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white.withOpacity(0.1),
                        ),
                        width: 275,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              'Consultation',
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 15),
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  (itemList[index]
                                                                  .firstname
                                                                  .toString()
                                                                  .capitalize() ==
                                                              null ||
                                                          itemList[index]
                                                                  .lastname
                                                                  .toString()
                                                                  .capitalize() ==
                                                              null)
                                                      ? "Name not available"
                                                      : (itemList[index]
                                                              .firstname
                                                              .toString()
                                                              .capitalize() +
                                                          " " +
                                                          itemList[index]
                                                              .lastname
                                                              .toString()
                                                              .capitalize()),
                                                  style: GoogleFonts.poppins(
                                                      color: Colors.white,
                                                      fontSize: 15),
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      itemList[index].time ??
                                                          "Time not avaialable",
                                                      style:
                                                          GoogleFonts.poppins(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Divider(
                                              height: 20,
                                              thickness: .8,
                                              color: Colors.white,
                                            ),
                                          ],
                                        );
                                      },
                                      itemCount: itemList.length,
                                      shrinkWrap: true,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xffe14589) ,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TodaysAppointment()),
                                        );
                                      },
                                      child: Container(
                                        constraints: BoxConstraints(
                                          maxHeight: 25,
                                          maxWidth: 60,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "More",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          )),
    );
  }
}
