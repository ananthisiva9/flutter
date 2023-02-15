import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:railway_super_app/utility/state_enum.dart';
import 'OTPVerification.dart';

class PassEmail extends StatefulWidget {
  const PassEmail({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _PassEmailState createState() => _PassEmailState();
}

class _PassEmailState extends State<PassEmail> {
  final TextEditingController _emailController = TextEditingController();
  bool login = false;
  bool isLoading = false;
  StateEnum? state;
  signIn(String email) async {
    String url = '${ApiEndPoint.email_verification}?id=1&email=$email';
    var response = await http.get(
      Uri.parse(url),
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['code'] == 500) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Invalid Email Id'),
          backgroundColor: Colors.red,
        ));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PassOTP(value: _emailController.text)),
        );
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
                  controller: _emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:
                            const BorderSide(width: 5, color: Colors.green)),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Email Id",
                    labelStyle: GoogleFonts.poppins(fontSize: 14),
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    bool passValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value!);
                    if (value.isEmpty) {
                      return 'Enter your registered Email Id';
                    } else if (!passValid) {
                      return 'Enter your registered Email Id';
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
                      signIn(_emailController.text);
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
                          "Send OTP",
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
              const SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Image(
                      image: const AssetImage('asset/EmailVerify.png'),
                      height: MediaQuery.of(context).size.height / 8)
                ],
              ),
              _buildContainer(),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Image(image: AssetImage('asset/Add2.png')),
              )
            ],
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
