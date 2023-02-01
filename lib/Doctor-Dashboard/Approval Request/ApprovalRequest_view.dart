import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/ClientProfile/ClientProfile.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'ApprovalRequest_controller.dart';
import 'ApprovalRequest_model.dart';
import 'Search.dart';
import 'package:http/http.dart' as http;

class ApprovalRequest extends StatefulWidget {
  final int? value;
  ApprovalRequest({Key? key, this.value}) : super(key: key);
  @override
  _ApprovalRequestState createState() => _ApprovalRequestState();
}

class _ApprovalRequestState extends State<ApprovalRequest> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApprovalRequestController(context),
      child: Consumer<ApprovalRequestController>(
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
                'Approval Request',
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
                            delegate: DataSearch(controller.model!.items!));
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
                      ? controller.model!.items!.isEmpty
                          ? Center(
                              child: Text(
                                'No Request available',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : Container(
                              child: new ListView.builder(
                                  itemBuilder: (_, int index) => Data(
                                      controller.dummylist[index],
                                      controller,
                                      widget.value),
                                  itemCount: controller.dummylist.length),
                            )
                      : Container(),
            ],
          ),
        );
      }),
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }
}

class Data extends StatelessWidget {
  ApprovalRequestItem item;
  ApprovalRequestController controller;
  final int? value;
  Data(this.item, this.controller, this.value);
  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }

  void fetchPostApproveApi(BuildContext context, int? id) async {
    int? appointmentId = id;
    String? token = await getToken();
    if (token != null) {
      String url = doctorApi.approve_approval;
      Map<String, String> body = {
        'appointmentID': appointmentId.toString(),
      };
      var res = await http.post(Uri.parse(url),
          body: body, headers: {"Authorization": "Token ${token}"});
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Appointment Approved Sucessfully'),
          backgroundColor: Colors.green,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Display()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something Went Wrong!!!'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Display()),
          );
        });
      }
    }
  }

  void fetchPostDeclineApi(BuildContext context, int? id) async {
    int? appointmentId = id;

    String? token = await getToken();
    if (token != null) {
      String url = doctorApi.reject_approval;
      Map<String, String> body = {
        'appointmentID': appointmentId.toString(),
      };
      var res = await http.post(Uri.parse(url),
          body: body, headers: {"Authorization": "Token ${token}"});
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Appointment Rejected Successfully'),
          backgroundColor: Colors.green,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Display()),
          );
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Something Went Wrong!!!'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Display()),
          );
        });
      }
    }
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
              child: item.client_profile_pic == null
                  ? CircleAvatar(
                      backgroundColor: Colors.cyan[100],
                      backgroundImage: AssetImage('assets/Client dummy.png'),
                      radius: 35,
                    )
                  : CircleAvatar(
                      backgroundColor: Colors.cyan[100],
                      backgroundImage: NetworkImage(
                        item.client_profile_pic.toString(),
                      ),
                      radius: 35,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    item.clientName.toString().capitalize(),
                    style:
                        GoogleFonts.poppins(fontSize: 18, color: Colors.white),
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
                        item.week.toString() +
                            " Weeks " +
                            item.days.toString() +
                            " Days Left", //TODO:
                        style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 30,
                    thickness: .8,
                    color: Colors.white,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 25,
                          width: 100,
                          margin: EdgeInsets.only(bottom: 5),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xffe14589),
                            ),
                            onPressed: () {
                              fetchPostDeclineApi(context, item.id);
                            },
                            child: Text(
                              "Reject",
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 25,
                        width: 100,
                        margin: EdgeInsets.only(bottom: 5),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffe14589),
                          ),
                          onPressed: () {
                            fetchPostApproveApi(context, item.id);
                          },
                          child: Text(
                            "Approve",
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 15,
                            ),
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
                        "Date : " + (item.formated_date ?? "Not available"),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Time : " + (item.formated_time ?? "Not available"),
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
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
    );
  }
}
