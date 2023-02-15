import 'dart:async';
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:railway_super_app/User/Contest/Contest.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class QuizContest extends StatefulWidget {
  String? id, type;
  QuizContest(this.id, this.type , {super.key});
  @override
  State<QuizContest> createState() => _QuizContestState();
}

class _QuizContestState extends State<QuizContest> {
  //with WidgetsBindingObserver
  bool isLoading = false;
  var currentQuestionIndex = 0;
  Future? quiz;
  bool endOfQuiz = false;
  int points = 0;
  bool answerWasSelected = false;
  // ignore: prefer_typing_uninitialized_variables
  var data, message;
  var isLoaded = false;
  bool _clicked = false;

  var optionsList = [];
  var ques = [];

  var optionsColor = [
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.white,
  ];

  Future _nextQuestion() async {
    return Future.delayed(const Duration(milliseconds: 200 ), () {
      setState(() {
        // gotoNextQuestion();
        isLoaded = false;
        setState(() {
          currentQuestionIndex = currentQuestionIndex + 1;
        });
        resetColors();
        if (currentQuestionIndex >= data.length) {
          _resetQuiz();
         winningDialog();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    logStart();
    //WidgetsBinding.instance.addObserver(this);
  }

  getQuiz() async {
    String url =
        '${ApiEndPoint.quiz}?contest_id=${widget.type}&history_id=${widget.id}';
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

  getData() async {
    String url =
        '${ApiEndPoint.submit_contest}?score=$points&contest_type_id=${widget.type}&contest_module_id=${widget.id}';
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
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
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
                    height: 3,
                  ),
                  Text(
                    'Your Score $points',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: const Color(0xFF0652C5),
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: _clicked
                        ? null
                        : () {
                            setState(() {
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
                      child: (isLoading)
                          ? const SizedBox(
                              child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ))
                          : Center(
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
            ),
          );
        });
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  resetColors() {
    optionsColor = [
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
      Colors.white,
    ];
  }

  _resetQuiz() {
    setState(() {
      currentQuestionIndex = 0;
      endOfQuiz = false;
      winningDialog();
      Navigator.pop(context);
    });
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
                          color: Color(0xFF0652C5),
                          strokeWidth: 4,
                        ),
                      ),
                    );
                  } else if (snapshot.hasData) {
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
                    // return  data.length==0 ? Container():
                    return SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Image(image: AssetImage('asset/Add1.png')),
                          const SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Question ${currentQuestionIndex + 1} of ${data.length}",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                data[currentQuestionIndex]["question"],
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          const Divider(
                            height: 10,
                            color: Colors.white,
                            thickness: 0.5,
                          ),
                         ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: optionsList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    Text(optionsList[index]);
                                    var answer = data[currentQuestionIndex]
                                        ["correct_answer"];
                                    return InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (answer == optionsList[index]) {
                                            optionsColor[index] = Colors.green;
                                            points = points + 1;
                                            if (answer == optionsList[index]) {
                                              // _onPressed(context);
                                              successDialog();
                                            }
                                          } else if (answer !=
                                              optionsList[index]) {
                                            optionsColor[index] = Colors.red;
                                            if (answer != optionsList[index]) {
                                              sadDialog();
                                            }
                                          } else {
                                            optionsColor[index] = Colors.blue;
                                          }
                                        });
                                      },
                                      child: Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 20),
                                        decoration: BoxDecoration(
                                              color: optionsColor[index],
                                              border:
                                                  Border.all(color: Colors.black),
                                              borderRadius:
                                                 BorderRadius.circular(20),
                                             ),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 100,
                                              right: 100,
                                              top: 10,
                                              bottom: 10),
                                          child: (isLoading = false)
                                              ? const SizedBox(
                                                  child:
                                                      CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 3,
                                                ))
                                              : Center(
                                                  child: Text(
                                                    optionsList[index]
                                                        .toString(),
                                                    style: GoogleFonts.poppins(
                                                        color: const Color(
                                                            0xFF0652C5),
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                    // return GestureDetector(
                                    //  onTap: () {
                                    //    setState(() {
                                    //      if (answer == optionsList[index]) {
                                    //        optionsColor[index] = Colors.green;
                                    //        points = points + 1;
                                    //        if (answer == optionsList[index]) {
                                    //          // _onPressed(context);
                                    //          _nextQuestion();
                                    //          isLoading = true;
                                    //        }
                                    //      } else if (answer !=
                                    //          optionsList[index]) {
                                    //        optionsColor[index] = Colors.red;
                                    //        if (answer != optionsList[index] ) {
                                    //          _nextQuestion();
                                    //        }
                                    //      } else {
                                    //        optionsColor[index] = Colors.blue;
                                    //      }
                                    //    });
                                    //    },
                                    //   child: Container(
                                    //     height:
                                    //         MediaQuery.of(context).size.height /
                                    //             10,
                                    //     width:
                                    //         MediaQuery.of(context).size.width,
                                    //     margin:
                                    //         const EdgeInsets.only(bottom: 20),
                                    //     decoration: BoxDecoration(
                                    //       color: optionsColor[index],
                                    //       border:
                                    //           Border.all(color: Colors.black),
                                    //       borderRadius:
                                    //           BorderRadius.circular(20),
                                    //       //color: const Color(0xffFFE3BA),
                                    //     ),
                                    //     child: Center(
                                    //       child: Text(
                                    //         optionsList[index].toString(),
                                    //         style: GoogleFonts.poppins(
                                    //             color: const Color(0xFF0652C5),
                                    //             fontSize: 16,
                                    //             fontWeight: FontWeight.bold),
                                    //       ),
                                    //     ),
                                    //   ),
                                    // );
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
                          color: Color(0xff0093DD),
                          strokeWidth: 4,
                        ),
                      ),
                    );
                  }
                }),
          )),
    );
  }
  Future<dynamic> sadDialog() {
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
                ],
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    _nextQuestion();
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
                    _nextQuestion();
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
}
