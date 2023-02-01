import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/utility/api_endpoint.dart';

class ClientSignup extends StatefulWidget {
  @override
  _ClientSignupState createState() => _ClientSignupState();
}

class _ClientSignupState extends State<ClientSignup> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _referalIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _question8Controller = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  form1(
    String firstname,
    String lastname,
    String age,
    String email,
    String mobile,
    String address,
    String referalId,
    String question8,
    String password,
    String password2,
  ) async {
    String url = ApiEndPoint.client_registration;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "firstname": firstname,
      "lastname": lastname,
      "age": age,
      "email": email,
      "mobile": mobile,
      "address": address,
      "referalId": referalId,
      "Menstruation_date": question8,
      "password": password,
      "password2": password2,
    };
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body, headers: {
      "Api-Key":"aU60ViOC.02hdAGZ0gy4avx0oBCkhErSJK55anMuC",
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

  late String email,
      password,
      password2,
      name,
      address,
      married,
      date,
      age,
      mobile,
      question;

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

  Widget _buildReferralId() {
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
        controller: _referalIdController,
        decoration: InputDecoration(
          labelText: 'Doctor Referral Id',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: 1234',
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

  Widget _buildPassword2() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            password2 = value;
          });
        },
        controller: _password2Controller,
        decoration: InputDecoration(
          labelText: 'Conform Password',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: Pxx',
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
        keyboardType: TextInputType.number,
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
          hintText: 'ex: 25',
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

  Widget _buildAddress() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            address = value;
          });
        },
        controller: _addressController,
        decoration: InputDecoration(
          labelText: 'Address',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: location',
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
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            mobile = value;
          });
        },
        controller: _mobileController,
        decoration: InputDecoration(
          labelText: 'Mobile Number',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: 9xxxx xxxxx',
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

  Widget _buildQuestion8() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            question = value;
          });
        },
        controller: _question8Controller,
        decoration: InputDecoration(
          labelText: 'Last Menstrual Period Date',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex: yyyy/mm/dd',
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
            onPressed: _firstnameController.text == "" ||
                    _lastnameController.text == "" ||
                    _ageController.text == "" ||
                    _emailController.text == "" ||
                    _mobileController.text == "" ||
                    _addressController.text == "" ||
                    _referalIdController.text == "" ||
                    _question8Controller.text == "" ||
                    _passwordController.text == "" ||
                    _password2Controller.text == ""
                ? null
                : () {
                    form1(
                      _firstnameController.text,
                      _lastnameController.text,
                      _ageController.text,
                      _emailController.text,
                      _mobileController.text,
                      _addressController.text,
                      _referalIdController.text,
                      _question8Controller.text,
                      _passwordController.text,
                      _password2Controller.text,
                    );
                  },
            child: Text(
              "Next",
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
        Container(
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
                  _buildFirstname(),
                  _buildLastname(),
                  _buildAge(),
                  _buildEmail(),
                  _buildMobile(),
                  _buildAddress(),
                  _buildReferralId(),
                  _buildQuestion8(),
                  _buildPassword(),
                  _buildPassword2(),
                  _buildNextBtn(),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
