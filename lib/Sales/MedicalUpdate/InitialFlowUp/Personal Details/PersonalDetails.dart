import 'dart:convert';
import 'package:admin_dashboard/Sales/AllClients/AllClients.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';

class PersonalDetails extends StatefulWidget {
  int id;
  PersonalDetails(this.id);
  @override
  PersonalDetailsState createState() => PersonalDetailsState();
}

class PersonalDetailsState extends State<PersonalDetails> {
 TextEditingController _ageController = TextEditingController();
  TextEditingController _bmiController = TextEditingController();
  TextEditingController _blood_group_momController = TextEditingController();
  TextEditingController _blood_group_dadController = TextEditingController();
  TextEditingController _domestic_voilenceController = TextEditingController();
  bool isLoading = true;
  postData(int age,String bmi, blood_group_mom, blood_group_dad,
      domestic_voilence) async {
    int customerId = widget.id;
    String url = Sales.personal_details_post + '?customer=' + widget.id.toString();
    Map body = {
      "customer": customerId.toString(),
      "age": age,
      "bmi": bmi,
      "blood_group_mom": blood_group_mom,
      "blood_group_dad": blood_group_dad,
      "domestic_voilence": domestic_voilence
    };
    String? token = await getToken();
    if (token != null) {
      var res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Token $token"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Your Details Submitted Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Details not Submitted ,Please Try Again!!!'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AllClient()),
          );
        });
      }
    }
  }

  late String bmi, blood_group_mom, blood_group_dad, domestic_voilence;
  late int age;
  Widget _buildAge() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            age = value as int;
          });
        },
        controller: _ageController,
        decoration: const InputDecoration(
          hintText: 'Age',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBmi() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            bmi = value;
          });
        },
        controller: _bmiController,
        decoration: const InputDecoration(
          hintText: 'Bmi',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMomBlood() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            blood_group_mom = value;
          });
        },
        controller: _blood_group_momController,
        decoration: const InputDecoration(
          hintText: 'Blood Group Of Mom',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDadBlood() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            blood_group_dad = value;
          });
        },
        controller: _blood_group_dadController,
        decoration: const InputDecoration(
          hintText: 'Blood Group Of Dad',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDomesticViolence() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            domestic_voilence = value;
          });
        },
        controller: _domestic_voilenceController,
        decoration: const InputDecoration(
          hintText: 'Domestic Violence',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
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
          height: 1.4 * (MediaQuery.of(context).size.height / 25),
          width: 5 * (MediaQuery.of(context).size.width / 09),
          margin: const EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _ageController.text == "" ||
                    _bmiController.text == "" ||
                    _blood_group_momController.text == "" ||
                    _blood_group_dadController.text == "" ||
                    _domestic_voilenceController.text == ""
                ? null
                : () {
                    setState(() {
                      isLoading = true;
                    });
                    postData(
                        _ageController as int,
                        _bmiController.text,
                        _blood_group_momController.text,
                        _blood_group_dadController.text,
                        _domestic_voilenceController.text);
                  },
            child: const Text(
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

  void initState() {
    // TODO: implement initState
    fetchDetails();
    super.initState();
  }

  fetchDetails() async {
    String? token = await getToken();
    String url =
        Sales.personal_detail_get + '?customer=' + widget.id.toString();
    if (token != null) {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Token $token"
      });
      if (response.statusCode == 200) {
        _ageController.text = jsonDecode(response.body)["age"];
        _bmiController.text = jsonDecode(response.body)["bmi"];
        _blood_group_momController.text = jsonDecode(response.body)["blood_group_mom"];
        _blood_group_dadController.text = jsonDecode(response.body)["blood_group_dad"];
        _domestic_voilenceController.text = jsonDecode(response.body)["domestic_voilence"];
       // _frequency_of_call = jsonDecode(response.body)["frequency_of_call"];
       // notes = jsonDecode(response.body)["notes"];

      } else {
        throw Exception('Failed to load album');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset('assets/Background.png').image,
                    fit: BoxFit.cover)),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _buildAge(),
              _buildBmi(),
              _buildMomBlood(),
              _buildDadBlood(),
              _buildDomesticViolence(),
              _buildNextBtn(),
            ],
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
