import 'dart:convert';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';

class MedicalAnalysis extends StatefulWidget {
  final int id;
  MedicalAnalysis(this.id);
  @override
  State<MedicalAnalysis> createState() => _MedicalAnalysisState();
}

class _MedicalAnalysisState extends State<MedicalAnalysis> {
  @override
  var Anemia,
      HELLP,
      IUGR,
      PIH,
      Yeast_Infections,
      cholestatsis,
      diabetes,
      early_abortion,
      hyperemesis_gravidarum,
      oligohydramnios,
      placenta_abruption,
      placenta_preveria,
      polyhydramnios,
      preterm,
      still_birth,
      uti;
  late String data;
  bool isLoading = true;
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String? token = await getToken();
    String url = Sales.medical_analysis + '?customer=${widget.id}';
    if (token != null) {
      var response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Token ${token}"},
      );
      if (response.statusCode == 200) {
        data = response.body;
        setState(() {
          isLoading = false;
          Anemia = jsonDecode(data)['Anemia']; //1
          HELLP = jsonDecode(data)['HELP']; //2
          IUGR = jsonDecode(data)['IUGR']; //3
          PIH = jsonDecode(data)['PIH']; //4
          Yeast_Infections = jsonDecode(data)['Yeast_Infections']; //5
          cholestatsis = jsonDecode(data)['cholestatsis']; //6
          diabetes = jsonDecode(data)['diabetes']; //7
          early_abortion = jsonDecode(data)['early_abortion']; //8
          hyperemesis_gravidarum =
              jsonDecode(data)['hyperemesis_gravidarum']; //9
          oligohydramnios = jsonDecode(data)['oligohydramnios']; //10
          placenta_abruption = jsonDecode(data)['placenta_abruption']; //11
          placenta_preveria = jsonDecode(data)['placenta_preveria']; //12
          polyhydramnios = jsonDecode(data)['polyhydramnios']; //13
          preterm = jsonDecode(data)['preterm']; //14
          still_birth = jsonDecode(data)['still_birth']; //15
          uti = jsonDecode(data)['uti']; //16
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
          MaterialPageRoute(builder: (context) => SalesDisplay()),
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
        Yeast_Infections == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                Yeast_Infections.toString() + " " + "%",
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
        early_abortion == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                early_abortion.toString() + " " + "%",
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
        hyperemesis_gravidarum == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                hyperemesis_gravidarum.toString() + " " + "%",
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
        placenta_abruption == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                placenta_abruption.toString() + " " + "%",
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
        placenta_preveria == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                placenta_preveria.toString() + " " + "%",
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
        still_birth == null
            ? Text("0 %",
                style: GoogleFonts.poppins(
                  color: Colors.lightBlueAccent,
                  fontSize: 15,
                ))
            : Text(
                still_birth.toString() + " " + "%",
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
                  'Based on Lifestyle and History Of the Patient',
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
