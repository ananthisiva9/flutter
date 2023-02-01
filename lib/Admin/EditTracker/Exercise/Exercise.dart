import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:http/http.dart' as http;
import 'EditExercise.dart';
import 'Exercise_controller.dart';
import 'Exercise_model.dart';

class EditExercise extends StatefulWidget {
  @override
  _EditExerciseState createState() => _EditExerciseState();
}

class _EditExerciseState extends State<EditExercise> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => EditExerciseController(context),
      child: Consumer<EditExerciseController>(
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
                    ? const Center(child: LoadingIcon())
                    : controller.state == StateEnum.success
                        ? (controller.model!.items == null ||
                                controller.model!.items!.isEmpty)
                            ? Center(
                                child: Text(
                                  ' Exercise Unavailable',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (_, int index) =>
                                    Data(controller.model!.items![index]),
                                itemCount: controller.model!.items!.length,
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchAllExercise();
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
  Data(this.exercise, {Key? key}) : super(key: key);
  Exercise exercise;
  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  String dropdownValue = 'Enable';
  postData() async {
    String appointmentId = widget.exercise.id.toString();
    String url = Admin.toggle_exercise;
    Map body = {
      "id": appointmentId.toString(),
    };
    String? token = await getToken();
    if (token != null) {
      var res = await http.patch(
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
            MaterialPageRoute(builder: (context) => EditExercise()),
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
            MaterialPageRoute(builder: (context) => EditExercise()),
          );
        });
      }
    }
  }
  Future<dynamic> DropDownDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.cyan,
        title: Text(
          "Exercise Status",
          style: GoogleFonts.poppins(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        content: Row(
          children: <Widget>[
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
                iconDisabledColor: Colors.white,
                iconEnabledColor: Colors.white,
                iconSize: 25,
                dropdownColor: Colors.lightBlueAccent,
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
                              color: Colors.white),
                        ),
                      );
                    }).toList(),
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
        height: 185,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      (widget.exercise.name.toString().capitalize()),
                      style: GoogleFonts.poppins(
                          fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if (widget.exercise.disabled == true) ...[
                          Text(
                            "Exercise Status : Enable",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 12),
                          ),
                        ] else ...[
                          Text(
                            "Exercise Status : Disable",
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 12),
                          ),
                        ],
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: <Widget>[
                              Container(
                                height: 35,
                                width: 150,
                                child:ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue , // foreground (text) color
                                  ),
                                  onPressed: () {
                                    DropDownDialog();
                                  },
                                  child: Text(
                                    "Edit Exercise Status",
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 35,
                              width: 125,
                              child:ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        EditExerciseName(value: widget.exercise.id.toString()),
                                    backgroundColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Edit",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
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
