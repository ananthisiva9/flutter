import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:http/http.dart' as http;
import 'Hospitals_controller.dart';
import 'Hospitals_model.dart';

class AllHospital extends StatefulWidget {
  @override
  _AllHospitalState createState() => _AllHospitalState();
}

class _AllHospitalState extends State<AllHospital> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HospitalsController(context),
      child:
      Consumer<HospitalsController>(builder: (context, controller, child) {
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
                  'Total Hospitals',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                  height: 1000,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: const Center(child: LoadingIcon()),
                )
                    : controller.state == StateEnum.success
                    ? (controller.model != null &&
                    controller.model!.items != null &&
                    controller.model!.items!.isNotEmpty)
                    ? Container(
                  child:  ListView.builder(
                    itemBuilder: (_, int index) =>
                        Data(controller.model!.items![index]),
                    itemCount: controller.model!.items!.length,
                  ),
                )
                    : const Center(
                  child:  Text(
                    "No Doctors Available",
                    style:  TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontFamily: 'Arial',
                    ),
                  ),
                )
                    : Center(
                  child: ErrorRefreshIcon(onPressed: () {
                    controller.fetchAllSales();
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
  Data(this.hospital);
  Hospital hospital;
  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  String dropdownValue = 'Enable';
  postData() async {
    String appointmentId = widget.hospital.id.toString();
    String url = Admin.account_status;
    Map body = {
      "id": appointmentId.toString(),
    };
    String? token = await getToken();
    if (token != null) {
      var res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Token $token"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Updated Successfully'),
          backgroundColor: Colors.green,
        ));
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminDisplay()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something Went Wrong. Please try again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminDisplay()),
          );
        });
      }
    }
  }
  Future<dynamic> DropDownDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blue,
        content:
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: DropdownButton<String>(
            value: dropdownValue,
            elevation: 16,
            style:
            const TextStyle(color: Colors.deepPurple),
            underline: Container(
              color: Colors.grey.withOpacity(0.1),
            ),
            iconDisabledColor: Colors.black,
            iconEnabledColor: Colors.black,
            iconSize: 25,
            dropdownColor: Colors.blue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                postData();
              });
            },
            items: <String>['Enable', 'Disable']
                .map<DropdownMenuItem<String>>(
                    (String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                          color: Colors.black),
                    ),
                  );
                }).toList(),
          ),
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
        width: 380,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:  CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: const AssetImage('assets/Client dummy.png'),
                radius: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    (widget.hospital.name.toString().capitalize()),
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
                        "Location : " +
                            (widget.hospital.location.toString()),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.lightBlueAccent,
                            fontSize: 12,
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
                        "Email : " + (widget.hospital.email ?? "Not Available"),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.lightBlueAccent,
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
                        "Password : " + (widget.hospital.passwordString ?? "Not Available"),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 20,
                    thickness: .8,
                    color: Colors.white,
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            if (widget.hospital.accountStatus == true) ...[
                              Text(
                                "Account Status : Enable",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ] else ...[
                              Text(
                                "Account Status : Disable",
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 45,
                                    width: 150,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Color(0xffe14589) , // foreground (text) color
                                      ),
                                      onPressed: () {
                                        DropDownDialog();
                                      },
                                      child: Text(
                                        "Edit Account Status",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]),
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
getToken() async {
  dynamic userDetails = await Global.getUserDetails();
  if (userDetails != null && userDetails is LoginModel) {
    return userDetails.token;
  }
}