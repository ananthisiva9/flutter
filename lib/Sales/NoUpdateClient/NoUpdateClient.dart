import 'package:admin_dashboard/Sales/Analysis/Analysis.dart';
import 'package:admin_dashboard/Sales/Analysis/MedicalAnalysis.dart';
import 'package:admin_dashboard/Sales/ClientProfile/ClientProfile.dart';
import 'package:admin_dashboard/Sales/Daily%20Tracker/Daily%20Tracker.dart';
import 'package:admin_dashboard/Sales/MessageScreen/Massage/Message.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'NoUpdateClient_controller.dart';
import 'NoUpdateClient_model.dart';
import 'Search.dart';

class NoUpdateClients extends StatefulWidget {
  @override
  _NoUpdateClientsState createState() => _NoUpdateClientsState();
}

class _NoUpdateClientsState extends State<NoUpdateClients> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoUpdateClientsController(context),
      child:
      Consumer<NoUpdateClientsController>(builder: (context, controller, child) {
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
                elevation: 0,
                title: Text(
                  'No Updates from Clients',
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
                              controller.model!.clients!));
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
                    ? (controller.model!.clients == null ||
                    controller.model!.clients!.isEmpty)
                    ? Center(
                  child: Text(
                    'No Patient available',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                )
                    :  ListView.builder(
                  itemBuilder: (_, int index) =>
                      Data(controller.model!.clients![index]),
                  itemCount: controller.model!.clients!.length,
                )
                    : Center(
                  child: ErrorRefreshIcon(onPressed: () {
                    controller.fetchNoUpdateClients();
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

class Data extends StatefulWidget {
  Data(this.client);
  Client client;

  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) , // foreground (text) color
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MedicalAnalysis(widget.client.id!),
                      ));
                },
                child: Text(
                  "Analysis 1",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
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
                        value: widget.client.id!,
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
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.1),
          ),
          height: 200,
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
                children:<Widget> [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MessagesScreen(widget.client.id!, widget.client.firstName!)),
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
                                  ClientProfile(value: widget.client.id!)),
                        );
                      },
                      child: Text(
                        (widget.client.firstName.toString().capitalize()) +
                            " " +
                            (widget.client.lastName.toString().capitalize()),
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
                              (widget.client.location.toString().capitalize()),
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
                              (widget.client.week == null
                                  ? "Not available"
                                  : widget.client.week.toString()),
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
                          "Due date : " + (widget.client.dueDate.toString()),
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
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 125,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xffe14589) , // foreground (text) color
                                  ),
                                  onPressed: () {
                                    if (widget.client.id != null) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateTracker(widget.client.id!)),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Client id not found'),
                                        backgroundColor: Colors.red,
                                      ));
                                    }

                                  },
                                  child: Text(
                                    "Update Tracker",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
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
                                        color: (widget.client.criticality ==
                                            null)
                                            ? Colors.transparent
                                            : (widget.client.criticality ==
                                            "high risk")
                                            ? Colors.red
                                            : (widget.client.criticality ==
                                            "stable")
                                            ? Colors.green
                                            : (widget.client
                                            .criticality ==
                                            "low risk")
                                            ? Colors.yellow
                                            : Colors.transparent,
                                        child: (widget.client.criticality ==
                                            null)
                                            ? Text(
                                          "Criticality Unavailable",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        )
                                            : (widget.client.criticality !=
                                            "high risk" &&
                                            widget.client.criticality !=
                                                "stable" &&
                                            widget.client.criticality !=
                                                "low risk")
                                            ? Text(
                                          "Criticality Unavailable",
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