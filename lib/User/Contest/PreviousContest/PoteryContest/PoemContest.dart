import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway_super_app/User/Contest/PreviousContest/ContestType_Model.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'PoetryContest.dart';

class PreviousPoemContest extends StatefulWidget {
  String id;
  PreviousPoemContest(this.id);
  @override
  State<PreviousPoemContest> createState() => _PreviousPoemContestState();
}

class _PreviousPoemContestState extends State<PreviousPoemContest> {
  bool loading = true;
  List<Datum> result = [];
  bool isLoading = true;
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var baseUrl = "${ApiEndPoint.contest}?obj=1&history=2&type=${widget.id}";
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Token $token"},
    );
    ContestTypeModel model = ContestTypeModel.fromJson(jsonDecode(response.body));

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
          children: [
            const Padding(
              padding: EdgeInsets.all(10.0),
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
                  :  ListView.builder(
                  itemCount: result.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: MediaQuery.of(context)
                                .size
                                .height /
                                5,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffad5389),
                                    Color(0xff3c1053)
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
                              MainAxisAlignment.center,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .start,
                                        crossAxisAlignment:
                                        CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(
                                                context)
                                                .size
                                                .width /
                                                1.8,
                                            child: Text(
                                              result[index]
                                                  .contestName
                                                  .capitalize!,
                                              style: GoogleFonts
                                                  .poppins(
                                                  color: Colors
                                                      .white,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold,
                                                  fontSize:
                                                  18),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              //LogEnd();
                                              // ignore: unrelated_type_equality_checks
                                              if (result[index]
                                                  .contestType ==
                                                  2 ) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) => PoemHistory(
                                                          result[index]
                                                              .id
                                                              .toString(),
                                                          result[index]
                                                              .contestType
                                                              .toString())),
                                                );
                                              } else {

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
                                                  3,
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
                                                        Color(0xffad5389),
                                                        Color(0xff3c1053)
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
                                                          'View',
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
                                                            size: 16,
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
                                                width: 2,
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
                Image.asset('asset/sadnessTrivia.gif'),
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
