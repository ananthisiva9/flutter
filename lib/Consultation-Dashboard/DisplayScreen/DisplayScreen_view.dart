import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Consultation-Dashboard/AllClient/AllClient_view.dart';
import 'package:shebirth/Consultation-Dashboard/ClientThisMonth/ClientThisMonth_view.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import '../drawer.dart';
import 'DisplayScreen_controller.dart';
import 'DisplayScreen_model.dart';

class ConsultDisplay extends StatefulWidget {
  @override
  _ConsultDisplayState createState() => _ConsultDisplayState();
}

class _ConsultDisplayState extends State<ConsultDisplay> {
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
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Image(
                                    alignment: Alignment.bottomRight,
                                    image: AssetImage('assets/Consultant.png'),
                                  ),
                                ),
                                _buildClient(controller.model),
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
      child: ListView(
        padding: const EdgeInsets.all(5.0),
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
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
                          model!.clients_this_month == null
                              ? "Not Available"
                              : model.clients_this_month.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Total Client This Month",
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
                          builder: (context) => ClientThisMonth()),
                    );
                  }),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10.0)),
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
                        model.clients_this_month == null
                            ? "Not Available"
                            : model.total_clients.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Total Clients All Time",
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
        ],
      ),
    );
  }
}
