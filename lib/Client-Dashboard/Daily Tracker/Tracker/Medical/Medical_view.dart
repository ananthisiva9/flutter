import 'dart:ui';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Medical_controller.dart';

class Medical extends StatefulWidget {
  @override
  _MedicalState createState() => _MedicalState();
}

class _MedicalState extends State<Medical> {
  DateTime _date = DateTime.now();
  DateTime appointmentDate = DateTime.now();
  String? appointmentDateString;
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
        appointmentDateString = null;
        controller.getMedical(context: context, date: _datepicker);
        print(
          _date.toString(),
        );
      });
    }
  }

  Future<Null> _selectAppointmentDate(
      BuildContext context, MedicalController controller) async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: appointmentDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (_datepicker != null && _datepicker != appointmentDate) {
      setState(() {
        appointmentDate = _datepicker;
        appointmentDateString = Global.getSelectedDate(appointmentDate);
        print(
          appointmentDate.toString(),
        );
      });
    }
  }

  Widget _buildDate(BuildContext context, MedicalController controller) {
    return Row(
      children: <Widget>[
        TextButton(
            onPressed: () {
              // setState(() {
              _selectDate(context, controller);
              // });
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 15,
            )),
        Text(
          _date.day.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.month.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.year.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        TextButton(
            onPressed: () {
              // setState(() {
              _selectDate(context, controller);
              // });
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            )),
      ],
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Hi , SuperMom',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MedicalController(context, DateTime.now()),
        child:
            Consumer<MedicalController>(builder: (context, controller, child) {
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
                  actions: [
                    GestureDetector(
                      child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: IconButton(
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientDisplay(),
                                ),
                              );
                            },
                          )),
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
                  controller.state == StateEnum.loading
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.topCenter,
                          child: LoadingIcon(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            _buildName(),
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Image(
                                alignment: Alignment.bottomRight,
                                image: AssetImage('assets/Motherhood-bro.png'),
                              ),
                            ),
                            _buildContainer(controller, context),
                          ],
                        )
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildContainer(MedicalController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.72,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                        height: 50,
                      ),
                      Expanded(
                        child: Text(
                          "Medical Tracker",
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      _buildDate(context, controller),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildAppointmentDate(controller),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildQuestionAskedDoctor(controller),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Upload Scan Report",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildUploadScan(controller),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Upload Blood Report",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildUploadBlood(controller),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Upload Antenatal Report",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildAntenatalChart(controller),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Bp",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildUploadBp(controller),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Weight",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildUploadWeight(controller),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: _buildSubmitBtn(
                        controller: controller, context: context, date: _date),
                  ),
                  SizedBox(
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentDate(MedicalController controller) {
    return Container(
      height: 125,
      alignment: Alignment.center,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Next Appointment with Doctor",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextButton(
                            onPressed: () {
                              setState(() {
                                _selectAppointmentDate(context, controller);
                              });
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 15,
                            )),
                      Text(
                        appointmentDateString != null
                            ? appointmentDateString!
                            : (controller.medicalModel != null &&
                                    controller.medicalModel!.appointmentDate !=
                                        null)
                                ? controller.medicalModel!.appointmentDate!
                                    .toString()
                                    .capitalize()
                                : "Select Date",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () {
                            setState(() {
                              _selectAppointmentDate(context, controller);
                            });
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 15,
                          )),
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

  Widget _buildQuestionAskedDoctor(MedicalController controller) {
    if (controller.questionController.text.isEmpty) {
      if (controller.medicalModel != null &&
          controller.medicalModel!.question != null) {
        controller.questionController.text =
            controller.medicalModel!.question!.toString().capitalize();
      }
    }

    return Container(
      height: 125,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Question Asked to Doctor",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextField(
                    controller: controller.questionController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: 'Add Your Notes',
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Avenir'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadScan(MedicalController controller) {
    return Container(
      height: 125,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  controller.scanReportPath != null
                      ? Text(
                          controller.scanReportPath.toString().capitalize(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : (controller.medicalModel != null &&
                              controller.medicalModel!.ultraSound != null)
                          ? Text(
                              controller.medicalModel!.ultraSound!
                                  .toString()
                                  .capitalize(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      final file = result.files.first;
                      controller.scanReportPath = file.path;
                      setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xffe14589),
                      ),
                    ),
                    child: Text(
                      'Select a File',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBlood(MedicalController controller) {
    return Container(
      height: 125,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  controller.bloodReportPath != null
                      ? Text(
                          controller.bloodReportPath.toString().capitalize(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : (controller.medicalModel != null &&
                              controller.medicalModel!.bloodReport != null)
                          ? Text(
                              controller.medicalModel!.bloodReport!
                                  .toString()
                                  .capitalize(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      final file = result.files.first;
                      controller.bloodReportPath = file.path;
                      setState(() {});
                      // openFile(file);
                      // print('Name: ${file.name}');
                      // print('Name: ${file.bytes}');
                      // print('Name: ${file.size}');
                      // print('Name: ${file.extension}');
                      // print('Name: ${file.path}');
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xffe14589),
                      ),
                    ),
                    child: Text(
                      'Select a File',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAntenatalChart(MedicalController controller) {
    return Container(
      height: 125,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  controller.antenatalReportPath != null
                      ? Text(
                          controller.antenatalReportPath
                              .toString()
                              .capitalize(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : (controller.medicalModel != null &&
                              controller.medicalModel!.antenatalChart != null)
                          ? Text(
                              controller.medicalModel!.antenatalChart!
                                  .toString()
                                  .capitalize(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )
                          : SizedBox.shrink(),
                  ElevatedButton(
                    onPressed: () async {
                      final result = await FilePicker.platform.pickFiles();
                      if (result == null) return;
                      final file = result.files.first;
                      controller.antenatalReportPath = file.path;
                      print(controller.antenatalReportPath);
                      setState(() {});
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xffe14589),
                      ),
                    ),
                    child: Text(
                      'Select a File',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadBp(MedicalController controller) {
    if (controller.bpController.text.isEmpty) {
      if (controller.medicalModel != null &&
          controller.medicalModel!.bp != null) {
        controller.bpController.text =
            controller.medicalModel!.bp!.toString().capitalize();
      }
    }
    return Container(
      height: 125,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: controller.bpController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Today's BP",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Avenir'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadWeight(MedicalController controller) {
    if (controller.weightController.text.isEmpty) {
      if (controller.medicalModel != null &&
          controller.medicalModel!.weight != null) {
        controller.weightController.text =
            controller.medicalModel!.weight!.toString().capitalize();
      }
    }
    return Container(
      height: 125,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 100,
        width: 300,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: controller.weightController,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Today's Weight",
                      hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontFamily: 'Avenir'),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitBtn({
    required MedicalController controller,
    // TextEditingController? question,
    required BuildContext context,
    required DateTime date,
    // TextEditingController? bpController,
    // TextEditingController? weightController,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 50,
          width: 150,
          margin: EdgeInsets.only(bottom: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) ,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),// foreground (text) color
            ),
            onPressed: () async {
              await controller.addNewMedical(
                  date: date,
                  appoinmentDate: appointmentDate,
                  question: controller.questionController.text.isEmpty
                      ? null
                      : controller.questionController.text,
                  bp: controller.bpController.text.isEmpty
                      ? null
                      : controller.bpController.text,
                  weight: controller.weightController.text.isEmpty
                      ? null
                      : controller.weightController.text,
                  context: context);
              if (controller.state == StateEnum.success) {
                if (controller.questionController.text.isNotEmpty) {
                  controller.questionController.text = '';
                }
                if (controller.bpController.text.isNotEmpty) {
                  controller.bpController.text = '';
                }
                if (controller.weightController.text.isNotEmpty) {
                  controller.weightController.text = '';
                }
              }
            },
            child: Text(
              "Submit",
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

  void openFile(PlatformFile file) {
    OpenFile.open(file.path!);
  }
}
