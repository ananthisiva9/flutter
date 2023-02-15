import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/User/Contest/Contest.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PoetryContest extends StatefulWidget {
  String? id, type;
  PoetryContest(this.id, this.type, {super.key});
  @override
  State<PoetryContest> createState() => _PoetryContestState();
}

class _PoetryContestState extends State<PoetryContest> {
  final TextEditingController _poemController = TextEditingController();
  bool _clicked = false;

  @override
  void initState() {
    logStart();
    super.initState();
  }

  // ignore: prefer_typing_uninitialized_variables
  var message, poem;
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
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
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
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  postData(String poem) async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    String url = ApiEndPoint.potery_contest;
    Map body = {
      "poem": poem,
      "contest_type_id": widget.type,
      "contest_module_id": widget.id
    };
    var res = await http.post(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
      body: body,
    );
    if (res.statusCode == 200) {
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<dynamic> dialog() {
    return showDialog(
      context: context,
      builder: (context) => WillPopScope(
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
                height: MediaQuery.of(context).size.height / 15,
                width: MediaQuery.of(context).size.width / 3,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xff2DCAA9), // foreground (text) color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    logEnd();
                   postData(_poemController.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Contest()),
                    );
                  },
                  child: Text(
                    "Done",
                    style: GoogleFonts.roboto(
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const Contest()));
        return false;
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(10),
          child: AppBar(
            backgroundColor: const Color(0xff0093DD),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25))),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(image: AssetImage('asset/Add1.png')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.5,
                  width: MediaQuery.of(context).size.width / 1.2,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: Image.asset('asset/Poetryback.png').image,
                          fit: BoxFit.cover)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('asset/Poetry.png'),
                        height: 145,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 15,
                          width: MediaQuery.of(context).size.width / 0.5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.black.withOpacity(0.3)),
                          child: const Center(
                            child: Text(
                              "Poetry Contest",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 150,
                          maxLength: 250,
                         style: const TextStyle(fontSize: 20),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.multiline,
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid Text';
                            } else if (poem == null || poem.isEmpty) {
                              return 'Please enter valid Text';
                            }
                            return poem.length < 3
                                ? 'Name must be greater than three characters'
                                : null;
                          },
                          onChanged: (value) {
                            setState(() {
                              poem = value.trim();
                            });
                          },
                          controller: _poemController,
                          decoration: InputDecoration(
                            labelText: "Write Your Thoughts Here",
                            labelStyle: GoogleFonts.roboto(fontSize: 20),
                            fillColor: Colors.white70,
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
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width / 2,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff2DCAA9),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                           ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                dialog();
                              }
                            },
                            child: Text(
                              'Submit',
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(image: AssetImage('asset/Add3.png')),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 80,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
