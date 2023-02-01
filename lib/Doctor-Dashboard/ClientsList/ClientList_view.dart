import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/Analysis/Analysis.dart';
import 'package:shebirth/Doctor-Dashboard/Analysis/MedicalAnalysis.dart';
import 'package:shebirth/Doctor-Dashboard/CallRecords/CallRecords_view.dart';
import 'package:shebirth/Doctor-Dashboard/ClientProfile/ClientProfile.dart';
import 'package:shebirth/Doctor-Dashboard/ClientsList/ClientList_controller.dart';
import 'package:shebirth/Doctor-Dashboard/MessageScreen/Massage/Message.dart';
import 'package:shebirth/Doctor-Dashboard/Tracker/DailyTracker.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'ClientList_model.dart';
import 'Search.dart';

class ClientList extends StatefulWidget {
  @override
  _ClientListState createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClientListController(context),
      child:
          Consumer<ClientListController>(builder: (context, controller, child) {
        return SafeArea(
          child: Scaffold(
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
                  'Patient List',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: DataSearch(controller.model!.customers!));
                    },
                  ),
                  IconButton(
                    onPressed: () => controller.sortByWeek(),
                    icon: Icon(Icons.sort),
                    color: Colors.white,
                  )
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
                    ? Center(child: LoadingIcon())
                    : controller.state == StateEnum.success
                        ? (controller.model!.customers == null ||
                                controller.model!.customers!.isEmpty)
                            ? Center(
                                child: Text(
                                  'No Patient available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : (controller.sortedClients == null ||
                                    controller.sortedClients!.isEmpty)
                                ? Center(
                                    child: Text(
                                      'No Patient available',
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                : new ListView.builder(
                                    itemBuilder: (_, int index) =>
                                        Data(controller.sortedClients![index]),
                                    itemCount: controller.sortedClients!.length,
                                  )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchAllClients();
                            }),
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Data extends StatelessWidget {
  Data(this.client);
  Customers client;
  @override
  Widget build(BuildContext context) {
    Future<dynamic> Analysis1Dialog() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          backgroundColor: Colors.cyan,
          title: Text(
            "Criticality Analysis",
            style: GoogleFonts.poppins(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicalAnalysis(client.id!),
                      ));
                },
                child: Text(
                  "Analysis 1",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) ,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Analysis(
                          value: client.id!,
                        ),
                      ));
                },
                child: Text(
                  "Analysis 2",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          height: 270,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: client.profile_pic == null
                    ? CircleAvatar(
                        backgroundColor: Colors.cyan[100],
                        backgroundImage: AssetImage('assets/Client dummy.png'),
                        radius: 35,
                      )
                    : CircleAvatar(
                        backgroundColor: Colors.cyan[100],
                        backgroundImage: NetworkImage(
                          client.profile_pic.toString(),
                        ),
                        radius: 35,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MessagesScreen(client.id!,
                                  client.firstname!, client.profile_pic!)),
                        );
                      },
                      icon: Icon(Icons.message),
                      color: Colors.white,
                      iconSize: 25,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ClientProfile(value: client.id.toString())),
                        );
                      },
                      child: Text(
                        (client.firstname.toString().capitalize()) +
                            " " +
                            (client.lastname.toString().capitalize()),
                        style: GoogleFonts.poppins(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "Location : " +
                              (client.location.toString().capitalize()),
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
                          "Current Week : " +
                              (client.currentWeek == null
                                  ? "Not available"
                                  : client.currentWeek.toString()),
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
                          "Due date : " + (client.dueDate ?? "Not available"),
                          style: GoogleFonts.poppins(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: .8,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 125,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffe14589) ,
                                  ),
                                  onPressed: () {
                                    if (client.id != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DailyTracker(client.id!)),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        content: Text('Client id not found'),
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
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 35,
                                      width: 125,
                                      color: (client.criticality == null)
                                          ? Colors.transparent
                                          : (client.criticality == "high risk")
                                              ? Colors.red
                                              : (client.criticality == "stable")
                                                  ? Colors.green
                                                  : (client.criticality ==
                                                          "low risk")
                                                      ? Colors.yellow
                                                      : Colors.transparent,
                                      child: (client.criticality == null)
                                          ? Text(
                                              "Criticality Unavialable",
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 15,
                                              ),
                                            )
                                          : (client.criticality !=
                                                      "high risk" &&
                                                  client.criticality !=
                                                      "stable" &&
                                                  client.criticality !=
                                                      "low risk")
                                              ? Text(
                                                  "Criticality Unavialable",
                                                  style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                )
                                              : SizedBox.shrink(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 35,
                                width: 125,
                                child:  ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CallRecords(value: client.id!)),
                                    );
                                  },
                                  child: Text(
                                    "Call Records",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      height: 35,
                                      width: 125,
                                      child:  ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Colors.blue ,
                                        ),
                                        onPressed: () {
                                          Analysis1Dialog();
                                        },
                                        child: Text(
                                          "Analysis",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
