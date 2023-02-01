import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LearningModule extends StatefulWidget {
  @override
  LearningModuleState createState() => LearningModuleState();
}

class LearningModuleState extends State<LearningModule> {
  TextEditingController _urlController = TextEditingController();
  TextEditingController _faqController = TextEditingController();
  TextEditingController _relatedPostController = TextEditingController();
  bool isLoading = true;
  postData(String module, String stage, String url, String faq,
      String relatedPost) async {
    String url = Admin.add_vedio;
    Map body = {
      "tracker": module,
      "stage": stage,
      "url": url,
      "faq": faq,
      "relatedPost": relatedPost
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
          content: Text('Learning Module Updated Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something Went Wrong ,Please Try again'),
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

  late String module, stage, url, faq, relatedPost;
  final items = [
    'Stage1',
    'Stage2',
    'Stage3',
    'Stage4',
    'Stage5',
    'Stage6',
    'Stage7',
    'Stage8',
    'Stage9',
    'Stage10'
  ];
  String? selectedItems = 'Stage1';
  final Tracker = [
    'Diet',
    'Skill Set',
    'Stay Fit',
    'Relaxation',
    'Lactation',
    'Delivery Process',
    'Natural Coping',
    'New born Care',
    'Planning Birth'
  ];
  String? selectedTracker = 'Diet';
  Widget _buildPeriod() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "Select Week",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 110.0),
            child: DropdownButton<String>(
              value: selectedItems,
              elevation: 5,
              underline: Container(
                color: Colors.grey.withOpacity(0.1),
              ),
              hint: Text(
                'Weeks',
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

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Module Name",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 100.0),
            child: DropdownButton<String>(
              value: selectedTracker,
              elevation: 5,
              underline: Container(
                color: Colors.grey.withOpacity(0.1),
              ),
              hint: Text(
                'Tracker Name',
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              ),
              iconDisabledColor: Colors.white,
              iconEnabledColor: Colors.white,
              iconSize: 25,
              dropdownColor: Colors.lightBlueAccent,
              items: Tracker
                  .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 12))))
                  .toList(),
              onChanged: (item) => setState(() => selectedTracker),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUrl() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Module Url",
            style: GoogleFonts.poppins(
              color: Colors.white,
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

  Widget _buildFQA() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Frequently Asked Question",
            style: GoogleFonts.poppins(
              color: Colors.white,
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
                faq = value;
              });
            },
            controller: _faqController,
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

  Widget _buildRelatedPost() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Related Post",
            style: GoogleFonts.poppins(
              color: Colors.white,
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
                relatedPost = value;
              });
            },
            controller: _relatedPostController,
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
                  selectedTracker.toString(),
                  selectedItems.toString(),
                  _urlController.text,
                  _faqController.text,
                  _relatedPostController.text);
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
                _buildName(),
                const Divider(
                  height: .3,
                ),
                _buildPeriod(),
                const Divider(
                  height: .3,
                ),
                _buildUrl(),
                const Divider(
                  height: .3,
                ),
                _buildRelatedPost(),
                const Divider(
                  height: .3,
                ),
                _buildFQA(),
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
