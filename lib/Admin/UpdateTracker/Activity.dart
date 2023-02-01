import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';

class UpdateActivity extends StatefulWidget {
  @override
  UpdateActivityState createState() => UpdateActivityState();
}

class UpdateActivityState extends State<UpdateActivity> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _urlController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  bool isLoading = true;
  postData(String tracker, String stage, String subModuleName, String url,
      String description) async {
    String url = Admin.update_tracker_post;
    Map body = {
      "tracker": tracker,
      "stage": stage,
      "subModuleName": subModuleName,
      "url": url,
      "description": description
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
          content: Text('Activity Submitted Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Activity not Submitted ,Please Try again'),
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

  late String tracker, period, subModuleName, url, description;
  final items = [
    'stage1',
    'stage2',
    'stage3',
    'stage4',
    'stage5',
    'stage6',
    'stage7',
    'stage8',
    'stage9',
    'stage10'
  ];
  String? selectedItems = 'stage1';
  Widget _buildTracker() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Tracker",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 140.0),
            child: Text(
              "Activity",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriod() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Select Period",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: DropdownButton<String>(
              value: selectedItems,
              elevation: 5,
              underline: Container(
                color: Colors.grey.withOpacity(0.1),
              ),
              hint: Text(
                'AccountStatus',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              ),
              iconDisabledColor: Colors.white,
              iconEnabledColor: Colors.white,
              iconSize: 25,
              dropdownColor: Colors.lightBlueAccent,
              items: items
                  .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 12))))
                  .toList(),
              onChanged: (item) => setState(() => selectedItems),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubName() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sub Activity Name",
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
                subModuleName = value;
              });
            },
            controller: _nameController,
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

  Widget _buildSubUrl() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sub Activity Url",
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
                url = value;
              });
            },
            controller: _urlController,
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

  Widget _buildDescription() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sub Activity Description",
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
                description = value;
              });
            },
            controller: _descriptionController,
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
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              postData(
                  "Activity",
                  selectedItems.toString(),
                  _nameController.text,
                  _urlController.text,
                  _descriptionController.text);
            },
            child: Text(
              "Submit",
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
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildTracker(),
                _buildPeriod(),
                _buildSubName(),
                _buildSubUrl(),
                _buildDescription(),
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
