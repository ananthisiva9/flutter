import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'LastWeekReport_controller.dart';
import 'LastWeekReport_model.dart';

class LastWeekReport extends StatefulWidget {
  @override
  _LastWeekReportState createState() => _LastWeekReportState();
}

class _LastWeekReportState extends State<LastWeekReport> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LastWeekReportController(context),
      child: Consumer<LastWeekReportController>(
          builder: (context, controller, child) {
            return SafeArea(
              child: Scaffold(
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
                        ? (controller.model!.lastWeekSymptomReport == null ||
                        controller
                            .model!.lastWeekSymptomReport!.isEmpty)
                        ? Center(
                      child: Text(
                        'No Report available',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    )
                        : Container(
                      child: new ListView.builder(
                        itemBuilder: (_, int index) => Data(controller
                            .model!.lastWeekSymptomReport![index]),
                        itemCount: controller
                            .model!.lastWeekSymptomReport!.length,
                      ),
                    )
                        : Center(
                      child: ErrorRefreshIcon(onPressed: () {
                        controller.fetchAllLastWeekReport();
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
  Data(this.report);
  LastWeekSymptomReport report;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 100,
        width: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Last Week You Have Experienced : ",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      report.count.toString(),
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 15, color: Colors.lightBlueAccent)),
                    ),
                    Text(" Time ",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.lightBlueAccent,
                          ),
                        )),
                    Text(
                      report.symptom.toString().capitalize(),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 15,
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
