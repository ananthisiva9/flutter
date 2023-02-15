import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:railway_super_app/User/Contest/Contest.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class Triva extends StatefulWidget {
  String? id, type;
  Triva(this.id, this.type, {super.key});
  @override
  State<Triva> createState() => _TrivaState();
}

class _TrivaState extends State<Triva> {
  var currentQuestionIndex = 0;
  var amount = 0;
  int seconds = 30;
  Timer? timer;
  Future? quiz;
  bool endOfQuiz = false;
  int points = 0;
  bool answerWasSelected = false;
  // ignore: prefer_typing_uninitialized_variables
  var data, message;
  var isLoaded = false;
  var isLoading = false;
  var optionsList = [];
  bool _clicked = false;



  @override
  void initState() {
    super.initState();
    getData();
    quiz = getTrivia();
    startTimer();
    logStart();
    //SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays:[SystemUiOverlay.bottom]);

  }


  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  getTrivia() async {
    String url =
        '${ApiEndPoint.triva}?contest_id=${widget.type}&history_id=${widget.id}';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http
        .get(Uri.parse(url), headers: {"Authorization": "Token $token"});
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body.toString());
      return data;
    }
  }

  logStart() async {
    String url =
        '${ApiEndPoint.log_start}?app_label=Railway&Module_name=Trivia Contest';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      message = jsonDecode(res.body)['message'];
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  logEnd() async {
    String url = '${ApiEndPoint.log_end}?id=$message';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }


  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          timer.cancel();
          sadDialog();
        }
      });
    });
  }

  stopTimer() {
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: PreferredSize(
            //wrap with PreferredSize
            preferredSize: const Size.fromHeight(0.5),
            child: AppBar(
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFFD4418E), Color(0xFFD4418E)],
                  ),
                ),
              ),
              elevation: 0,
            ),
          ),
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            width: double.infinity,
            height: double.infinity,
            padding: const EdgeInsets.all(12),
            child: FutureBuilder<dynamic>(
                future: quiz,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4,
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      // height: 50,width: 50,
                      // alignment: Alignment.topCenter,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            height: 50, width: 50),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height / 10,
                          width: MediaQuery.of(context).size.width / 1,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 10,
                          ),
                        ),
                      ),
                    );
                    data = snapshot.data["results"];

                    if (isLoaded == false) {
                      optionsList.clear();
                      optionsList.add(data[currentQuestionIndex]
                              ["correct_answer"]
                          .toString());
                      for (var i = 0;
                          i <
                              data[currentQuestionIndex]["incorrect_answers"]
                                  .length;
                          i++) {
                        optionsList.add(
                            data[currentQuestionIndex]["incorrect_answers"][i]);
                      }
                      optionsList.shuffle();
                      isLoaded = true;
                    }

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          const Image(image: AssetImage('asset/Add1.png')),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$seconds",
                                      style: GoogleFonts.montserrat(
                                          color: Colors.white, fontSize: 22),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: CircularProgressIndicator(
                                      value: seconds / 30,
                                      valueColor: const AlwaysStoppedAnimation(
                                          Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Text(
                            "Question ${currentQuestionIndex + 1} of ${data.length}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 10),
                         Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data[currentQuestionIndex]["question"],
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          const SizedBox(height: 15),
                          const Divider(
                            height: 10,
                            color: Colors.white,
                            thickness: 0.5,
                          ),
                          const SizedBox(height: 15),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: optionsList.length,
                            itemBuilder: (BuildContext context, int index) {
                              Text(optionsList[index]);
                              var answer =
                                  data[currentQuestionIndex]["correct_answer"];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    if (answer == optionsList[index]) {
                                      data[currentQuestionIndex]['price']
                                          .round();
                                      successDialog();
                                    } else {
                                      sadDialog();
                                    }
                                    if (currentQuestionIndex >=
                                        data.length - 1) {
                                      Future.delayed(const Duration(seconds: 0),
                                          () {
                                        timer!.cancel();
                                        winningDialog();
                                      });
                                    } else {
                                      timer!.cancel();
                                      //here you can do whatever you want with the results
                                    }
                                  });
                                },
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 10,
                                  width: MediaQuery.of(context).size.width / 2,
                                  margin: const EdgeInsets.only(bottom: 20),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(20),
                                    color: const Color(0xffE6EBFF),
                                  ),
                                  child: Center(
                                    child: Text(
                                      optionsList[index].toString(),
                                      style: GoogleFonts.poppins(
                                          color: const Color(0xFF0652C5),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const Image(image: AssetImage('asset/Add3.png')),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text("Server Error");
                  } else {
                    return const SizedBox(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4,
                        ),
                      ),
                    );
                    ;
                  }
                }),
          )),
    );
  }

  void _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      data[currentQuestionIndex]['price'].round();
      endOfQuiz = false;
      winningDialog();
      Navigator.pop(context);
    });
  }

  getData() async {
    String url =
        '${ApiEndPoint.submit_triva}?score=${data[currentQuestionIndex]['price'].round()}&contest_type_id=${widget.type}&contest_module_id=${widget.id}';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      logEnd();
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Contest()),
      // );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  sadgetData(amount) async {
    String url =
        '${ApiEndPoint.submit_triva}?score=$amount&contest_type_id=${widget.type}&contest_module_id=${widget.id}';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
   token = sharedPreferences.get('token') as String?;
    print('******$amount');
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      logEnd();
      // ignore: use_build_context_synchronously
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const Contest()),
      // );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  gotoNextQuestion() {
    isLoaded = false;
    setState(() {
      currentQuestionIndex = currentQuestionIndex + 1;
    });
    timer!.cancel();
    seconds = 30;
    startTimer();

    if (currentQuestionIndex >= data.length) {
      _resetQuiz();
    }
  }

  Future<dynamic> sadDialog() {
    if (currentQuestionIndex == 0) {
     currentQuestionIndex = 0;
      amount = 0;
    } else {
      currentQuestionIndex = currentQuestionIndex - 1;
     amount = data[currentQuestionIndex]['price'].round();
    }
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: Column(
                children: [
                  Image.asset('asset/sad.gif'),
                  const SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Text(
                      'You Earned : Rs. ${amount.round()}',
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: const Color(0xFF0652C5),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: _clicked
                      ? null
                      : () {
                    setState(()
                    {
                      _clicked = true;
                    });
                   sadgetData(amount.round());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Contest()),
                    );
                    },
                  child: Container(
                    //margin: const EdgeInsets.only(bottom: 20),
                    height: MediaQuery.of(context).size.height / 10,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: Center(
                      child: Text(
                       "Done",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> successDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: Column(
                children: [
                  Image.asset('asset/NextQuestion.gif'),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    gotoNextQuestion();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: MediaQuery.of(context).size.height / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: Center(
                      child: Text(
                        "Next Question",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future<dynamic> winningDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: Column(
                children: [
                  Image.asset('asset/winningTrivia.gif'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Congrats You Earned : Rs. ${data[currentQuestionIndex]['price'].round()}',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: const Color(0xFF0652C5),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: _clicked
                      ? null
                      : () {
                    setState(()
                    {
                      _clicked = true;
                    });
                   getData();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Contest()),
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height / 10,
                    width: MediaQuery.of(context).size.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: Center(
                      child: Text(
                        "Done",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
