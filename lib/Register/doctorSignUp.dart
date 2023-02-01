import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/state_enum.dart';

class DoctorSignup extends StatefulWidget {
  @override
  _DoctorSignupState createState() => _DoctorSignupState();
}

class _DoctorSignupState extends State<DoctorSignup> {
  TextEditingController _referalIdController = TextEditingController();
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _password2Controller = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _specialityController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _medicalCouncilController = TextEditingController();
  TextEditingController _councilRegNoController = TextEditingController();
  TextEditingController _hospitalsController = TextEditingController();
  TextEditingController _placeOfWorkController = TextEditingController();
  TextEditingController _onlineConsultationController = TextEditingController();
  TextEditingController _experienceController = TextEditingController();
  TextEditingController _interestsController = TextEditingController();
  bool _isLoading = false;
  form1(
    String referalId,
    String firstname,
    String lastname,
    String email,
    String password,
    String password2,
    String age,
    String mobile,
    String speciality,
    String qualification,
    String medicalCouncil,
    String councilRegNo,
    String hospitals,
    String placeOfWork,
    String onlineConsultation,
    String experience,
    String interests,
  ) async {
    String url = ApiEndPoint.doctor_registation;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map body = {
      "referalId": referalId,
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password,
      "password2": password2,
      "age": age,
      "mobile": mobile,
      "speciality": speciality,
      "qualification": qualification,
      "medicalCouncil": medicalCouncil,
      "councilRegNo": councilRegNo,
      "hospitals": hospitals,
      "placeOfWork": placeOfWork,
      "onlineConsultation": onlineConsultation,
      "experience": experience,
      "interests": interests
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
    }
  }

  late String referalId,
      firstname,
      lastname,
      email,
      password,
      password2,
      age,
      mobile,
      speciality,
      qualification,
      medicalCouncil,
      councilRegNo,
      hospitals,
      placeOfWork,
      onlineConsultation,
      experience,
      interests;

  Widget _buildReferralId() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            referalId = value;
          });
        },
        controller: _referalIdController,
        decoration: InputDecoration(
          labelText: 'Referral Id',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintText: 'ex:123',
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
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
            firstname = value;
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
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
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
            lastname = value;
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
          hintText: 'ex:Alexa',
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
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
            email = value;
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
          hintText: 'ex:alexa@gmail.com',
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
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
          hintText: 'ex:xxxx',
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
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
          hintText: 'ex:xxx',
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
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
          hintText: 'ex:25',
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
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
          hintText: 'ex:9xxxx xxxxx',
          hintStyle: TextStyle(color: Colors.white, fontSize: 10),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSpeciality() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            speciality = value;
          });
        },
        controller: _specialityController,
        decoration: InputDecoration(
          labelText: 'Speciality',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildQualification() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            qualification = value;
          });
        },
        controller: _qualificationController,
        decoration: InputDecoration(
          labelText: 'Qualification',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildMedicalCouncil() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            medicalCouncil = value;
          });
        },
        controller: _medicalCouncilController,
        decoration: InputDecoration(
          labelText: 'Medical Council',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildCouncilRegNo() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            councilRegNo = value;
          });
        },
        controller: _councilRegNoController,
        decoration: InputDecoration(
          labelText: 'Council Reg No',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildHospitals() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            hospitals = value;
          });
        },
        controller: _hospitalsController,
        decoration: InputDecoration(
          labelText: 'Hospitals',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceOfWork() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            placeOfWork = value;
          });
        },
        controller: _placeOfWorkController,
        decoration: InputDecoration(
          labelText: 'Place Of Work',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineConsultation() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          setState(() {
            onlineConsultation = value;
          });
        },
        controller: _onlineConsultationController,
        decoration: InputDecoration(
          labelText: 'Online Consultation',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildExperience() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            experience = value;
          });
        },
        controller: _experienceController,
        decoration: InputDecoration(
          labelText: 'Experience',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildInterest() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        onChanged: (value) {
          setState(() {
            interests = value;
          });
        },
        controller: _interestsController,
        decoration: InputDecoration(
          labelText: 'Interest',
          labelStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
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
          child:  ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _referalIdController.text == "" ||
                    _firstnameController.text == "" ||
                    _lastnameController.text == "" ||
                    _emailController.text == "" ||
                    _passwordController.text == "" ||
                    _password2Controller.text == "" ||
                    _ageController.text == "" ||
                    _mobileController.text == "" ||
                    _specialityController.text == "" ||
                    _qualificationController.text == "" ||
                    _medicalCouncilController.text == "" ||
                    _councilRegNoController.text == "" ||
                    _hospitalsController.text == "" ||
                    _placeOfWorkController.text == "" ||
                    _onlineConsultationController.text == "" ||
                    _experienceController.text == "" ||
                    _interestsController.text == ""
                ? null
                : () {
                    setState(() {
                      _isLoading = true;
                    });
                    form1(
                      _referalIdController.text,
                      _firstnameController.text,
                      _lastnameController.text,
                      _emailController.text,
                      _passwordController.text,
                      _password2Controller.text,
                      _ageController.text,
                      _mobileController.text,
                      _specialityController.text,
                      _qualificationController.text,
                      _medicalCouncilController.text,
                      _councilRegNoController.text,
                      _hospitalsController.text,
                      _placeOfWorkController.text,
                      _onlineConsultationController.text,
                      _experienceController.text,
                      _interestsController.text,
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
            Radius.circular(10),
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
                      Expanded(
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
                    ],
                  ),
                  _buildReferralId(),
                  _buildFirstname(),
                  _buildLastname(),
                  _buildEmail(),
                  _buildPassword(),
                  _buildPassword2(),
                  _buildAge(),
                  _buildMobile(),
                  _buildSpeciality(),
                  _buildQualification(),
                  _buildMedicalCouncil(),
                  _buildCouncilRegNo(),
                  _buildHospitals(),
                  _buildPlaceOfWork(),
                  _buildOnlineConsultation(),
                  _buildExperience(),
                  _buildInterest(),
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
