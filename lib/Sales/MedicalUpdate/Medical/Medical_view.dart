import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../../MedicalUpdate/Medical/Medical_controller.dart';

class MedicalDetail extends StatefulWidget {
  int id;
  MedicalDetail(this.id);
  @override
  _MedicalDetailState createState() => _MedicalDetailState();
}

class _MedicalDetailState extends State<MedicalDetail> {
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
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 15,
            )),
        Text(
          _date.day.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.month.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.year.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        TextButton(
            onPressed: () {
              // setState(() {
              _selectDate(context, controller);
              // });
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            )),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MedicalController(
            customerid: widget.id.toString(),
            selectedDate: DateTime.now(),
            context: context),
        child:
            Consumer<MedicalController>(builder: (context, controller, child) {
          return SafeArea(
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: AppBar(
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/appbar.jpeg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  elevation: 0,
                  title: Text(
                    'Medical Details',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  actions: [
                    GestureDetector(
                      child: Container(
                        margin: const EdgeInsets.only(right: 15),
                        child: IconButton(
                          icon: const Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SalesDisplay(),
                              ),
                            );
                          },
                        ),
                      ),
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
                          child: const LoadingIcon(),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
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
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
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
                      Expanded(
                        child: Text(
                          "Select Date",
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                              fontSize: 15,
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
                  Text(
                    "Next Appointment with Doctor",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildAppointmentDate(controller),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Question Asked to Doctor",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
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
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildUploadWeight(controller),
                  const SizedBox(
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
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 75,
      width: 380,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  appointmentDateString != null
                      ? appointmentDateString!
                      : (controller.medicalModel != null &&
                              controller.medicalModel!.appointmentDate != null)
                          ? controller.medicalModel!.appointmentDate!
                              .toString()
                              .capitalize()
                          : " Date Unavailable ",
                  style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionAskedDoctor(MedicalController controller) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 75,
      width: 380,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.questionPath != null
                      ? controller.questionPath.toString().capitalize()
                      : controller.medicalModel != null &&
                              controller.medicalModel!.question != null
                          ? controller.medicalModel!.question!
                              .toString()
                              .capitalize()
                          : "Report Unavailable",
                  style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadScan(MedicalController controller) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 75,
      width: 380,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.scanReportPath != null
                      ? controller.scanReportPath.toString().capitalize()
                      : (controller.medicalModel != null &&
                              controller.medicalModel!.ultraSound != null)
                          ? controller.medicalModel!.ultraSound!
                              .toString()
                              .capitalize()
                          : "Report Unavailable",
                  style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBlood(MedicalController controller) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 75,
      width: 380,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.bloodReportPath != null
                      ? controller.bloodReportPath.toString().capitalize()
                      : (controller.medicalModel != null &&
                              controller.medicalModel!.bloodReport != null)
                          ? controller.medicalModel!.bloodReport!
                              .toString()
                              .capitalize()
                          : "Report Unavailable",
                  style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAntenatalChart(MedicalController controller) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 75,
      width: 380,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.antenatalReportPath != null
                      ? controller.antenatalReportPath.toString().capitalize()
                      : controller.medicalModel != null &&
                              controller.medicalModel!.antenatalChart != null
                          ? controller.medicalModel!.antenatalChart!
                              .toString()
                              .capitalize()
                          : "Report Unavailable",
                  style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadBp(MedicalController controller) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 75,
      width: 380,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.bpPath != null
                      ? controller.bpPath.toString().capitalize()
                      : controller.medicalModel != null &&
                              controller.medicalModel!.bp != null
                          ? controller.medicalModel!.bp!.toString().capitalize()
                          : "Bp Unavailable",
                  style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadWeight(MedicalController controller) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 75,
      width: 380,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  controller.weightPath != null
                      ? controller.weightPath.toString().capitalize()
                      : controller.medicalModel != null &&
                              controller.medicalModel!.weight != null
                          ? controller.medicalModel!.weight!
                              .toString()
                              .capitalize()
                          : "Weight Unavailable",
                  style: const TextStyle(color: Colors.lightBlue, fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
