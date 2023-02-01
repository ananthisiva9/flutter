import 'package:admin_dashboard/Admin/Appointment/Completed/Completed.dart';
import 'package:admin_dashboard/Admin/Appointment/Upcoming/UpComing.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Doctor_controller.dart';
import 'Doctor_model.dart';

class GetDoctor extends StatefulWidget {
  @override
  _GetDoctorState createState() => _GetDoctorState();
}

class _GetDoctorState extends State<GetDoctor> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GetDoctorController(context),
      child:
          Consumer<GetDoctorController>(builder: (context, controller, child) {
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
                title: const Text(
                  'Doctor List',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.start,
                ),
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
                        child: const Center(child: LoadingIcon()),
                      )
                    : controller.state == StateEnum.success
                        ? (controller.model == null ||
                                controller.model!.doctors == null ||
                                controller.model!.doctors!.isEmpty
                            ? const Center(
                                child: Text("No doctors available",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Gilroy')),
                              )
                            : Container(
                                child: ListView.builder(
                                  itemCount: controller.model!.doctors!.length,
                                  itemBuilder: (_, int index) {
                                    if (controller.model!.doctors?[index] !=
                                        null) {
                                      return Data(
                                          controller.model!.doctors![index]);
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
                              ))
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchGetDoctor();
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
  Data(this.item);
  Doctors item;
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
        width: 380,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: item.profile_full_url == null
                  ? CircleAvatar(
                      backgroundColor: Colors.cyan[100],
                      backgroundImage:
                          const AssetImage('assets/Client dummy.png'),
                      radius: 35,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.cyan[100],
                      backgroundImage: NetworkImage(
                        item.profile_full_url.toString(),
                      ),
                      radius: 35,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    item.firstname == null || item.lastname == null
                        ? "Name Unavailable"
                        : ("Dr " + item.firstname! + " " + item.lastname!),
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Age : " + item.age.toString(),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                    thickness: .01,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Referral Id : " + item.referalId.toString(),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.white,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 30,
                            width: 150,
                            margin: const EdgeInsets.only(bottom: 20),
                            child:ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffe14589) , // foreground (text) color
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpComing(item.id!),
                                    ));
                              },
                              child: const Text(
                                "UpComing",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                          ),
                          Container(
                            height: 30,
                            width: 150,
                            margin: const EdgeInsets.only(bottom: 20),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xffe14589) , // foreground (text) color
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Completed(item.id!),
                                    ));
                              },
                              child: const Text(
                                "Completed",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Gilroy'),
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
