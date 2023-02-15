import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway_super_app/User/Contest/LatestContest/ContestType_Model.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'ContestRule.dart';
import 'History/TriviaHistory.dart';
import 'Triva.dart';

class LatestTriviaContest extends StatefulWidget {
  String id;
  LatestTriviaContest(this.id);
  @override
  State<LatestTriviaContest> createState() => _LatestTriviaContestState();
}

class _LatestTriviaContestState extends State<LatestTriviaContest>
    with WidgetsBindingObserver {
  bool loading = true;
  List<Datum> result = [];
  bool isLoading = true;
  bool showAppBar = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getData() async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var baseUrl = "${ApiEndPoint.contest}?obj=1&history=1&type=${widget.id}";
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Token $token"},
    );
    ContestTypeModel model =
        ContestTypeModel.fromJson(jsonDecode(response.body));

    result = result + model.data;
    setState(() {
      isLoading = false;
      result;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        //wrap with PreferredSize
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: const Color(0xff0093DD),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Image(image: AssetImage('asset/Add1.png')),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.75,
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : result.isEmpty
                            ? Center(
                                child: Text(
                                  "No Contest Data Avaliable",
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20),
                                ),
                              )
                            : ListView.builder(
                                itemCount: result.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              2.8,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: const LinearGradient(
                                                colors: [
                                                  Color(0xff0f0c29),
                                                  Color(0xff302b63)
                                                ],
                                                begin: Alignment.centerLeft,
                                                end: Alignment.centerRight,
                                              ),
                                              image: const DecorationImage(
                                                image: AssetImage(
                                                    "asset/wave.png"),
                                                fit: BoxFit.fill,
                                              )),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Icon(
                                                            Icons
                                                                .timer_off_outlined,
                                                            color: Colors.white,
                                                            size: 25),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Center(
                                                            child: Text(
                                                              formatDate(
                                                                  result[index]
                                                                      .toDatetime,
                                                                  [
                                                                    dd,
                                                                    '/',
                                                                    mm,
                                                                    '/',
                                                                    yyyy
                                                                  ]),
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                            right: 8.0),
                                                    child: InkWell(
                                                      child: SizedBox(
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            const Icon(
                                                                Icons
                                                                    .card_giftcard,
                                                                color: Colors
                                                                    .white,
                                                                size: 25),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                'Rs: ${result[index].price.toString()}',
                                                                style: GoogleFonts.poppins(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    right: 8.0,
                                                    top: 4.0,
                                                    bottom: 4.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.8,
                                                            child: Text(
                                                              result[index]
                                                                  .contestName
                                                                  .capitalize!,
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: SizedBox(
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                1.8,
                                                            child: Row(
                                                              children: [
                                                                Text(
                                                                  '${result[index].attemptUser} out of ${result[index].attempts}',
                                                                  style: GoogleFonts.poppins(
                                                                      color: const Color(
                                                                          0xff7EFFD1),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                                Text(
                                                                  ' Attempts ',
                                                                  style: GoogleFonts.poppins(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          15),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Container(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              8,
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3.5,
                                                      decoration: BoxDecoration(
                                                          border: Border.all(
                                                              width: 1,
                                                              color: const Color(
                                                                  0xffFFFFFF)),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4)),
                                                      child: Image.network(
                                                        result[index].image,
                                                        fit: BoxFit.fitWidth,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  left: 10,
                                                  right: 8.0,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  TriviaHistory(
                                                                    result[index]
                                                                        .id
                                                                        .toString(),
                                                                  )),
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            10,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.5,
                                                        child: Card(
                                                          shadowColor:
                                                              const Color(
                                                                  0xff333333),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          elevation: 10,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  width: 0.3,
                                                                  color: Colors
                                                                      .white),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              gradient:
                                                                  const LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0xff0f0c29),
                                                                  Color(
                                                                      0xff302b63)
                                                                ],
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    'History',
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Icon(
                                                                      Icons
                                                                          .history,
                                                                      size: 30,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () async {
                                                        //LogEnd();
                                                        // ignore: unrelated_type_equality_checks

                                                        if (result[index]
                                                                    .contestType ==
                                                                5 &&
                                                            result[index]
                                                                    .attempts >
                                                                result[index]
                                                                    .attemptUser) {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => TrivaContestRule(
                                                                    result[index]
                                                                        .id
                                                                        .toString(),
                                                                    result[index]
                                                                        .contestType
                                                                        .toString(),
                                                                    result[index]
                                                                        .rules)),
                                                          );
                                                        } else {
                                                          sadDialog();
                                                        }
                                                      },
                                                      child: SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            10,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2,
                                                        child: Card(
                                                          shadowColor:
                                                              const Color(
                                                                  0xff333333),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                          elevation: 10,
                                                          margin:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  width: 0.3,
                                                                  color: Colors
                                                                      .white),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              gradient:
                                                                  const LinearGradient(
                                                                colors: [
                                                                  Color(
                                                                      0xff0f0c29),
                                                                  Color(
                                                                      0xff302b63)
                                                                ],
                                                                begin: Alignment
                                                                    .centerLeft,
                                                                end: Alignment
                                                                    .centerRight,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          4.0),
                                                                  child: Text(
                                                                    'Participate',
                                                                    style: GoogleFonts.poppins(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w600,
                                                                        color: Colors
                                                                            .white),
                                                                  ),
                                                                ),
                                                                const Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Icon(
                                                                      Icons
                                                                          .arrow_forward_ios,
                                                                      size: 20,
                                                                      color: Colors
                                                                          .white),
                                                                ),
                                                              ],
                                                            ),
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
                                      ),
                                    ],
                                  );
                                }),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(image: AssetImage('asset/Add3.png')),
                  ),
                ],
              ),
            ),
    );
  }

  sadDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Column(
              children: [
                Image.asset('asset/sad.gif'),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'Sorry!!! You Already Played the Contest',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          );
        });
  }
}
