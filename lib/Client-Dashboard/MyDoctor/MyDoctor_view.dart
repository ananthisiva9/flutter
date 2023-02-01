import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/Client-Dashboard/MessageScreen/Massage/Message.dart';
import 'package:http/http.dart' as http;
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'BookAppoinment/BookAppointment_view.dart';

class MyDoctor extends StatefulWidget {
  @override
  _MyDoctorState createState() => _MyDoctorState();
}

class _MyDoctorState extends State<MyDoctor> {
  @override
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
      referralId,
      price,
      gender,
      hospitalManger,
      age,
      mobile,
      profile_full_url;
  late String data;
  bool isLoading = true;
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String? token = await getToken();
    String url = clientApi.my_doctor;
    if (token != null) {
      var response = await http
          .get(Uri.parse(url), headers: {'Authorization': "Token $token"});
      if (response.statusCode == 200) {
        data = response.body;
        print(data);
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
          referralId = jsonDecode(data)['referralId'];
          price = jsonDecode(data)['price'];
          gender = jsonDecode(data)['gender'];
          hospitalManger = jsonDecode(data)['hospitalManger'];
          profile_full_url = jsonDecode(data)['profile_full_url'];
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Details not found'),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
              'My Doctor',
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
                          MaterialPageRoute(
                            builder: (context) => ClientDisplay(),
                          ),
                        );
                      },
                    )),
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
                isLoading ? Center(child: LoadingIcon()) : _buildContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  getToken() async {
    dynamic userDetails = await Global.getUserDetails();
    if (userDetails != null && userDetails is LoginModel) {
      return userDetails.token;
    }
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 1.0,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.1),
                    ),
                    height: 200,
                    width: 420,
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: profile_full_url == null
                              ? CircleAvatar(
                            backgroundColor: Colors.cyan[100],
                            backgroundImage: AssetImage('assets/Client dummy.png'),
                            radius: 35,
                          )
                              : CircleAvatar(
                            backgroundColor: Colors.cyan[100],
                            backgroundImage: NetworkImage(
                              profile_full_url.toString(),
                            ),
                            radius: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child:  Column(
                              children: <Widget>[
                                TextButton(
                                  child: Text(
                                    "Dr. " +
                                        firstname.toString().capitalize() +
                                        lastname.toString().capitalize(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  onPressed: () {},
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      speciality.toString().capitalize(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      qualification.toString().capitalize(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Pay Rs. " + price.toString(),
                                      style: GoogleFonts.poppins(
                                        color: Colors.lightBlueAccent,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Divider(
                                  height: 30,
                                  color: Colors.white,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      height: 45,
                                      width: 200,
                                      margin: EdgeInsets.only(bottom: 20),
                                      child:  ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: Color(0xffe14589) , // foreground (text) color
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookAppointment(
                                                      value: id.toString()),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "Book Appointment",
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MessagesScreen(
                                                          id.toString(),
                                                          firstname
                                                              .toString(),profile_full_url)),
                                            );
                                          },
                                          icon: Icon(Icons.message),
                                          color: Colors.white,
                                          iconSize: 25,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
