import 'dart:convert';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/Sales/AllClients/AllClients_controller.dart';
import 'package:admin_dashboard/Sales/Daily%20Tracker/Daily%20Tracker.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:admin_dashboard/Sales/MedicalUpdate/InitialFlowUp/InitialFlowUp.dart';
import 'package:admin_dashboard/Sales/MedicalUpdate/InvestigationReport/InvestigationReport.dart';
import 'package:admin_dashboard/Sales/MedicalUpdate/Medical/Medical_view.dart';
import 'package:admin_dashboard/Sales/Tracker/DailyTracker.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientProfile extends StatefulWidget {
  final int value;
  const ClientProfile({Key? key, required this.value}) : super(key: key);
  @override
  State<ClientProfile> createState() => _ClientProfileState();
}

class _ClientProfileState extends State<ClientProfile> {
  var id,
      email,
      firstname,
      lastname,
      husband,
      age,
      mobile,
      babies_number,
      abortions,
      twins,
      marriedSince,
      babiesnumber,
      diabetes,
      allergicreaction,
      surgery,
      Menstruationdate,
      hereditory,
      gynacology,
      doctorfinalvisit,
      noofbabiespregnantwith,
      profile_pic;
  late String data;
  bool _isLoading = true;

  void initState() {
    super.initState();
    getData();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
    super.initState();
  }

  getData() async {
    String? token = await getToken();
    String url = Admin.client_profile + '?customer=' + widget.value.toString();
    if (token != null) {
      var response = await http.get(
        Uri.parse(url),
        headers: {"Authorization": "Token $token"},
      );
      if (response.statusCode == 200) {
        data = response.body;
        print(data);
        print(widget.value);
        setState(() {
          data = response.body;
          firstname = jsonDecode(data)['customer']['firstname'];
          lastname = jsonDecode(data)['customer']['lastname'];
          age = jsonDecode(data)['details']['age'];
          mobile = jsonDecode(data)['customer']['mobile'];
          email = jsonDecode(data)['customer']['email'];
          husband = jsonDecode(data)['details']['husband'];
          marriedSince = jsonDecode(data)['details']['marriedSince'];
          babies_number = jsonDecode(data)['details']['babies_number'];
          abortions = jsonDecode(data)['abortions'];
          twins = jsonDecode(data)['details']['twins'];
          diabetes = jsonDecode(data)['details']['diabetes'];
          allergicreaction = jsonDecode(data)['details']['allergic_reaction'];
          surgery = jsonDecode(data)['details']['surgery'];
          babiesnumber = jsonDecode(data)['details']['babies_number'];
          Menstruationdate = jsonDecode(data)['details']['Menstruation_date"'];
          hereditory = jsonDecode(data)['details']['hereditory'];
          gynacology = jsonDecode(data)['details']['gynacology'];
          doctorfinalvisit = jsonDecode(data)['details']['doctor_final_visit'];
          noofbabiespregnantwith =
              jsonDecode(data)['details']['no_of_babies_pregnant_with'];
          profile_pic = jsonDecode(data)['customer']['profile_pic'];
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('User Detail not Found'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SalesDisplay()),
        );
      });
    }
  }
  Future<dynamic> Medical() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.cyan,
        title: Text(
          "Medical Update",
          style: GoogleFonts.poppins(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        content: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) , // foreground (text) color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MedicalDetail(widget.value)),
                  );
                },
                child: Text(
                  "Medical Details",
                  style:
                  GoogleFonts.poppins(color: Colors.white, fontSize: 15),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffe14589) , // foreground (text) color
              ),
              onPressed: () async {
                const url = 'https://sukhprasavam.com/inital/88';
                if (await canLaunch(url)){
                  await launch(
                    url,
                    forceWebView: true,
                    enableJavaScript: true,
                  );
                }
              },
              child: Text(
                "Initial FlowUp",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> Tracking() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.cyan,
        title: Text(
          "Daily Tracker Details",
          style: GoogleFonts.poppins(fontSize: 15),
          textAlign: TextAlign.center,
        ),
        content: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xffe14589) , // foreground (text) color
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DailyTracker(widget.value)),
                  );
                },
                child: Text(
                  "Tracker Details",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffe14589) , // foreground (text) color
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UpdateTracker(widget.value)),
                );
              },
              child: Text(
                "Update Tracker",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
              'Profile Details',
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
                        MaterialPageRoute(builder: (context) => SalesDisplay()),
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: _buildContainer(),
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

  Widget _buildAge() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              age.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHusbandname() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              husband.toString().capitalize(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailAddress() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              email.toString().capitalize(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion1() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              marriedSince.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion2() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              babies_number.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion3() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              abortions.toString().capitalize(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion4() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              twins.toString().capitalize(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion5() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              diabetes.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion6() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              allergicreaction.toString().capitalize(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion7() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              Menstruationdate.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion8() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              hereditory.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion9() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              gynacology.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion10() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              babies_number.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion11() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              doctorfinalvisit.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuestion12() {
    return Container(
      height: 75,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white.withOpacity(0.1),
          ),
          width: 400,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              surgery.toString(),
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return ChangeNotifierProvider(
      create: (context) => AllClientController(context),
      child:
          Consumer<AllClientController>(builder: (context, controller, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: 250,
                          width: 450,
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white.withOpacity(0.1),
                          ),
                          child: Stack(
                            children: <Widget>[
                              controller.state == StateEnum.loading
                                  ? const Center(child: LoadingIcon())
                                  : controller.state == StateEnum.success
                                      ? (controller.model!
                                                      .totalPatientsDetails ==
                                                  null ||
                                              controller
                                                  .model!
                                                  .totalPatientsDetails!
                                                  .isEmpty)
                                          ? Center(
                                              child: Text(
                                                'No Patient available',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.white
                                                      .withOpacity(0.1),
                                                ),
                                                height: 250,
                                                child: Stack(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.cyan[100],
                                                        backgroundImage:
                                                            const AssetImage(
                                                                'assets/Client dummy.png'),
                                                        radius: 35,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(
                                                        children: <Widget>[
                                                          TextButton(
                                                            onPressed: () {},
                                                            child: Text(
                                                              (firstname
                                                                      .toString()
                                                                      .capitalize()) +
                                                                  " " +
                                                                  (lastname
                                                                      .toString()
                                                                      .capitalize()),
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                      fontSize:
                                                                          18,
                                                                      color: Colors
                                                                          .white),
                                                            ),
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                "Age : " +
                                                                    (age.toString()),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .lightBlueAccent,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Text(
                                                                "Email : " +
                                                                    (email
                                                                        .toString()
                                                                        .capitalize()),
                                                                style:
                                                                    GoogleFonts
                                                                        .poppins(
                                                                  color: Colors
                                                                      .lightBlueAccent,
                                                                  fontSize: 12,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          const Divider(
                                                            height: 20,
                                                            thickness: .8,
                                                            color: Colors.white,
                                                          ),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: <Widget>[
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: <
                                                                    Widget>[
                                                                  Container(
                                                                    height: 35,
                                                                    width: 150,
                                                                    child:
                                                                    ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                        primary: Color(0xffe14589) , // foreground (text) color
                                                                      ),
                                                                      onPressed:
                                                                          () {
                                                                        Tracking();
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Tracking",
                                                                        style: GoogleFonts
                                                                            .poppins(
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              13,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        15.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceAround,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .center,
                                                                      children: <
                                                                          Widget>[
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              height:
                                                                                  35,
                                                                              width:
                                                                                  150,
                                                                              child:
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  primary: Colors.blue , // foreground (text) color
                                                                                ),
                                                                                onPressed:
                                                                                    () {
                                                                                  Medical();
                                                                                    },
                                                                                child:
                                                                                    Text(
                                                                                  "Medical Update",
                                                                                  style: GoogleFonts.poppins(
                                                                                    color: Colors.white,
                                                                                    fontSize: 13,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),

                                                                    Padding(
                                                                      padding: const EdgeInsets.all(10.0),
                                                                      child: Row(
                                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                                        children: [
                                                                          Container(
                                                                            height: 35,
                                                                            width: 150,
                                                                            child: ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                primary: Colors.blue , // foreground (text) colorrderRadius: BorderRadius.circular(20),
                                                                                ),
                                                                              onPressed: () {
                                                                                Navigator.push(
                                                                                  context,
                                                                                  MaterialPageRoute(
                                                                                      builder: (context) => Report(widget.value)),
                                                                                );
                                                                              },
                                                                              child: Text(
                                                                                "Investigation Report",
                                                                                style: GoogleFonts.poppins(
                                                                                  color: Colors.white,
                                                                                  fontSize: 13,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                      ],
                                                                  ),
                                                                    ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                      : Center(
                                          child:
                                              ErrorRefreshIcon(onPressed: () {
                                            controller.fetchAllClients();
                                          }),
                                        )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "HusbandName :",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildHusbandname(),
                        Text(
                          "Age :",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildAge(),
                        Text(
                          "Email :",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildEmailAddress(),
                        Text(
                          "Married Since :",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion1(),
                        Text(
                          "How Many Baby Do You Have?  :",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion2(),
                        Text(
                          "Any history of Abortion?  :",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion3(),
                        Text(
                          "Any History of Twins in the Family? : ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion4(),
                        Text(
                          "Any Family History of Diabetes? : ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion5(),
                        Text(
                          "Any History of Allergic Reaction?: ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion6(),
                        Text(
                          "Any Family History of Diabetes? : ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion7(),
                        Text(
                          "How many days Menstrual Period Cycle? : ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion8(),
                        Text(
                          "Any Hereditary Health Related Complication? : ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion9(),
                        Text(
                          'How Many Baby are you Pregnant?',
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion10(),
                        Text(
                          "When did you Visit Doctor Family? :  ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion11(),
                        Text(
                          "Any history of Surgery? if Yes Specify? : ",
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.lightBlueAccent,
                                fontWeight: FontWeight.bold),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        _buildQuestion12(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
