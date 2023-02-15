import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PoemHistory_model.dart';

class PoemHistory extends StatefulWidget {
  String? id, type;
  PoemHistory(this.id, this.type, {super.key});
  @override
  State<PoemHistory> createState() => _PoemHistoryState();
}

class _PoemHistoryState extends State<PoemHistory> {
  List<Datum> result = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
  int page = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData(page);
    handleNext();
  }

  void getData(parapage) async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var baseUrl =
        '${ApiEndPoint.poetry_contest_history}?page=$parapage&limit=20&id&history=${widget.id}';
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Token $token"},
    );

    PoemModel model = PoemModel.fromJson(jsonDecode(response.body));

    result = result + model.data!;

    int localpage = page + 1;
    setState(() {
      result;
      isLoading = false;
      page = localpage;
    });
  }

  void handleNext() {
    scrollController.addListener(() async {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        getData(page);
      }
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
      body:  isLoading
          ? const Center(
          child:
          CircularProgressIndicator()) // this will show when loading is true
          :  SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(image: AssetImage('asset/Add1.png')),
            ),
           Container(
                      height: MediaQuery.of(context).size.height / 1,
                      child: ListView.builder(
                          controller: scrollController,
                          itemCount: result.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff666666),
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.white38,
                                      blurRadius: 2.0,
                                      spreadRadius: 2.0,
                                    )
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // const Padding(
                                    //   padding: EdgeInsets.only(right: 25.0,left: 10,top: 10,bottom: 10),
                                    //   child:
                                    //  CircleAvatar(
                                    //     backgroundImage:
                                    //         AssetImage('asset/profilPic.png'),
                                    //     backgroundColor: Colors.blue,
                                    //     radius: 50,
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              7,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          // ignore: unnecessary_null_comparison
                                          child: (result[index]
                                                      .url
                                                      .toString() !=
                                                  null)
                                              ? Image.network(
                                                  result[index].url.toString(),
                                                  fit: BoxFit.fitWidth,
                                                )
                                              : const Text(
                                                  'Image Not Avaliable')),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        (result[index].title != null)
                                            ? SizedBox(
                                          width: 220,
                                              child: Text(
                                                  result[index].title,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                            )
                                            : Text(
                                                'Image Not Avaliable',
                                                style: GoogleFonts.poppins(
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                        SizedBox(
                                          width: 220,
                                          child: Text(
                                            'By ${result[index].user}',
                                            style: GoogleFonts.poppins(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color(0xff792430),
                                            ),
                                            onPressed: () {
                                              showModalBottomSheet<void>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {

                                                  return Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              1.8,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: <Widget>[
                                                          Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    2.5,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border
                                                                      .all(
                                                                    color: const Color(
                                                                        0xff666666),
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15),
                                                                  color: Colors
                                                                      .white,
                                                                  boxShadow: const [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey,
                                                                      blurRadius:
                                                                          7.0,
                                                                      spreadRadius:
                                                                          2.0,
                                                                      offset: Offset(
                                                                          0.0,
                                                                          0.0),
                                                                    )
                                                                  ],
                                                                ),
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                                .only(
                                                                            left:
                                                                                8.0,
                                                                            top:
                                                                                8.0),
                                                                        child:
                                                                            Text(
                                                                          result[index]
                                                                              .title,
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize:
                                                                                  25,
                                                                              fontWeight:
                                                                                  FontWeight.bold,
                                                                              color: const Color(0xff0093DD)),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                                .all(
                                                                            15.0),
                                                                        child:
                                                                            Text(
                                                                          result[index]
                                                                              .name,
                                                                          style: GoogleFonts.poppins(
                                                                              fontSize:
                                                                                  20,
                                                                              fontWeight:
                                                                                  FontWeight.w500),
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left:
                                                                        140.0),
                                                            child: Text(
                                                              'Written Date : ${result[index].date}',
                                                              style: GoogleFonts.poppins(
                                                                  fontSize: 18,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500),
                                                              textAlign:
                                                                  TextAlign.end,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            },
                                            child: Text('View Poem',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                           );
                          }),
                    ),
          ],
        ),
      ),
    );
  }
}
