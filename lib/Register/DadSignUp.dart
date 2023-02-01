import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/utility/api_endpoint.dart';

class DadSignup extends StatefulWidget {
  @override
  _DadSignupState createState() => _DadSignupState();
}

class _DadSignupState extends State<DadSignup> {
  TextEditingController _profile_imgController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _wife_emailController = TextEditingController();
  TextEditingController _wife_nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  form1(
    String profile_img,
    String firstname,
    String lastname,
    String age,
    String email,
    String mobile,
    String wife_email,
    String wife_name,
    String password,
  ) async {
    String url = dadApi.register;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "profile_img": profile_img,
      "firstname": firstname,
      "lastname": lastname,
      "age": age,
      "email": email,
      "mobile": mobile,
      "wife_email": wife_email,
      "wife_name": wife_name,
      "password": password,
    };
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body, headers: {
      "Api-Key": "aU60ViOC.02hdAGZ0gy4avx0oBCkhErSJK55anMuC",
    });
    if (res.statusCode == 201) {
      jsonResponse = json.decode(res.body);
      print("Response status:${res.statusCode}");
      print("Response status:${res.body}");
      if (jsonResponse != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your Account Registered Successfully'),
          backgroundColor: Colors.green,
        ));
        sharedPreferences.setString("token", jsonResponse['token']);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something Went Wrong!!! Please Try Again'),
        backgroundColor: Colors.red,
      ));
      print(res);
      print("Response status:${res.statusCode}");
    }
  }

  late String profile_img,
      name,
      age,
      email,
      mobile,
      wife_email,
      wife_name,
      password;
  Widget _buildProfileImg() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: ElevatedButton(
        onPressed: () async {
          final result = await FilePicker.platform.pickFiles();
          if (result == null) return;
          final file = result.files.first;
          _profile_imgController = file.path as TextEditingController;
          print(_profile_imgController);
          setState(() {});
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Color(0xffe14589),
          ),
        ),
        child: Text(
          'Select a File',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildFirstname() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        controller: _firstnameController,
        decoration: InputDecoration(
          labelText: 'First Name',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: Alexa',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildLastname() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        controller: _lastnameController,
        decoration: InputDecoration(
          labelText: 'Last Name',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: Alexa',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildAge() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            age = value;
          });
        },
        controller: _ageController,
        decoration: InputDecoration(
          labelText: 'Age',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: 30',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            name = value;
          });
        },
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: alexa@gmail.com',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildMobile() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          setState(() {
            mobile = value;
          });
        },
        controller: _mobileController,
        decoration: InputDecoration(
          labelText: 'Contact Number',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: 9876543210',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildWifeEmail() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            wife_email = value;
          });
        },
        controller: _wife_emailController,
        decoration: InputDecoration(
          labelText: 'Wife Email',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: alexa@gmail.com',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildWifeName() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            wife_name = value;
          });
        },
        controller: _wife_nameController,
        decoration: InputDecoration(
          labelText: 'Wife Name',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: alexa',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            password = value;
          });
        },
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: Pxxxx',
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 10,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildNextBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 20),
          width: 5 * (MediaQuery.of(context).size.width / 08),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _profile_imgController.text == "" ||
                    _firstnameController.text == "" ||
                    _lastnameController.text == "" ||
                    _ageController.text == "" ||
                    _emailController.text == "" ||
                    _mobileController.text == "" ||
                    _wife_emailController.text == "" ||
                    _wife_nameController.text == "" ||
                    _passwordController.text == ""
                ? null
                : () {
                    form1(
                      _profile_imgController.text,
                      _firstnameController.text,
                      _lastnameController.text,
                      _ageController.text,
                      _emailController.text,
                      _mobileController.text,
                      _wife_emailController.text,
                      _wife_nameController.text,
                      _passwordController.text,
                    );
                  },
            child: Text(
              "Submit",
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 20,
                fontFamily: 'Avenir',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 40),
          child: TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Already have an account? ',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                TextSpan(
                  text: 'SignIn',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Color(0xffe14589),
                      fontSize: MediaQuery.of(context).size.height / 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildContainer(),
                _buildSignUpBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 0.95,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Text(
                            "Kindly Spend some time to help us understand you better",
                            maxLines: 2,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  _buildProfileImg(),
                  _buildFirstname(),
                  _buildLastname(),
                  _buildAge(),
                  _buildEmail(),
                  _buildMobile(),
                  _buildWifeEmail(),
                  _buildWifeName(),
                  _buildPassword(),
                  _buildNextBtn(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
