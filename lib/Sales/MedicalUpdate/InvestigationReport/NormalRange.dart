import 'package:admin_dashboard/Sales/AllClients/AllClients.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';

class NormalRange extends StatefulWidget {
  int id;
  String date;
  NormalRange(this.id, this.date);
  @override
  NormalRangeState createState() => NormalRangeState();
}

class NormalRangeState extends State<NormalRange> {
  TextEditingController _hb_normalController = TextEditingController();
  TextEditingController _ict_normalController = TextEditingController();
  TextEditingController _urineRE_normalController = TextEditingController();
  TextEditingController _urineCS_normalController = TextEditingController();
  TextEditingController _vdrl_normalController = TextEditingController();
  TextEditingController _hiv_normalController = TextEditingController();
  TextEditingController _rbs_first_trimester_normalController =
  TextEditingController();
  TextEditingController _ogct_second_trimester_normalController =
  TextEditingController();
  TextEditingController _ogtt_second_trimester_normalController =
  TextEditingController();
  TextEditingController _hcv_normalController = TextEditingController();
  TextEditingController _creatine_normalController = TextEditingController();
  TextEditingController _double_marker_normalController =
  TextEditingController();
  TextEditingController _tft_normalController = TextEditingController();
  TextEditingController _others_normalController = TextEditingController();
  TextEditingController _criticallityController = TextEditingController();
  bool isLoading = true;
  postData(
      String hb_normal,
      ict_normal,
      urineRE_normal,
      urineCS_normal,
      vdrl_normal,
      hiv_normal,
      rbs_first_trimester_normal,
      ogct_second_trimester_normal,
      ogtt_second_trimester_normal,
      hcv_normal,
      creatine_normal,
      double_marker_normal,
      tft_normal,
      others_normal,
      criticallity,
      date,
      customer) async {
    String url = Sales.investigation_report;
    String selectedDate = widget.date;
    String customerId = widget.id.toString();
    Map body = {
      "hb_normal": hb_normal,
      "ict_normal": ict_normal,
      "urineRE_normal": urineRE_normal,
      "urineCS_normal": urineCS_normal,
      "vdrl_normal": vdrl_normal,
      "hiv_normal": hiv_normal,
      "rbs_first_trimester_normal": rbs_first_trimester_normal,
      "ogct_second_trimester_normal": ogct_second_trimester_normal,
      "ogtt_second_trimester_normal": ogtt_second_trimester_normal,
      "hcv_normal": hcv_normal,
      "creatine_normal": creatine_normal,
      "double_marker_normal": double_marker_normal,
      "tft_normal": tft_normal,
      "others_normal": others_normal,
      "criticallity": criticallity,
      "customer": customerId,
      "date": selectedDate
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
          content: Text('Your Profile Updated Successfully'),
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
            MaterialPageRoute(builder: (context) => AllClient()),
          );
        });
      }
    }
  }

  late String hb_normal,
      ict_normal,
      urineRE_normal,
      urineCS_normal,
      vdrl_normal,
      hiv_normal,
      rbs_first_trimester_normal,
      ogct_second_trimester_normal,
      ogtt_second_trimester_normal,
      hcv_normal,
      creatine_normal,
      double_marker_normal,
      tft_normal,
      others_normal,
      criticallity;
  Widget _buildHB() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "HB",
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
                hb_normal = value;
              });
            },
            controller: _hb_normalController,
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

  Widget _buildCT() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "CT",
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
                ict_normal = value;
              });
            },
            controller: _ict_normalController,
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

  Widget _buildUrineRE() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Urine R/E",
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
                urineRE_normal = value;
              });
            },
            controller: _urineRE_normalController,
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

  Widget _buildUrineCS() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Urine C/S",
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
                urineCS_normal = value;
              });
            },
            controller: _urineCS_normalController,
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

  Widget _buildVDRL() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "VDRL",
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
                vdrl_normal = value;
              });
            },
            controller: _vdrl_normalController,
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

  Widget _buildHIV() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "HIV",
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
                hiv_normal = value;
              });
            },
            controller: _hiv_normalController,
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

  Widget _buildRBS() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "RBS First Trimester",
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
                rbs_first_trimester_normal = value;
              });
            },
            controller: _rbs_first_trimester_normalController,
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

  Widget _buildOGCT() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "OGCT Second Trimester",
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
                ogct_second_trimester_normal = value;
              });
            },
            controller: _ogct_second_trimester_normalController,
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

  Widget _buildOGTT() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "OGTT Second Trimester",
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
                ogtt_second_trimester_normal = value;
              });
            },
            controller: _ogtt_second_trimester_normalController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
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

  Widget _buildHCV() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "HCV",
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
                hcv_normal = value;
              });
            },
            controller: _hcv_normalController,
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

  Widget _buildCreatine() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Creatine Value",
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
                creatine_normal = value;
              });
            },
            controller: _creatine_normalController,
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

  Widget _buildDoubleMarker() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Double Marker",
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
                double_marker_normal = value;
              });
            },
            controller: _double_marker_normalController,
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

  Widget _buildTFT() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "TFT",
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
                tft_normal = value;
              });
            },
            controller: _tft_normalController,
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

  Widget _buildOther() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Other",
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
                others_normal = value;
              });
            },
            controller: _others_normalController,
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

  Widget _buildCriticallity() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Criticality",
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
                criticallity = value;
              });
            },
            controller: _criticallityController,
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
            onPressed: _hb_normalController.text == "" ||
                _ict_normalController.text == "" ||
                _urineRE_normalController.text == "" ||
                _urineCS_normalController.text == "" ||
                _vdrl_normalController.text == "" ||
                _hiv_normalController.text == "" ||
                _rbs_first_trimester_normalController.text == "" ||
                _ogct_second_trimester_normalController.text == "" ||
                _ogtt_second_trimester_normalController.text == "" ||
                _hcv_normalController.text == "" ||
                _creatine_normalController.text == "" ||
                _double_marker_normalController.text == "" ||
                _tft_normalController.text == "" ||
                _others_normalController.text == "" ||
                _criticallityController.text == ""
                ? null
                : () {
              setState(() {
                isLoading = true;
              });
              postData(
                _hb_normalController.text,
                _ict_normalController.text,
                _urineRE_normalController.text,
                _urineCS_normalController.text,
                _vdrl_normalController.text,
                _hiv_normalController.text,
                _rbs_first_trimester_normalController.text,
                _ogct_second_trimester_normalController.text,
                _ogtt_second_trimester_normalController.text,
                _hcv_normalController.text,
                _creatine_normalController.text,
                _double_marker_normalController.text,
                _tft_normalController.text,
                _others_normalController.text,
                _criticallityController.text,
                widget.id.toString(),
                widget.date,);
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
                _buildHB(),
                _buildCT(),
                _buildUrineRE(),
                _buildUrineCS(),
                _buildVDRL(),
                _buildHIV(),
                _buildRBS(),
                _buildOGCT(),
                _buildOGTT(),
                _buildHCV(),
                _buildCreatine(),
                _buildDoubleMarker(),
                _buildTFT(),
                _buildOther(),
                _buildCriticallity(),
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
