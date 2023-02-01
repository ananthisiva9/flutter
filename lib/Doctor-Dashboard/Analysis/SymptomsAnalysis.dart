import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shebirth/Doctor-Dashboard/DisplayScreen/DisplayScreen_view.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/widgets/loading_icon.dart';

class SymptomsAnalysis extends StatefulWidget {
  int id;
  String formated_date;
  SymptomsAnalysis(this.id, this.formated_date);
  @override
  State<SymptomsAnalysis> createState() => _SymptomsAnalysisState();
}

class _SymptomsAnalysisState extends State<SymptomsAnalysis> {
  @override
  var stillbirth, //1
      covid, //2
      YeastInfections, //3
      Anemia, //4
      cholestatsis, //6
      RHIncampatability, //7
      IUGR, //8
      PIH, //9
      diabetes, //10
      polyhydramnios, //11
      oligohydramnios, //12
      preterm, //13
      placentaabruption, //14
      placentapreveria, //15
      uti, //16
      hyperemesisgravidarum, //17
      earlyabortion, //18
      HELLP; //19

  late String data;
  bool isLoading = true;

  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String? token = await getToken();
    String url = doctorApi.symptoms_analysis +
        '?date=${widget.formated_date}&customer=${widget.id}';
    if (token != null) {
      var response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
      );
      if (response.statusCode == 200) {
        data = response.body;
        setState(() {
          isLoading = false;
          stillbirth = jsonDecode(data)['still_birth']; //1
          covid = jsonDecode(data)['covid']; //2
          YeastInfections = jsonDecode(data)['Yeast_Infections']; //3
          Anemia = jsonDecode(data)['Anemia']; //4
          cholestatsis = jsonDecode(data)['cholestatsis']; //6
          RHIncampatability = jsonDecode(data)['RH_Incampatability']; //7
          IUGR = jsonDecode(data)['IUGR']; //8
          PIH = jsonDecode(data)['PIH']; //9
          diabetes = jsonDecode(data)['diabetes']; //10
          polyhydramnios = jsonDecode(data)['polyhydramnios']; //11
          oligohydramnios = jsonDecode(data)['oligohydramnios']; //12
          preterm = jsonDecode(data)['preterm']; //13
          placentaabruption = jsonDecode(data)['placenta_abruption']; //14
          placentapreveria = jsonDecode(data)['placenta_preveria']; //15
          uti = jsonDecode(data)['uti']; //16
          hyperemesisgravidarum =
              jsonDecode(data)['hyperemesis_gravidarum']; //17
          earlyabortion = jsonDecode(data)['early_abortion']; //18
          HELLP = jsonDecode(data)['HELLP']; //19
        });
      }
    } else {
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

  Widget _buildAnemia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Anemia ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        Anemia == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                Anemia.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //1

  Widget _buildHELLP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'HELLP ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        HELLP == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                HELLP.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //2

  Widget _buildIUGR() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'IUGR  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        IUGR == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                IUGR.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //3

  Widget _buildPIH() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'PIH  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        PIH == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                PIH.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //4

  Widget _buildYeastInfections() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Yeast Infections ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        YeastInfections == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                YeastInfections.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //5

  Widget _buildCholestatsis() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Cholestatsis  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        cholestatsis == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                cholestatsis.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //6

  Widget _buildDiabetes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Diabetes  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        diabetes == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                diabetes.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //7

  Widget _buildEarlyAbortion() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Early Abortion  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        earlyabortion == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                earlyabortion.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //8

  Widget _buildHyperemesisgravidarum() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Hyperemesis Gravidarum  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        hyperemesisgravidarum == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                hyperemesisgravidarum.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //9

  Widget _buildOligohydramnios() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Oligohydramnios  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        oligohydramnios == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                oligohydramnios.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //10

  Widget _buildPlacentaabruption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Placenta Abortion  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        placentaabruption == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                placentaabruption.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //11

  Widget _buildPlacentapreveria() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Placenta Preveria ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        placentapreveria == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                placentapreveria.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //12

  Widget _buildPolyhydramnios() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Polyhydramnios  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        polyhydramnios == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                polyhydramnios.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //13

  Widget _buildPreterm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Preterm  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        preterm == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                preterm.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //14

  Widget _buildStillBirth() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'Still Birth ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        stillbirth == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                stillbirth.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //15

  Widget _buildUTI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            'UTI  ',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
        ),
        uti == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                uti.toString() + " " + "%",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ),
              ),
      ],
    );
  } //16

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
              'Critical Analysis',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Based on Daily Tracker',
                  style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                      child: isLoading
                          ? Center(child: LoadingIcon())
                          : _buildContainer()),
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

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width * 0.7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildAnemia(),
                _buildCholestatsis(),
                _buildDiabetes(),
                _buildEarlyAbortion(),
                _buildHELLP(),
                _buildHyperemesisgravidarum(),
                _buildIUGR(),
                _buildOligohydramnios(),
                _buildPIH(),
                _buildPlacentaabruption(),
                _buildPlacentapreveria(),
                _buildPolyhydramnios(),
                _buildPreterm(),
                _buildStillBirth(),
                _buildUTI(),
                _buildYeastInfections(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
