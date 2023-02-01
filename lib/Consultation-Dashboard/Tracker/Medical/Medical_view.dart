import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'medical_controller.dart';
import 'medical_model.dart';

class Medical extends StatefulWidget {
  int id;
  Medical(this.id);
  @override
  _MedicalState createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, MedicalController controller) async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (_datepicker != null && _datepicker != _date) {
      setState(() {
        _date = _datepicker;
        controller.changeDate(_date);
        controller.fetchAllMedicalData();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(MedicalController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: TextButton(
            onPressed: () {
              setState(() {
                _selectDate(context, controller);
              });
            },
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: 'Select Date:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ),
        ),
        Text(
          _date.day.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.month.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.year.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MedicalController(
            context: context,
            customerid: widget.id.toString(),
            selectedDate: Global.getSelectedDate(_date)),
        child:
        Consumer<MedicalController>(builder: (context, controller, child) {
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
                  controller.state == StateEnum.loading
                      ? Container(
                    height: double.infinity,
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Center(child: LoadingIcon()),
                  )
                      : controller.state == StateEnum.success
                      ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildDate(controller),
                      _buildContainer(controller.model),
                    ],
                  )
                      : Center(
                    child: ErrorRefreshIcon(onPressed: () {
                      controller.fetchAllMedicalData();
                    }),
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildContainer(MedicalModel? model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  _buildHB(model!.investigationData),
                  _buildHBNormal(model.investigationData),
                  _buildICT(model.investigationData),
                  _buildICTNormal(model.investigationData),
                  _buildUrineRE(model.investigationData),
                  _buildUrineRENormal(model.investigationData),
                  _buildUrineCS(model.investigationData),
                  _buildUrineCSNormal(model.investigationData),
                  _buildVDRL(model.investigationData),
                  _buildVDRLNormal(model.investigationData),
                  _buildHIV(model.investigationData),
                  _buildHIVNormal(model.investigationData),
                  _buildRBS(model.investigationData),
                  _buildRBSNormal(model.investigationData),
                  _buildOGCT2(model.investigationData),
                  _buildOGCTPN(model.investigationData),
                  _buildTFT(model.investigationData),
                  _buildOthers(model.investigationData),
                  SizedBox(
                    height: 250,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildHB(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "HB",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.hbValue == null
                ? "Not available"
                : data.hbValue.toString(),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHBNormal(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "HB Normal",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.hbNormal == null
                ? "Not available"
                : data.hbNormal.toString(),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildICT(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "ICT",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.ictValue == null
                ? "Not available"
                : data.ictValue.toString(),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildICTNormal(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "ICT Normal",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.ictNormal == null
                ? "Not available"
                : data.ictNormal.toString(),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUrineRE(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Urine R/E",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.urineREValue == null
                ? "Not available"
                : data.urineREValue!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUrineRENormal(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Urine R/E Normal",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.urineRENormal == null
                ? "Not available"
                : data.urineRENormal!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUrineCS(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Urine C/S",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.urineCSValue == null
                ? "Not available"
                : data.urineCSValue!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUrineCSNormal(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Urine C/S Normal",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.urineCSNormal == null
                ? "Not available"
                : data.urineCSNormal!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVDRL(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "VDRL",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.vdrlValue == null
                ? "Not available"
                : data.vdrlValue!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
  return Container(
    height: 50,
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: 100,
      width: 425,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Vdrl",
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Text(
                      data == null
                          ? "Not available "
                          : data.vdrlValue == null
                          ? "Not available"
                          : data.vdrlValue!,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildVDRLNormal(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "VDRL Normal",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.vdrlNormal == null
                ? "Not available"
                : data.vdrlNormal!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHIV(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "HIV",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.hivValue == null
                ? "Not available"
                : data.hivValue!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHIVNormal(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "HIV Normal",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.hivNormal == null
                ? "Not available"
                : data.hivNormal!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRBS(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "RBS First Trimester",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child:  Text(
            data == null
                ? "Not available "
                : data.rbsFirstTrimesterValue == null
                ? "Not available"
                : data.rbsFirstTrimesterValue!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRBSNormal(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "RBS First Trimester Normal",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.rbsFirstTrimesterNormal == null
                ? "Not available"
                : data.rbsFirstTrimesterNormal!,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOGCT2(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "OGCT 2nd Trimester",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child:  Text(
            data == null
                ? "Not available "
                : data.ogctSecondTrimesterValue == null
                ? "Not available"
                : data.ogctSecondTrimesterValue! +
                (data.ogctSecondTrimesterNormal == null
                    ? ""
                    : " (Normal : " +
                    data.ogctSecondTrimesterNormal!),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOGCTPN(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "OGCT +/- FBS-PPBs",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child:  Text(
            data == null
                ? "Not available "
                : data.ogttSecondTrimesterValue == null
                ? "Not available"
                : data.ogttSecondTrimesterValue! +
                (data.ogttSecondTrimesterNormal == null
                    ? ""
                    : " (Normal : " +
                    data.ogttSecondTrimesterNormal!),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildTFT(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "TFT Value",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child:  Text(
            data == null
                ? "Not available "
                : data.tftValue == null
                ? "Not available"
                : data.tftValue! +
                (data.tftValue == null
                    ? ""
                    : " (Normal : " + data.tftValue!),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildOthers(InvestigationData? data) {
  return Padding(
    padding: const EdgeInsets.all(10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          "Others",
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: Colors.white,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 100.0),
          child: Text(
            data == null
                ? "Not available "
                : data.othersValue == null
                ? "Not available"
                : data.othersValue! +
                (data.othersValue == null
                    ? ""
                    : " (Normal : " + data.othersValue!),
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
