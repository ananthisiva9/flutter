import 'dart:convert';
import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';

class EditClientProfile extends StatefulWidget {
  final int value;
  const EditClientProfile({Key? key, required this.value}) : super(key: key);
  @override
  EditClientProfileState createState() => EditClientProfileState();
}

class EditClientProfileState extends State<EditClientProfile> {
  TextEditingController _firstnameController = TextEditingController();
  TextEditingController _lastnameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _husbandController = TextEditingController();
  TextEditingController _marriedSinceController = TextEditingController();
  TextEditingController _abortionsController = TextEditingController();
  TextEditingController _twinsController = TextEditingController();
  TextEditingController _diabetesController = TextEditingController();
  TextEditingController _allergicreactionController = TextEditingController();
  TextEditingController _surgeryController = TextEditingController();
  TextEditingController _MenstruationController = TextEditingController();
  TextEditingController _MenstruationdateController = TextEditingController();
  TextEditingController _hereditoryController = TextEditingController();
  TextEditingController _gynacologyController = TextEditingController();
  TextEditingController _no_of_babies_pregnant_withController = TextEditingController();
  TextEditingController _doctor_final_visitController = TextEditingController();
  bool isLoading = true;
  postData(
      String firstname,
      lastname,
      email,
      address,
      mobile,
      husband,
      marriedSince,
      abortions,
      twins,
      diabetes,
      allergic_reaction,
      surgery,
      Menstruation,
      Menstruation_date,
      hereditory,
      gynacology,
      no_of_babies_pregnant_with,
      doctor_final_visit) async {
    String url = Admin.edit_client_profile;
    Map body = {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "address": address,
      "mobile": mobile,
      "husband": husband,
      "marriedSince": marriedSince,
      "abortions": abortions,
      "twins": twins,
      "diabetes": diabetes,
      "allergic_reaction": allergic_reaction,
      "surgery": surgery,
      "Menstruation": Menstruation,
      "Menstruation_date": Menstruation_date,
      "hereditory": hereditory,
      "gynacology": gynacology,
      "no_of_babies_pregnant_with": no_of_babies_pregnant_with,
      "doctor_final_visit": doctor_final_visit
    };
    String? token = await getToken();
    if (token != null) {
      var res = await http.patch(
        Uri.parse(url),
        headers: {"Authorization": "Token $token"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:  Text('Profile Updated Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Details not Submitted ,Please try again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AdminDisplay()),
          );
        });
      }
    }
  }

  late String firstname,
      lastname,
      email,
      address,
      mobile,
      husband,
      marriedSince,
      abortions,
      twins,
      diabetes,
      allergic_reaction,
      surgery,
      Menstruation,
      Menstruation_date,
      hereditory,
      gynacology,
      no_of_babies_pregnant_with,
      doctor_final_visit;
  Widget _buildFirstname() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "First Name",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 2,
            maxLength: 15,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                firstname = value;
              });
            },
            controller: _firstnameController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
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
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Last Name",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 2,
            maxLength: 15,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                lastname = value;
              });
            },
            controller: _lastnameController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
                borderRadius:  BorderRadius.all(
                   Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHusband() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Husband Name",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 2,
            maxLength: 15,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                husband = value;
              });
            },
            controller: _husbandController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
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
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Email Address",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 2,
            maxLength: 30,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                email = value;
              });
            },
            controller: _emailController,
            decoration:  const InputDecoration(
              border:  OutlineInputBorder(
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

  Widget _buildAddress() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Location",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 2,
            maxLength: 50,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                address = value;
              });
            },
            controller: _addressController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
                borderRadius:  BorderRadius.all(
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
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Mobile Number",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 2,
            maxLength: 15,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                mobile = value;
              });
            },
            controller: _mobileController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
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

  Widget _buildMarriedSince() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Married Since",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                marriedSince = value;
              });
            },
            controller: _marriedSinceController,
            decoration: const InputDecoration(
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

  Widget _buildAbortions() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Any History of Abortion?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                abortions = value;
              });
            },
            controller: _abortionsController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
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

  Widget _buildTwins() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Any History of Twins in Family?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                twins = value;
              });
            },
            controller: _twinsController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
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

  Widget _buildDiabetes() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Any Family History of Diabetes?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                diabetes = value;
              });
            },
            controller: _diabetesController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
                borderRadius:  BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAllergicReaction() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Any History of Allergic Reaction?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                allergic_reaction = value;
              });
            },
            controller: _allergicreactionController,
            decoration: const InputDecoration(
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

  Widget _buildSurgery() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Any Family History of Surgery?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                surgery = value;
              });
            },
            controller: _surgeryController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
                borderRadius:  BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenstruation() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "How Many Days Menstruation Period Cycle?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                Menstruation = value;
              });
            },
            controller: _MenstruationController,
            decoration: const InputDecoration(
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

  Widget _buildMenstruationDate() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Last Menstruation Date?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                Menstruation_date = value;
              });
            },
            controller: _MenstruationdateController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
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

  Widget _buildhereditory() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Any Hereditory Related Complication?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                hereditory = value;
              });
            },
            controller: _hereditoryController,
            decoration: const InputDecoration(
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

  Widget _buildgynacology() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Any History of Gynacology or Fertility Treatment?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                gynacology = value;
              });
            },
            controller: _gynacologyController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
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

  Widget _buildno_of_babies_pregnant_with() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "How Many Baby are you Pregnant with Currently?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                no_of_babies_pregnant_with = value;
              });
            },
            controller: _no_of_babies_pregnant_withController,
            decoration: const InputDecoration(
              border:  OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.white, width: 3),
                borderRadius:  BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _builddoctor_final_visit() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "When Did You Visit Your Doctor Finally?",
            style: GoogleFonts.poppins(
              color: Colors.lightBlueAccent,
              fontSize: 15,
            ),
          ),
          TextFormField(
            minLines: 2,
            maxLines: 100,
            maxLength: 1500,
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            keyboardType: TextInputType.multiline,
            onChanged: (value) {
              setState(() {
                doctor_final_visit = value;
              });
            },
            controller: _doctor_final_visitController,
            decoration: const InputDecoration(
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
          margin: const EdgeInsets.only(bottom: 20),
          child:ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _firstnameController.text == "" ||
                _lastnameController.text == "" ||
                _emailController.text == "" ||
                _addressController.text == "" ||
                _mobileController.text == "" ||
                _husbandController.text == "" ||
                _marriedSinceController.text == "" ||
                _abortionsController.text == "" ||
                _twinsController.text == "" ||
                _diabetesController.text == "" ||
                _allergicreactionController.text == "" ||
                _surgeryController.text == "" ||
                _MenstruationController.text == "" ||
                _MenstruationdateController.text == "" ||
                _hereditoryController.text == "" ||
                _gynacologyController.text == "" ||
                _no_of_babies_pregnant_withController.text == "" ||
                _doctor_final_visitController.text == ""
                ? null
                : () {
              setState(() {
                isLoading = true;
              });
              postData(
                  _firstnameController.text,
                  _lastnameController.text,
                  _emailController.text,
                  _addressController.text,
                  _mobileController.text,
                  _husbandController.text,
                  _marriedSinceController.text,
                  _abortionsController.text,
                  _twinsController.text,
                  _diabetesController.text,
                  _allergicreactionController.text,
                  _surgeryController.text,
                  _MenstruationController.text,
                  _MenstruationdateController.text,
                  _hereditoryController.text,
                  _gynacologyController.text,
                  _no_of_babies_pregnant_withController.text,
                  _doctor_final_visitController.text);
            },
            child: Text(
              "Update Profile",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void initState() {
    // TODO: implement initState
    fetchSummary();
    super.initState();
  }

  fetchSummary() async {
    String? token = await getToken();
    String url = Admin.client_profile +  '?customer=' + widget.value.toString();
    if (token != null) {
      final response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Token $token"
      });
      if (response.statusCode == 200) {
        _firstnameController.text =
        jsonDecode(response.body)["customer"]["firstname"];
        _lastnameController.text =
        jsonDecode(response.body)["customer"]["lastname"];
        _emailController.text = jsonDecode(response.body)["customer"]["email"];
        _addressController.text =
        jsonDecode(response.body)["details"]["address"];
        _mobileController.text =
        jsonDecode(response.body)["customer"]["mobile"];
        _husbandController.text =
        jsonDecode(response.body)["details"]["husband"];
        _marriedSinceController.text =
        jsonDecode(response.body)["details"]["marriedSince"];
        _abortionsController.text =
        jsonDecode(response.body)["details"]["abortions"];
        _twinsController.text = jsonDecode(response.body)["details"]["twins"];
        _diabetesController.text =
        jsonDecode(response.body)["details"]["diabetes"];
        _allergicreactionController.text =
        jsonDecode(response.body)["details"]["allergic_reaction"];
        _surgeryController.text =
        jsonDecode(response.body)["details"]["surgery"];
        _MenstruationController.text =
        jsonDecode(response.body)["details"]["Menstruation"];
        _MenstruationdateController.text =
        jsonDecode(response.body)["details"]["Menstruation_date"];
        _hereditoryController.text =
        jsonDecode(response.body)["details"]["hereditory"];
        _gynacologyController.text =
        jsonDecode(response.body)["details"]["gynacology"];
        _no_of_babies_pregnant_withController.text =
        jsonDecode(response.body)["details"]["no_of_babies_pregnant_with"];
        _doctor_final_visitController.text =
        jsonDecode(response.body)["details"]["doctor_final_visit"];
      } else {
        throw Exception('Failed to load album');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              image:  DecorationImage(
                image:  AssetImage('assets/appbar.jpeg'),
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
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildFirstname(),
                _buildLastname(),
                _buildHusband(),
                _buildEmail(),
                _buildAddress(),
                _buildMobile(),
                _buildMarriedSince(),
                _buildAbortions(),
                _buildTwins(),
                _buildDiabetes(),
                _buildAllergicReaction(),
                _buildSurgery(),
                _buildMenstruation(),
                _buildMenstruationDate(),
                _buildhereditory(),
                _buildgynacology(),
                _buildno_of_babies_pregnant_with(),
                _builddoctor_final_visit(),
                //  _buildPrescription(),
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