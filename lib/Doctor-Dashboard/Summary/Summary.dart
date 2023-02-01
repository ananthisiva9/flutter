import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shebirth/Login/Login.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';

class Summary extends StatefulWidget {
  final int? value;
  Summary({Key? key, this.value}) : super(key: key);
  @override
  SummaryState createState() => SummaryState();
}

class SummaryState extends State<Summary> {
  TextEditingController _summaryController = TextEditingController();
  String sum="0";
  bool isLoading = true;
  postData(String summary) async {
    int appointmentId = widget.value as int;
    String url = doctorApi.summary_post;
    Map body = {"appointmentID": appointmentId.toString(), "summary": summary};
    String? token = await getToken();
    if (token != null) {
      var res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Your Summary Submitted Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
          Text('Summary not Submitted ,Please Write your Summary again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        });
      }
    }
  }

  late String summary;
  Widget _buildSummary() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: TextFormField(
        minLines: 2,
        maxLines: 100,
        maxLength: 1500,
        style: TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.multiline,
        onChanged: (value) {
          setState(() {
            summary = value;
          });
        },
        controller: _summaryController,
        decoration: InputDecoration(
          hintText: 'Summary',
          hintStyle: TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
         border: OutlineInputBorder(
             borderSide: BorderSide(color: Colors.white,width: 3),
           borderRadius: BorderRadius.all(Radius.circular(10),
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
          height: 1.4 * (MediaQuery
              .of(context)
              .size
              .height / 25),
          width: 5 * (MediaQuery
              .of(context)
              .size
              .width / 09),
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
    style: ElevatedButton.styleFrom(
    primary: Color(0xffe14589) ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
    ),
    ),
            onPressed: _summaryController.text == "" + widget.value.toString()
                ? null
                : () {
              setState(() {
                isLoading = true;
              });
              postData(
                _summaryController.text,
              );
            },
            child: Text(
              "Submit Summary",
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
    fetchSummary();
    super.initState();
  }
  fetchSummary() async {
    String? token = await getToken();
    String url = doctorApi.summary_get + '?appointmentID=' + widget.value.toString();
    if (token != null) {
      final response =
      await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': "Token $token"});
      if (response.statusCode == 200) {
        _summaryController.text = jsonDecode(response.body)["summary"];
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
              _buildSummary(),
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
