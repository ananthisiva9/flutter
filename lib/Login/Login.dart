import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  postData(String email, String password) async {
    String url = 'https://development.erpsofts.com/apis/login';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {"email ": email, "password": password};
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    if (res.statusCode == 200) {
      jsonResponse = json.decode(res.body);
      print("Status : ${res.statusCode}");
      print("Status : ${res.body}");
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString('token', jsonResponse['token']);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  _launchWhatsapp() async {
    var whatsapp = "+918310361527";
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text=Hey, I need help in using Development App");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  String sum = "0";
  bool isLoading = true;

  Future openUserName() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Forgot Password'),
          content: TextFormField(
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: 'Username',
              labelStyle: TextStyle(color: Colors.black, fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              onPressed: () {
                openPhoneNumber();
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
  Future openPhoneNumber() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Forgot Password'),
          content: TextFormField(
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: const InputDecoration(
              labelText: '',
              labelStyle: TextStyle(color: Colors.black, fontSize: 12),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              onPressed: () {
                openOtp();
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
  Future openOtp() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Enter OTP'),
          content: TextFormField(
            style: const TextStyle(color: Colors.black),
            cursorColor: Colors.black,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.indigo),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              onPressed: () {},
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      );
  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        decoration: const InputDecoration(
          labelText: 'Username',
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        controller: _passwordController,
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.indigo),
        onPressed: () {
          _emailController.text == "" || _passwordController.text == ""
              ? null
              : () {
                  setState(() {
                    _isLoading = true;
                  });
                  postData(_emailController.text, _passwordController.text);
                };
        },
        child:const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20,
                ),
              ),
      ),
    );
  }

  Widget _buildNeedHelp() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: () {
          _launchWhatsapp();
        },
        child: Text(
          'Need Help ?',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: () {
          openUserName();
        },
        child: Text(
          'Forgot Password ?',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/login.jpg').image,
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildContainer(),
                ],
              ),
    ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                      image: AssetImage('assets/demo logo.png'), height: 70),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Text(
                      "Development",
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                _buildEmail(),
                _buildPassword(),
                _buildLoginBtn(),
                _buildForgotPassword(),
                _buildNeedHelp(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
