import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/Appointment/BookAppoinment/BookAppointment_view.dart';
import 'package:shebirth/Client-Dashboard/MessageScreen/Massage/Message.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/DoctorList/DoctorList_model.dart';
import 'package:shebirth/Client-Dashboard/SupportTeam/Doctor/Search.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'Paediatrician_controller.dart';

class Paediatrician extends StatefulWidget {
  @override
  _PaediatricianState createState() => _PaediatricianState();
}

class _PaediatricianState extends State<Paediatrician> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaediatricianController(context),
      child: Consumer<PaediatricianController>(
          builder: (context, controller, child) {
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
                  'Paediatrician',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Arial',
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
                              delegate: DoctorSearch(controller.model!.items!));
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
                        ? (controller.model == null ||
                                controller.model!.items == null ||
                                controller.model!.items!.isEmpty
                            ? Center(
                                child: Text("No doctors avaialable",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: 'Gilroy')),
                              )
                            : Container(
                                child: new ListView.builder(
                                  itemCount: controller.model!.items!.length,
                                  itemBuilder: (_, int index) {
                                    if (controller.model!.items?[index] !=
                                        null) {
                                      return Data(
                                          controller.model!.items![index]);
                                    } else {
                                      return SizedBox.shrink();
                                    }
                                  },
                                ),
                              ))
                        : Center(
                            child:  ErrorRefreshIcon(onPressed: () {
                                controller.fetchAllPaediatricians();
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
  DoctorListItem item;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 270,
        width: 380,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: item.profile_full_url == null
                  ? CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: AssetImage('assets/Client dummy.png'),
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
                  TextButton(
                    child: Text(
                      item.firstname == null || item.lastname == null
                          ? "Name Unavailable"
                          : ("Dr " + item.firstname! + " " + item.lastname!),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    onPressed: () {},
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        item.speciality == null
                            ? "Speciality Unavailable"
                            : (item.speciality!) +
                            " || " +
                            (item.experience == null
                                ? "Experience Unavailable"
                                : (item.experience!.toString() +
                                " years of Experience")),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                    thickness: .01,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        item.qualification == null
                            ? "Qualification Unvailable"
                            : (item.qualification!) +
                            " || " +
                            (item.location == null
                                ? "Location Unavailable"
                                : (item.location!)),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 10,
                    thickness: .01,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "You Pay",
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        item.price == null
                            ? "Not Available"
                            : ("Rs : " + item.price.toString()),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: 200,
                        margin: EdgeInsets.only(bottom: 20),
                        child:  ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffe14589) , // foreground (text) color
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BookAppointment(item)),
                            );
                          },
                          child: Text(
                            "Book Appointment",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontFamily: 'Gilroy'),
                          ),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MessagesScreen(
                                        item.id!,
                                        item.firstname!,
                                        item.profile_full_url.toString())),
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
    );
  }
}
