import 'dart:convert';
import 'dart:ui';
import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';

class DoctorDetails extends StatefulWidget {
  DoctorDetails(this.id);
  String id;
  @override
  _DoctorDetailsState createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  var id,
      firstname,
      lastname,
      email,
      speciality,
      qualification,
      medicalCouncil,
      hospitals,
      interests,
      placeOfWork,
      onlineConsultation,
      experience,
      languages,
      location,
      referalId,
      price,
      gender,
      hospitalManger,
      age,
      mobile,
      profile_full_url;
  bool isLoading = true;
  late String data;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String? token = await getToken();
    String url = Admin.details + '?doctor=' + widget.id;
    if (token != null) {
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': "Token $token"});
      if (response.statusCode == 200) {
        data = response.body;
        setState(() {
          isLoading = false;
          data = response.body;
          id = jsonDecode(data)['id'];
          firstname = jsonDecode(data)['firstname'];
          lastname = jsonDecode(data)['lastname'];
          email = jsonDecode(data)['email'];
          mobile = jsonDecode(data)['mobile'];
          speciality = jsonDecode(data)['speciality'];
          qualification = jsonDecode(data)['qualification'];
          medicalCouncil = jsonDecode(data)['medicalCouncil'];
          hospitals = jsonDecode(data)['hospitals'];
          interests = jsonDecode(data)['interests'];
          placeOfWork = jsonDecode(data)['placeOfWork'];
          onlineConsultation = jsonDecode(data)['onlineConsultation'];
          experience = jsonDecode(data)['experience'];
          age = jsonDecode(data)['age'];
          languages = jsonDecode(data)['languages'];
          location = jsonDecode(data)['location'];
          referalId = jsonDecode(data)['referalId'];
          price = jsonDecode(data)['price'];
          gender = jsonDecode(data)['gender'];
          hospitalManger = jsonDecode(data)['hospitalManger'];
          profile_full_url = jsonDecode(data)['profile_full_url'];
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Details not found'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget _buildFullname() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "Name : ",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: firstname.toString().capitalize() +
                    lastname.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "EMail : ",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: email.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Contact Number: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: mobile.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildAge() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Age : ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: age.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguages() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Languages: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: languages.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildLocation() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Location: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: location.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildGender() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Gender: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: gender.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildSpeciality() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Speciality: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: speciality.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildQualification() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Qualification: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: qualification.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildExperience() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Experience: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: experience.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitals() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Hospitals Working: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: hospitals.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 10,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildInterests() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Are of Interests: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: interests.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceOfWork() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'PlaceOfWork: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: placeOfWork.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalCouncil() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'MedicalCouncil Required?: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: medicalCouncil.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineConsultation() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Are You Willing to Give OnlineConsultation? : ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: onlineConsultation.toString().capitalize(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildReferralId() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 2, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Reference Code : ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: referalId.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 5, right: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(children: [
              TextSpan(
                text: 'Your Consultation Fee: ',
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              TextSpan(
                text: price.toString(),
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image:  DecorationImage(
                  image: AssetImage('assets/appbar.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            elevation: 0,
            title: Text(
              'Doctor Details',
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
                  margin: const EdgeInsets.only(right: 15),
                  child: IconButton(
                    icon: const Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AdminDisplay()),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SingleChildScrollView(
                  child: isLoading
                      ? const Center(child:  LoadingIcon())
                      : _buildContainer(),
                )
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
          borderRadius: const BorderRadius.only(
              topLeft:  Radius.circular(20), topRight:  Radius.circular(20)),
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.87,
              width: MediaQuery.of(context).size.width * 1.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 100,
                        child: Container(
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black.withOpacity(0.1),
                          ),
                          width: 300,
                          child: Stack(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: profile_full_url == null
                                        ? const CircleAvatar(
                                      backgroundImage:  AssetImage('assets/Client dummy.png'),
                                      radius: 35,
                                    )
                                        : CircleAvatar(
                                      backgroundImage: NetworkImage(
                                        profile_full_url.toString(),
                                      ),
                                      radius: 35,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        children: <Widget>[
                                          RichText(
                                            text: TextSpan(children: [
                                              TextSpan(
                                                text: "Name: " + " ",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                text: " Dr.",
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color:
                                                    Colors.lightBlueAccent,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                              TextSpan(
                                                text: firstname
                                                    .toString()
                                                    .capitalize(),
                                                style: GoogleFonts.poppins(
                                                  textStyle: const TextStyle(
                                                    color:
                                                    Colors.lightBlueAccent,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          ),
                                          const Divider(
                                            height: 5,
                                            thickness: .1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildAge(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildEmail(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildGender(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildLocation(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildSpeciality(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildExperience(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildLanguages(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildQualification(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildPlaceOfWork(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildInterests(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildMobile(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildReferralId(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildPrice(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildMedicalCouncil(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildHospitals(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: _buildOnlineConsultation(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

getToken() async {
  dynamic userDetails = await Global.getUserDetails();
  if (userDetails != null && userDetails is LoginModel) {
    return userDetails.token;
  }
}