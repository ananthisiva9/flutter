import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shebirth/utility/api_endpoint.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/rest_service.dart';
import '../../../../../Login/Login_model.dart';

class Calculation extends StatefulWidget {
  const Calculation({Key? key}) : super(key: key);
  @override
  _CalculationState createState() => _CalculationState();
}

class _CalculationState extends State<Calculation> {
  @override
  var Pain = "Could be better";
  var sliderValue = 0.0;
  IconData PainScaleIcon = FontAwesomeIcons.smile;
  Color IconColor = Colors.green;
  int miliSeconds = 0, seconds = 0, minutes = 0, hour = 0;
  String digitSeconds = "00",
      digitMinutes = "00",
      digitHour = "00",
      digitmiliSeconds = "0000";
  Timer? timer;
  bool started = false;
  bool stoped = false;
  var laps;
  //start timer function
  void start() {
    started = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      int localSeconds = seconds + 1;
      int localMinute = minutes;
      int localHour = hour;
      if (localSeconds > 59) {
        if (localMinute > 59) {
          localHour++;
          localMinute = 0;
        } else {
          localMinute++;
          localSeconds = 0;
        }
      }
      setState(() {
        seconds = localSeconds;
        minutes = localMinute;
        hour = localHour;
        digitSeconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digitMinutes = (minutes >= 10) ? "$minutes" : "0$minutes";
        digitHour = (hour >= 10) ? "$hour" : "0$hour";
      });
    });
  }

  void stop() {
    stoped = true;
    timer!.cancel();
    setState(() {
      started = false;
    });
  }

  void reset() {
    timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hour = 0;
      miliSeconds = 0;

      digitmiliSeconds = "0000";
      digitSeconds = "00";
      digitMinutes = "00";
      digitHour = "00";

      started = false;
    });
  }

  void addLaps() {
    var lap;
    lap = "$digitMinutes:$digitSeconds:$digitmiliSeconds";
    laps = lap;
    print(laps);
    callApi();
  }

  callApi() async {
    DateTime now = DateTime.now();
    LoginModel? userdetails = await Global.getUserDetails();

    Map<String, dynamic> header = {
      "Authorization": "Token ${userdetails!.token}"
    };
    Map<String, dynamic> body = new Map<String, dynamic>();
    body["date"] = DateFormat('yyyy-MM-dd').format(now);
    body["time"] = (now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString());
    ;
    body["contraction"] = laps;
    body["painScale"] = Pain.toString();
    String url = clientApi.contraction_post;
    var res = await RestService.postContartionApi(
        url: url, body: body, headers: header);
    if (res != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Contraction Added SSuccessfully'),
        backgroundColor: Colors.green,
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Something Went Wrong!!!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Widget _buildPainScale() {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Container(
                child: Icon(
              PainScaleIcon,
              color: IconColor,
              size: 50.0,
            )),
            Container(
              child: Slider(
                min: 0.0,
                max: 5.0,
                divisions: 5,
                value: sliderValue,
                activeColor: Color(0xffff520d),
                inactiveColor: Colors.black,
                onChanged: (newValue) {
                  setState(() {
                    sliderValue = newValue;
                    if (sliderValue >= 0.0 && sliderValue <= 1.0) {
                      PainScaleIcon = FontAwesomeIcons.smile;
                      IconColor = Colors.green;
                      Pain = "no pain";
                    }
                    if (sliderValue >= 1.1 && sliderValue <= 2.0) {
                      PainScaleIcon = FontAwesomeIcons.frown;
                      IconColor = Colors.yellow;
                      Pain = "mild";
                    }
                    if (sliderValue >= 2.1 && sliderValue <= 3.0) {
                      PainScaleIcon = FontAwesomeIcons.meh;
                      IconColor = Colors.amber;
                      Pain = 'moderate';
                    }
                    if (sliderValue >= 3.1 && sliderValue <= 4.0) {
                      PainScaleIcon = FontAwesomeIcons.sadTear;
                      IconColor = Colors.orange;
                      Pain = "severe";
                    }
                    if (sliderValue >= 4.1 && sliderValue <= 5.0) {
                      PainScaleIcon = FontAwesomeIcons.sadCry;
                      IconColor = Colors.red;
                      Pain = "worst pain";
                    }
                  });
                },
              ),
            ),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: Image.asset('assets/Background.png').image,
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildPainScale(),
              Center(
                child: Text(
                  "$digitHour:$digitMinutes:$digitSeconds",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                        child: Image(
                          image: AssetImage('assets/counterstart.png'),
                          height: 50,
                        ),
                        onPressed: () {
                          (!started) ? start() : reset();
                        }),
                  ),
                  Expanded(
                    child: TextButton(
                        child: Image(
                          image: AssetImage('assets/counterstop.png'),
                          height: 50,
                        ),
                        onPressed: () {
                          stop();
                        }),
                  ),
                ],
              ),
              Container(
                height: 45,
                width: 150,
                margin: EdgeInsets.only(bottom: 20),
                child:  ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green , //foreground (text) color
                  ),
                  onPressed: () {
                    addLaps();
                    (Pain);
                    reset();
                  },
                  child: Text(
                    "Calculate",
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontSize: 15,
                        fontFamily: 'Gilroy'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
