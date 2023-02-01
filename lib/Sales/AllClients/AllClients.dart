import 'package:admin_dashboard/Sales/Analysis/Analysis.dart';
import 'package:admin_dashboard/Sales/Analysis/MedicalAnalysis.dart';
import 'package:admin_dashboard/Sales/ClientProfile/EditClientProfile.dart';
import 'package:admin_dashboard/Sales/Daily%20Tracker/Daily%20Tracker.dart';
import 'package:admin_dashboard/Sales/MedicalUpdate/InvestigationReport/InvestigationReport.dart';
import 'package:admin_dashboard/Sales/MedicalUpdate/Medical/Medical_view.dart';
import 'package:admin_dashboard/Sales/MessageScreen/Massage/Message.dart';
import 'package:admin_dashboard/Sales/OtherSymptoms/OtherSymptoms.dart';
import 'package:admin_dashboard/Sales/Tracker/DailyTracker.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'AllClients_controller.dart';
import 'AllClients_model.dart';
import 'Search.dart';

class AllClient extends StatefulWidget {
  @override
  _AllClientState createState() => _AllClientState();
}

class _AllClientState extends State<AllClient> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AllClientController(context),
      child:
          Consumer<AllClientController>(builder: (context, controller, child) {
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
                  'Clients All Time',
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
                          delegate: DataSearch(
                              controller.model!.totalPatientsDetails!));
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
                controller.state == StateEnum.loading
                    ? const Center(child: LoadingIcon())
                    : controller.state == StateEnum.success
                        ? (controller.clients == null ||
                                controller.clients!.isEmpty)
                            ? Center(
                                child: Text(
                                  'No Patient available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (_, int index) =>
                                    Data(controller.clients![index]),
                                itemCount: controller.clients!.length,
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
  Data(this.client, {Key? key}) : super(key: key);
  TotalPatientsDetails client;
  @override
  Widget build(BuildContext context) {
    Future<dynamic> Analysis1Dialog() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.cyan,
          title: Text(
            "Criticality Analysis",
            style: GoogleFonts.poppins(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffe14589) , // foreground (text) color
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
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) , // foreground (text) color
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
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Future<dynamic> Tracking() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.cyan,
          title: Text(
            "Daily Tracker Details",
            style: GoogleFonts.poppins(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 65,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe14589) , // foreground (text) color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DailyTracker(client.id!)),
                      );
                    },
                    child: Text(
                      "Tracker Details",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                height: 65,
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffe14589) , // foreground (text) color
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateTracker(client.id!)),
                    );
                  },
                  child: Text(
                    "Update Tracker",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Future<dynamic> Medical() {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.cyan,
          title: Text(
            "Medical Update",
            style: GoogleFonts.poppins(fontSize: 15),
            textAlign: TextAlign.center,
          ),
          content: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 65,
                  width: 120,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xffe14589) , // foreground (text) color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MedicalDetail(client.id!)),
                      );
                    },
                    child: Text(
                      "Medical Details",
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              Container(
                height: 65,
                width: 120,
                child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffe14589) , // foreground (text) color
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Report(client.id!)),
                    );
                  },
                  child: Text(
                    "Investigation Report",
                    style:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
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
        height: 260,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: const AssetImage('assets/Client dummy.png'),
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
                            builder: (context) =>
                                MessagesScreen(client.id!, client.firstName!)),
                      );
                    },
                    icon: const Icon(Icons.message),
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
                                EditClientProfile(value: client.id!)),
                      );
                    },
                    child: Text(
                      (client.firstName.toString().capitalize()) +
                          " " +
                          (client.lastName.toString().capitalize()),
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
                            (client.week == null
                                ? "Not available"
                                : client.week.toString()),
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
                  const Divider(
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
                              width: 150,
                              child:ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  Tracking();
                                },
                                child: Text(
                                  "Tracking",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
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
                                  InkWell(
                                    child: Container(
                                      height: 35,
                                      width: 150,
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
                                              : const SizedBox.shrink(),
                                    ),
                                    onTap: () {
                                      Analysis1Dialog();
                                    },
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
                              width: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue,
                                ),
                                onPressed: () {
                                  Medical();
                                },
                                child: Text(
                                  "Medical Update",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
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
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.blue , // foreground (text) color
                                      ),
                                      onPressed: ()  {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => OtherSymptoms(client.id!)),
                                        );
                                      },
                                     //   const url =
                                       //     'https://sukhprasavam.com/inital/88';
                                       // if (await canLaunch(url)) {
                                         // await launch(
                                         //   url,
                                           // forceWebView: true,
                                          //  enableJavaScript: true,
                                         // );
                                       // }
                                      //},
                                      child: Text(
                                        "Initial FlowUp",
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
      ),
    );
  }
}
