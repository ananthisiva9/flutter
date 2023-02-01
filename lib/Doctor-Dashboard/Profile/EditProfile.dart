import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'Profile.dart';

class EditDoctorProfile extends StatefulWidget {
  final int? value;
  EditDoctorProfile({Key? key, this.value}) : super(key: key);
  @override
  EditDoctorProfileState createState() => EditDoctorProfileState();
}

class EditDoctorProfileState extends State<EditDoctorProfile> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _specialityController = TextEditingController();
  TextEditingController _qualificationController = TextEditingController();
  TextEditingController _medicalCouncilController = TextEditingController();
  TextEditingController _hospitalsController = TextEditingController();
  TextEditingController _interestController = TextEditingController();
  TextEditingController _placeOfWorkController = TextEditingController();
  TextEditingController _onlineConsultationController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  bool isLoading = true;
  form1(
      String firstname,
      String lastname,
      String email,
      String mobile,
      String speciality,
      String qualification,
      String medicalCouncil,
      String hospitals,
      String interests,
      String placeOfWork,
      String onlineConsultation,
      String price) async {
    String url = doctorApi.update_profile;
    Map body = {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "mobile": mobile,
      "speciality": speciality,
      "qualification": qualification,
      "medicalCouncil": medicalCouncil,
      "hospitals": hospitals,
      "interests": interests,
      "placeOfWork": placeOfWork,
      "onlineConsultation": onlineConsultation,
      "price": price.toString()
    };
    String? token = await getToken();
    if (token != null) {
      var res = await http.patch(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your Profile Updated Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Profile not Submitted ,Please try again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DoctorProfile()),
          );
        });
      }
    }
  }

  late String name,
      email,
      speciality,
      qualification,
      medicalCouncil,
      hospitals,
      interests,
      placeOfWork,
      onlineConsultation,
      price;
  Widget _buildFirstname() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Firstname",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            controller: _firstnameController,
            decoration: InputDecoration(
              hintText: "Firstname",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLastname() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Lastname",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            controller: _lastnameController,
            decoration: InputDecoration(
              hintText: "Lastname",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            controller: _emailController,
            decoration: InputDecoration(
              hintText: "Email",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Mobile",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                name = value;
              });
            },
            controller: _mobileController,
            decoration: InputDecoration(
              hintText: "Contact Number",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeciality() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Speciality",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                speciality = value;
              });
            },
            controller: _specialityController,
            decoration: InputDecoration(
              hintText: "Speciality",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQualification() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Qualification",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                qualification = value;
              });
            },
            controller: _qualificationController,
            decoration: InputDecoration(
              hintText: "Qualification",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalCouncil() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "MedicalCouncil",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                medicalCouncil = value;
              });
            },
            controller: _medicalCouncilController,
            decoration: InputDecoration(
              hintText: "MedicalCouncil",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitals() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Hospitals",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                hospitals = value;
              });
            },
            controller: _hospitalsController,
            decoration: InputDecoration(
              hintText: "Hospitals",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterests() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Interests",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                interests = value;
              });
            },
            controller: _interestController,
            decoration: InputDecoration(
              hintText: "Interests",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOfWork() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "PlaceOfWork",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                placeOfWork = value;
              });
            },
            controller: _placeOfWorkController,
            decoration: InputDecoration(
              hintText: "PlaceOfWork",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineConsultation() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "OnlineConsultation",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                onlineConsultation = value;
              });
            },
            controller: _onlineConsultationController,
            decoration: InputDecoration(
              hintText: "OnlineConsultation",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Consultation Fees",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            style: TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                price = value;
              });
            },
            controller: _priceController,
            decoration: InputDecoration(
              hintText: "Consultation Fees",
              hintStyle: TextStyle(color: Colors.white, fontSize: 14),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNextBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 5 * (MediaQuery.of(context).size.width / 09),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
    ),
            onPressed: _firstnameController.text == "" ||
                    _lastnameController.text == "" ||
                    _emailController.text == "" ||
                    _mobileController.text == "" ||
                    _specialityController.text == "" ||
                    _qualificationController.text == "" ||
                    _medicalCouncilController.text == "" ||
                    _hospitalsController.text == "" ||
                    _interestController.text == "" ||
                    _placeOfWorkController.text == "" ||
                    _onlineConsultationController.text == "" ||
                    _priceController.text == ""
                ? null
                : () {
                    setState(() {
                      isLoading = true;
                    });
                    form1(
                        _firstnameController.text,
                        _lastnameController.text,
                        _emailController.text,
                        _mobileController.text,
                        _specialityController.text,
                        _qualificationController.text,
                        _medicalCouncilController.text,
                        _hospitalsController.text,
                        _interestController.text,
                        _placeOfWorkController.text,
                        _onlineConsultationController.text,
                        _priceController.text);
                  },
            child: Text(
              "Submit Your Details",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void initState() {
    // TODO: implement initState
    fetchData();
    super.initState();
  }

  fetchData() async {
    String? token = await getToken();
    String url = doctorApi.doctor_profile + '?doctor=${widget.value}';
    if (token != null) {
      final response = await http
          .get(Uri.parse(url), headers: {'Authorization': "Token $token"});
      if (response.statusCode == 200) {
        _firstnameController.text = jsonDecode(response.body)["firstname"];
        _lastnameController.text = jsonDecode(response.body)["lastname"];
        _emailController.text = jsonDecode(response.body)["email"];
        _mobileController.text = jsonDecode(response.body)["mobile"];
        _specialityController.text = jsonDecode(response.body)["speciality"];
        _qualificationController.text =
            jsonDecode(response.body)["qualification"];
        _medicalCouncilController.text =
            jsonDecode(response.body)["medicalCouncil"];
        _hospitalsController.text = jsonDecode(response.body)["hospitals"];
        _interestController.text = jsonDecode(response.body)["interests"];
        _placeOfWorkController.text = jsonDecode(response.body)["placeOfWork"];
        _onlineConsultationController.text =
            jsonDecode(response.body)["onlineConsultation"];
        _priceController.text = jsonDecode(response.body)["price"];
      } else {
        throw Exception('Failed to load album');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            'Edit Profile',
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
                    Icons.home,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Display()),
                    );
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
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFirstname(),
                _buildLastname(),
                _buildEmail(),
                _buildMobile(),
                _buildSpeciality(),
                _buildQualification(),
                _buildMedicalCouncil(),
                _buildHospitals(),
                _buildInterests(),
                _buildPlaceOfWork(),
                _buildOnlineConsultation(),
                _buildPrice(),
                _buildNextBtn(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }
}
