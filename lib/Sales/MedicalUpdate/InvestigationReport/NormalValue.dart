import 'package:admin_dashboard/Sales/AllClients/AllClients.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';

class NormalValue extends StatefulWidget {
  int id;
  String date;
  NormalValue(this.id, this.date);
  @override
  NormalValueState createState() => NormalValueState();
}

class NormalValueState extends State<NormalValue> {
  TextEditingController _hb_valueController = TextEditingController();
  TextEditingController _ict_valueController = TextEditingController();
  TextEditingController _urineRE_valueController = TextEditingController();
  TextEditingController _urineCS_valueController = TextEditingController();
  TextEditingController _vdrl_valueController = TextEditingController();
  TextEditingController _hiv_valueController = TextEditingController();
  TextEditingController _rbs_first_trimester_valueController =
      TextEditingController();
  TextEditingController _ogct_second_trimester_valueController =
      TextEditingController();
  TextEditingController _ogtt_second_trimester_valueController =
      TextEditingController();
  TextEditingController _hcv_valueController = TextEditingController();
  TextEditingController _creatine_valueController = TextEditingController();
  TextEditingController _double_marker_valueController =
      TextEditingController();
  TextEditingController _tft_valueController = TextEditingController();
  TextEditingController _tft_descriptionController = TextEditingController();
  TextEditingController _others_valueController = TextEditingController();
  TextEditingController _criticallityController = TextEditingController();
  TextEditingController _scanController = TextEditingController();
  TextEditingController _scanDescriptionController = TextEditingController();
  bool isLoading = true;
  postData(
      String hb_value,
      ict_value,
      urineRE_value,
      urineCS_value,
      vdrl_value,
      hiv_value,
      rbs_first_trimester_value,
      ogct_second_trimester_value,
      ogtt_second_trimester_value,
      hcv_value,
      creatine_value,
      double_marker_value,
      tft_value,
      tft_description,
      others_value,
      criticallity,
      scan,
      scanDescription,
      date,
      customer) async {
    String url = Sales.investigation_report;
    String selectedDate = widget.date;
    String customerId = widget.id.toString();
    Map body = {
      "hb_value": hb_value,
      "ict_value": ict_value,
      "urineRE_value": urineRE_value,
      "urineCS_value": urineCS_value,
      "vdrl_value": vdrl_value,
      "hiv_value": hiv_value,
      "rbs_first_trimester_value": rbs_first_trimester_value,
      "ogct_second_trimester_value": ogct_second_trimester_value,
      "ogtt_second_trimester_value": ogtt_second_trimester_value,
      "hcv_value": hcv_value,
      "creatine_value": creatine_value,
      "double_marker_value": double_marker_value,
      "tft_value": tft_value,
      "tft_description": tft_description,
      "others_value": others_value,
      "criticallity": criticallity,
      "scan": scan,
      "scanDescription": scanDescription,
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

  late String hb_value,
      ict_value,
      urineRE_value,
      urineCS_value,
      vdrl_value,
      hiv_value,
      rbs_first_trimester_value,
      ogct_second_trimester_value,
      ogtt_second_trimester_value,
      hcv_value,
      creatine_value,
      double_marker_value,
      tft_value,
      tft_description,
      others_value,
      criticallity,
      scan,
      scanDescription;
  Widget _buildHB() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "HB Value",
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
                hb_value = value;
              });
            },
            controller: _hb_valueController,
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
            "ICT Value",
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
                ict_value = value;
              });
            },
            controller: _ict_valueController,
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
            "Urine R/E Value",
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
                urineRE_value = value;
              });
            },
            controller: _urineRE_valueController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  const Radius.circular(10),
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
            "Urine C/S Value",
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
                urineCS_value = value;
              });
            },
            controller: _urineCS_valueController,
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
                vdrl_value = value;
              });
            },
            controller: _vdrl_valueController,
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
            "HIV Value",
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
                hiv_value = value;
              });
            },
            controller: _hiv_valueController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  const Radius.circular(10),
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
                rbs_first_trimester_value = value;
              });
            },
            controller: _rbs_first_trimester_valueController,
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
                ogct_second_trimester_value = value;
              });
            },
            controller: _ogct_second_trimester_valueController,
            decoration: const InputDecoration(
              border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 3),
                borderRadius: BorderRadius.all(
                  const Radius.circular(10),
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
                ogtt_second_trimester_value = value;
              });
            },
            controller: _ogtt_second_trimester_valueController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 3),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
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
                hcv_value = value;
              });
            },
            controller: _hcv_valueController,
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
                creatine_value = value;
              });
            },
            controller: _creatine_valueController,
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
                double_marker_value = value;
              });
            },
            controller: _double_marker_valueController,
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
                tft_value = value;
              });
            },
            controller: _tft_valueController,
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

  Widget _buildTFTDescription() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "TFT Description",
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
                tft_description = value;
              });
            },
            controller: _tft_descriptionController,
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
                others_value = value;
              });
            },
            controller: _others_valueController,
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

  Widget _buildScan() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Scan",
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
                scan = value;
              });
            },
            controller: _scanController,
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

  Widget _buildScanDescription() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Scan Description",
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
                scanDescription = value;
              });
            },
            controller: _scanDescriptionController,
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
          height: 2000,
          width: 5 * (MediaQuery.of(context).size.width / 09),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589), // foreground (text) color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _hb_valueController.text == "" ||
                    _ict_valueController.text == "" ||
                    _urineRE_valueController.text == "" ||
                    _urineCS_valueController.text == "" ||
                    _vdrl_valueController.text == "" ||
                    _hiv_valueController.text == "" ||
                    _rbs_first_trimester_valueController.text == "" ||
                    _ogct_second_trimester_valueController.text == "" ||
                    _ogtt_second_trimester_valueController.text == "" ||
                    _hcv_valueController.text == "" ||
                    _creatine_valueController.text == "" ||
                    _double_marker_valueController.text == "" ||
                    _tft_valueController.text == "" ||
                    _tft_descriptionController.text == "" ||
                    _others_valueController.text == "" ||
                    _criticallityController.text == "" ||
                    _scanController.text == "" ||
                    _scanDescriptionController.text == ""
                ? null
                : () {
                    setState(() {
                      isLoading = true;
                    });
                    postData(
                      _hb_valueController.text,
                      _ict_valueController.text,
                      _urineRE_valueController.text,
                      _urineCS_valueController.text,
                      _vdrl_valueController.text,
                      _hiv_valueController.text,
                      _rbs_first_trimester_valueController.text,
                      _ogct_second_trimester_valueController.text,
                      _ogtt_second_trimester_valueController.text,
                      _hcv_valueController.text,
                      _creatine_valueController.text,
                      _double_marker_valueController.text,
                      _tft_valueController.text,
                      _tft_descriptionController.text,
                      _others_valueController.text,
                      _criticallityController.text,
                      _scanController.text,
                      _scanDescriptionController.text,
                      widget.id.toString(),
                      widget.date,
                    );
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
                _buildTFTDescription(),
                _buildOther(),
                _buildCriticallity(),
                _buildScan(),
                _buildScanDescription(),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffe14589), // foreground (text) color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    postData(
                      _hb_valueController.text,
                      _ict_valueController.text,
                      _urineRE_valueController.text,
                      _urineCS_valueController.text,
                      _vdrl_valueController.text,
                      _hiv_valueController.text,
                      _rbs_first_trimester_valueController.text,
                      _ogct_second_trimester_valueController.text,
                      _ogtt_second_trimester_valueController.text,
                      _hcv_valueController.text,
                      _creatine_valueController.text,
                      _double_marker_valueController.text,
                      _tft_valueController.text,
                      _tft_descriptionController.text,
                      _others_valueController.text,
                      _criticallityController.text,
                      _scanController.text,
                      _scanDescriptionController.text,
                      widget.id.toString(),
                      widget.date,
                    );
                  },
                  child: Text(
                    "Submit",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
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
