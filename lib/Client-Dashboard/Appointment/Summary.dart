import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/widgets/loading_icon.dart';

class Summary extends StatefulWidget {
  final String value;
  const Summary({Key? key, required this.value}) : super(key: key);
  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  var summary;
  late String data;
  bool isLoading = true;

  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = true;
      });
    });
    super.initState();
    getData();
  }

  getData() async {
    String? token = await getToken();
    String url = clientApi.summary + "?appointmentID=" + widget.value;
    if (token != null) {
      var response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
      );
      if (response.statusCode == 200) {
        data = response.body;
        print(widget.value);
        print(data);
        setState(() {
          isLoading = false;
          data = response.body;
          summary = jsonDecode(data)['summary'];
        });
      }
    } else {
      Center(
        child: LoadingIcon(),
      );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User Detail not Found'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Display()),
        );
      });
    }
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
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(child: _buildContainer()),
                ),
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

  Widget _buildName() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          child: Text(
            summary == "" ? "Summary Not available" : summary.toString(),
            maxLines: 100,
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ]),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Summary',
                    style: GoogleFonts.poppins(
                        color: Colors.lightBlueAccent, fontSize: 18,fontWeight: FontWeight.bold),
                  ),
                  _buildName(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
