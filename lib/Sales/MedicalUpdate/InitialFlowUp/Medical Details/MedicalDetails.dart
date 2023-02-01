import 'dart:convert';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class MedicalDetails extends StatefulWidget {
  @override
  _MedicalDetailsState createState() => _MedicalDetailsState();
}

class _MedicalDetailsState extends State<MedicalDetails> {
  var name, category;
  late String data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String? token = await getToken();
    String url = Sales.flowup_medical_get + '?customer=88';
    if (token != null) {
      var response = await http.get(Uri.parse(url), headers: {
        'Authorization': "Token $token",
      });
      if (response.statusCode == 200) {
        data = response.body;
        setState(() {
          isLoading = false;
          data = response.body;
          name = jsonDecode(data)['name'];
          category = jsonDecode(data)['category'];
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Login Details not found. You will be rerouted to the login page'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalesDisplay()),
        );
      });
    }
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/appbar.jpeg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              elevation: 0,
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
                            MaterialPageRoute(
                              builder: (context) => SalesDisplay(),
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
                child: _buildContainer(),
              ),
            ],
          )),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  if (category == "Medical history") ...[
                    Text(
                      "Medical History",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ] else ...[
                    Text(name)
                  ]
                ],
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
