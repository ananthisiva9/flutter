import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:railway_super_app/utility/state_enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class ForgotPassword extends StatefulWidget {
  String? email;
  ForgotPassword({Key? key, this.email}) : super(key: key);
  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _conformController = TextEditingController();
  bool login = false;
  bool isLoading = false;
  StateEnum? state;
  signIn(String password, String confirm) async {
    String? code;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    code = sharedPreferences.get('code') as String?;
    Map body = {
      "user_name": widget.email,
      "password": password,
    };
    String url = ApiEndPoint.forgot_password;
    var response = await http.post(
      Uri.parse(url),
      body : body
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['code'] == "INVALID CONTACTDETAILS ID") {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(response.body)['description'].toString()),
          backgroundColor: Colors.red,
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Your Password has been changed"),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()));
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.toString()),
        backgroundColor: Colors.red[900],
      ));
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
            image: const AssetImage('asset/Logo.png'),
            height: MediaQuery.of(context).size.height / 10)
      ],
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Railmitraa',
              style: GoogleFonts.poppins(
                color: const Color(0xff0093DD),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.deny(" ")],
                  controller: _passwordController,
                  decoration: InputDecoration(
                    errorMaxLines: 3,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:
                            const BorderSide(width: 5, color: Colors.green)),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "New Password",
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    bool passValid = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return 'Please enter valid password';
                    } else if (!passValid) {
                      return 'Use 8 or more character with mix of letters,numbers and symbol';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _conformController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  inputFormatters: [FilteringTextInputFormatter.deny(" ")],
                  decoration: InputDecoration(
                    errorMaxLines: 3,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:
                            const BorderSide(width: 5, color: Colors.green)),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Confirm Password",
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid password';
                    } else if (value != _passwordController.text) {
                      return 'Password Not Match';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1.4 * (MediaQuery.of(context).size.height / 20),
                width: 5 * (MediaQuery.of(context).size.width / 10),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                      colors: [Color(0xff5CACF9), Color(0xff0D72D0)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      signIn(_passwordController.text, _conformController.text);
                    }
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(const Duration(seconds: 1));
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: (isLoading)
                      ? const SizedBox(
                          width: 25,
                          height: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ))
                      : Text(
                          "Submit",
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => const Login()));
        return false;
      },
      child: Scaffold(
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image(
                      image: const AssetImage('asset/Add1.png'),
                      height: MediaQuery.of(context).size.height / 8,
                      width: 400),
                ),
                _buildLogo(),
                const SizedBox(
                  height: 10,
                ),
                _buildName(),
                _buildContainer(),
                Image(
                    image: const AssetImage('asset/Add2.png'),
                    height: MediaQuery.of(context).size.height / 8,
                    width: MediaQuery.of(context).size.height / 1),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
          child: Column(children: [
        _buildInput(),
      ])),
    );
  }
}
