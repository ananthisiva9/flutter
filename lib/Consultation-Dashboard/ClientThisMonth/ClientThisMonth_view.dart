import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Consultation-Dashboard/MessageScreen/Massage/Message.dart';
import 'package:shebirth/Consultation-Dashboard/Tracker/DailyTracker.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'ClientThisMonth_controller.dart';
import 'ClientThisMonth_model.dart';
import 'Search.dart';

class ClientThisMonth extends StatefulWidget {
  @override
  _ClientThisMonthState createState() => _ClientThisMonthState();
}

class _ClientThisMonthState extends State<ClientThisMonth> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClientThisMonthController(context),
      child: Consumer<ClientThisMonthController>(
          builder: (context, controller, child) {
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
                'Total Client This Month',
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
                    margin: EdgeInsets.only(right: 15),
                    child: IconButton(
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        showSearch(
                            context: context,
                            delegate: Search(controller.model!.items!));
                      },
                    ),
                  ),
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
              controller.state == StateEnum.loading
                  ? Container(
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Center(child: LoadingIcon()),
                    )
                  : controller.state == StateEnum.success
                      ? (controller.model != null &&
                              controller.model!.items != null &&
                              controller.model!.items!.isNotEmpty)
                          ? Container(
                              child: new ListView.builder(
                                  itemBuilder: (_, int index) => Data(
                                      controller.model!.items![index],
                                      controller),
                                  itemCount: controller.model!.items!.length),
                            )
                          : Center(
                              child: Text(
                                "No Clients Available",
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                      : Center(child: ErrorRefreshIcon(onPressed: () {
                          controller.fetchClientThisMonth()();
                        })),
            ],
          ),
        );
      }),
    );
  }
}

class Data extends StatelessWidget {
  ClientThisMonthItem item;
  ClientThisMonthController controller;
  Data(this.item, this.controller);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 180,
              child: Stack(
                children: <Widget>[

                    CircleAvatar(
                      backgroundImage: AssetImage('assets/Client dummy.png'),
                      radius: 40,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Text(
                            (item.firstName.toString().capitalize()) +
                                " " +
                                (item.lastName.toString().capitalize()),
                            style: GoogleFonts.poppins(
                                fontSize: 18, color: Colors.white),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                item.location.toString().capitalize(),
                                style: GoogleFonts.poppins(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "DueDate: " + (item.dueDate.toString()), //TODO:
                                style: GoogleFonts.poppins(
                                  color: Colors.lightBlueAccent,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            height: 20,
                            thickness: .8,
                            color: Colors.white,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 25,
                                      width: 150,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            primary: Color(0xffe14589) , // foreground (text) color
                                          ),
                                        onPressed: () {
                                          if (item.id != null) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DailyTracker(item.id!)),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content:
                                                  Text('Client id not found'),
                                              backgroundColor: Colors.red,
                                            ));
                                          }
                                        },
                                        child: Text(
                                          "Tracking",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: 25,
                                          width: 150,
                                          margin: EdgeInsets.only(bottom: 20),
                                          color: (item.criticality == null)
                                              ? Colors.transparent
                                              : (item.criticality ==
                                                      "high risk")
                                                  ? Colors.red
                                                  : (item.criticality ==
                                                          "stable")
                                                      ? Colors.green
                                                      : (item.criticality ==
                                                              "low risk")
                                                          ? Colors.yellow
                                                          : Colors.transparent,
                                          child: (item.criticality == null)
                                              ? Text(
                                                  "Criticality Unavialable",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                )
                                              : (item.criticality !=
                                                          "high risk" &&
                                                      item.criticality !=
                                                          "stable" &&
                                                      item.criticality !=
                                                          "low risk")
                                                  ? Text(
                                                      "Criticality Unavailable",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                    )
                                                  : SizedBox.shrink(),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessagesScreen(item.id!,
                                                          item.firstName!,)),
                                            );
                                          },
                                          icon: Icon(Icons.message),
                                          color: Colors.white,
                                          iconSize: 25,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
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
