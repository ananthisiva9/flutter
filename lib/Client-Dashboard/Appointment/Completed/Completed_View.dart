import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/Appointment/Summary.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'Completed_Controller.dart';
import 'Completed_Model.dart';

class Completed extends StatefulWidget {
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => CompletedController(context),
        child: Consumer<CompletedController>(
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
                                    itemBuilder: (_, int index) =>
                                        Data(controller.model!.items![index]),
                                    itemCount: controller.model!.items!.length,
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    "No appointments available",
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                          : Center(
                              child: ErrorRefreshIcon(onPressed: () {
                                controller.fetchAllCompleted();
                              }),
                            ),
                ],
              ),
            ),
          );
        }));
  }
}

class Data extends StatelessWidget {
  CompletedItem item;
  Data(this.item);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 220,
        width: 400,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: item.doctor_profile_pic == null
                  ? CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: AssetImage('assets/Client dummy.png'),
                radius: 35,
              )
                  : CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: NetworkImage(
                  item.doctor_profile_pic.toString(),
                ),
                radius: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    item.doctor == null
                        ? "Not Available"
                        : ("Dr " + item.doctor!),
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.white),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        item.qualification ?? "Not Available",
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
                        item.experience == null
                            ? "Not Available"
                            : (item.experience.toString() +
                                " years of Experience"),
                        style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 50,
                    thickness: .8,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 55,
                            width: 100,
                            color: Color(0xffe14589),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Slot",
                                  style: GoogleFonts.poppins(
                                      color: Colors.white, fontSize: 12),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.date ?? "Not Available",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                    Text(
                                      item.time ?? "Not Available",
                                      style: GoogleFonts.poppins(
                                          color: Colors.white, fontSize: 12),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 100,
                            margin: EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.blue // foreground (text) color
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) =>
                                      Summary(value: item.id.toString()),
                                  backgroundColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20)),
                                  ),
                                );
                              },
                              child: Text(
                                "Summary",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
