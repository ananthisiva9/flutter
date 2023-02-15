// ignore_for_file: use_build_context_synchronously
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:railway_super_app/utility/state_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'Profile/Profile.dart';

class FeedBack extends StatefulWidget {
  const FeedBack({Key? key}) : super(key: key);
  @override
  State<FeedBack> createState() => _FeedBackState();
}

class _FeedBackState extends State<FeedBack> {
  final TextEditingController _feedbackController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool login = false;
  String? feedback, message;
  StateEnum? state;

   logStart() async {
    String url =
        '${ApiEndPoint.log_start}?app_label=Railway&Module_name=Poetry Contest';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      message = jsonDecode(res.body)['message'];
    // ignore: duplicate_ignore
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  logEnd() async {
    String url = '${ApiEndPoint.log_end}?id=$message';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  postData(String feedback) async {
    String url = '${ApiEndPoint.feedback}?feedback=$feedback';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.post(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      dialog();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<dynamic> dialog() {
    return showDialog(
      context: context,
      builder: (context) =>
          WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: Column(
                children: [
                  const Image(
                    image: AssetImage('asset/Congratulation.png'),
                  ),
                  Text(
                    'Thanks For Submitting',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              actions: [
                Center(
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height / 15,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width / 3,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2DCAA9),
                        // foreground (text) color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        logEnd();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Profile()),
                        );
                      },
                      child: Text(
                        "Done",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        //wrap with PreferredSize
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: const Color(0xff0093DD),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
      ),
      body: Builder(
        builder: (context) =>
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('asset/Add1.png')),
                    const SizedBox(
                      height: 150,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: TextFormField(
                              style: const TextStyle(fontSize: 20),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.multiline,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter valid Feedback';
                                } else
                                if (feedback == null || feedback!.isEmpty) {
                                  return 'Please enter valid Feedback';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  feedback = value.trim();
                                });
                              },
                              controller: _feedbackController,
                              decoration: InputDecoration(
                                hintText: 'Write Your Feedback',
                                hintStyle: GoogleFonts.poppins(fontSize: 20),
                                border: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.black, width: 2),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: MediaQuery
                                .of(context)
                                .size
                                .height / 15,
                            width: MediaQuery
                                .of(context)
                                .size
                                .width / 2,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff2DCAA9),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  postData(_feedbackController.text);
                                }
                              },
                              child:
                              Text(
                                'Submit',
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const  Image(image: AssetImage('asset/Add3.png')),
                  ],
                ),
              ),
            ),
      ),
    );
  }
}