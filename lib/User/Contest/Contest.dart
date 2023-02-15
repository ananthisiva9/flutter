import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:railway_super_app/User/Bottombar.dart';
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'LatestContest/Image Contest/ImageContest.dart';
import 'LatestContest/NameTheApp/AppNameContest.dart';
import 'LatestContest/PoteryContest/PoemContest.dart';
import 'LatestContest/Quiz/QuizContest.dart';
import 'LatestContest/Triva/TriviaContest.dart';
import 'Model.dart';
import 'PreviousContest/AppName/AppNameContest.dart';
import 'PreviousContest/ImageHistory/ImageContest.dart';
import 'PreviousContest/PoteryContest/PoemContest.dart';
import 'PreviousContest/Quiz/QuizContest.dart';
import 'PreviousContest/Trivia/TriviaContest.dart';


class Contest extends StatefulWidget {
  const Contest({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _ContestState createState() => _ContestState();
}

class _ContestState extends State<Contest> {
  BaseWidget? baseWidget;
  bool loading = true;
  List<Datum> result = [];
  bool isLoading = true;
  bool loading1 = true;
  List<Datum> result1 = [];
  bool isLoading1 = true;

  @override
  void initState() {
    super.initState();
    getData();
    getData1();
    baseWidget = BaseWidget();
  }

  getData() async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var baseUrl = '${ApiEndPoint.contestType}?id=1';
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Token $token"},
    );
    ContestModel model = ContestModel.fromJson(jsonDecode(response.body));
    result = result + model.data;
    setState(() {
      isLoading = false;
      result;
      loading = false;
    });
  }
  getData1() async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var baseUrl = ApiEndPoint.contestType;
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Token $token"},
    );
    ContestModel model = ContestModel.fromJson(jsonDecode(response.body));
    result1 = result1 + model.data;
    setState(() {
      isLoading1 = false;
      result1;
      loading1 = false;
    });
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => BottomBar(index: 0)));
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: DefaultTabController(
            length: 2,
            child: Column(
              children: <Widget>[
                Container(
                  height: 65,
                  color: const Color(0xff49BDF8),
                  padding: const EdgeInsets.symmetric(vertical: 5),

                  child: const TabBar(
                      labelStyle: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily:'poppins'),
                      //For Selected tab
                      unselectedLabelStyle: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'poppins'),
                      indicatorColor: Colors.white,
                      indicatorWeight: 3,

                      tabs: [
                        Tab(text: "Latest"),
                        Tab(text: "Previous"),
                      ]),
                ),
                Expanded(
                  child: SizedBox(
                    child: TabBarView(
                      children: [
                        SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Image(image: AssetImage('asset/Add1.png')),
                                ),
                               loading
                                    ? const Center(child: CircularProgressIndicator())
                                   : result.isEmpty
                                    ? Center(
                                  child: Text(
                                    "No Contest Data Available",
                                    style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20),
                                  ),
                                )
                                    : SizedBox(
                                     height: height/1,
                                     child: ListView.builder(
                                       scrollDirection: Axis.vertical,
                                         physics: const NeverScrollableScrollPhysics(),
                                         shrinkWrap: true,
                                         itemCount: result.length,
                                         itemBuilder: (context, index) {
                                           return Column(children: [
                                             if (result[index].id == 1) ...[
                                               Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Container(
                                                   height:
                                                   MediaQuery.of(context).size.height /
                                                       6,
                                                   decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(15),
                                                     gradient: const LinearGradient(
                                                       colors: [
                                                         Color(0xff1cd8d2),
                                                         Color(0xff93edc7)
                                                       ],
                                                       begin: Alignment.centerLeft,
                                                       end: Alignment.centerRight,
                                                     ),
                                                       image: const DecorationImage(
                                                         image: AssetImage("asset/wave.png"),
                                                         fit: BoxFit.fill,
                                                       )
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment.spaceEvenly,
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment.center,
                                                     children: <Widget>[
                                                       Column(
                                                         mainAxisAlignment:
                                                         MainAxisAlignment.center,
                                                         crossAxisAlignment:
                                                         CrossAxisAlignment.start,
                                                         children: [
                                                           Text(
                                                             'Naming Contest',
                                                             style: GoogleFonts.poppins(
                                                                 color: Colors.white,
                                                                 fontWeight: FontWeight.w600,
                                                                 fontSize: 16),
                                                           ),
                                                           Padding(
                                                             padding:
                                                             const EdgeInsets.all(
                                                                 2.0),
                                                             child: InkWell(
                                                               onTap: () {
                                                                 Navigator.push(
                                                                     context,
                                                                     MaterialPageRoute(
                                                                         builder: (context) =>
                                                                             LatestAppNameContest(
                                                                                 result[index]
                                                                                     .id
                                                                                     .toString())));
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
                                                                         20),
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
                                                                           20),
                                                                       gradient:
                                                                       const LinearGradient(
                                                                         colors: [
                                                                           Color(0xff1cd8d2),
                                                                           Color(0xff93edc7)
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
                                                                           padding: const EdgeInsets.all(4.0),
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
                                                                               .all(4.0),
                                                                           child: Icon(
                                                                               Icons.arrow_forward_ios,
                                                                               size: 16,
                                                                               color: Colors.white),
                                                                         ),

                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       const Padding(
                                                         padding: EdgeInsets.all(8.0),
                                                         child: Image(
                                                           image: AssetImage(
                                                               'asset/AppName.png'),
                                                           height: 80,
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ] else if (result[index].id == 2) ...[
                                               Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Container(
                                                   height:
                                                   MediaQuery.of(context).size.height /
                                                       6,
                                                   decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(15),
                                                       gradient: const LinearGradient(
                                                         colors: [
                                                           Color(0xffad5389),
                                                           Color(0xff3c1053)
                                                         ],
                                                         begin: Alignment.centerLeft,
                                                         end: Alignment.centerRight,
                                                       ),
                                                       image: const DecorationImage(
                                                         image: AssetImage("asset/wave.png"),
                                                         fit: BoxFit.fill,
                                                       )
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment.spaceEvenly,
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment.center,
                                                     children: <Widget>[
                                                       Column(
                                                         mainAxisAlignment:
                                                         MainAxisAlignment.center,
                                                         crossAxisAlignment:
                                                         CrossAxisAlignment.start,
                                                         children: [
                                                           Text(
                                                             'Poetry Contest',
                                                             style: GoogleFonts.poppins(
                                                                 color: Colors.white,
                                                                 fontWeight: FontWeight.w600,
                                                                 fontSize: 16),
                                                           ),
                                                           Padding(
                                                             padding:
                                                             const EdgeInsets.all(
                                                                 2.0),
                                                             child: InkWell(
                                                               onTap: () {
                                                                 Navigator.push(
                                                                     context,
                                                                     MaterialPageRoute(
                                                                         builder: (context) =>
                                                                             LatestPoemContest(
                                                                                 result[index]
                                                                                     .id
                                                                                     .toString())));
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
                                                                         20),
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
                                                                           20),
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
                                                                           padding: const EdgeInsets.all(4.0),
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
                                                                               .all(4.0),
                                                                           child: Icon(
                                                                               Icons.arrow_forward_ios,
                                                                               size: 16,
                                                                               color: Colors.white),
                                                                         ),

                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       const Padding(
                                                         padding: EdgeInsets.all(8.0),
                                                         child: Image(
                                                           image: AssetImage(
                                                               'asset/Poetry.png'),
                                                           height: 80,
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ] else if (result[index].id == 3) ...[
                                               Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Container(
                                                   height:
                                                   MediaQuery.of(context).size.height /
                                                       6,
                                                   decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(15),
                                                       gradient: const LinearGradient(
                                                         colors: [
                                                           Color(0xffa044ff),
                                                           Color(0xff6a3093)
                                                         ],
                                                         begin: Alignment.centerLeft,
                                                         end: Alignment.centerRight,
                                                       ),
                                                       image: const DecorationImage(
                                                         image: AssetImage("asset/wave.png"),
                                                         fit: BoxFit.fill,
                                                       )
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment.spaceEvenly,
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment.center,
                                                     children: <Widget>[
                                                       Column(
                                                         mainAxisAlignment:
                                                         MainAxisAlignment.center,
                                                         crossAxisAlignment:
                                                         CrossAxisAlignment.start,
                                                         children: [
                                                           Text(
                                                             'Image Contest',
                                                             style: GoogleFonts.poppins(
                                                                 color: Colors.white,
                                                                 fontWeight: FontWeight.w600,
                                                                 fontSize: 16),
                                                           ),
                                                           Padding(
                                                             padding:
                                                             const EdgeInsets.all(
                                                                 2.0),
                                                             child: InkWell(
                                                               onTap: () {
                                                                 Navigator.push(
                                                                     context,
                                                                     MaterialPageRoute(
                                                                         builder: (context) =>
                                                                             LatestImageContest(
                                                                                 result[index]
                                                                                     .id
                                                                                     .toString())));
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
                                                                         20),
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
                                                                           20),
                                                                       gradient:
                                                                       const LinearGradient(
                                                                         colors: [
                                                                           Color(0xffa044ff),
                                                                           Color(0xff6a3093)
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
                                                                           padding: const EdgeInsets.all(4.0),
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
                                                                               .all(4.0),
                                                                           child: Icon(
                                                                               Icons.arrow_forward_ios,
                                                                               size: 16,
                                                                               color: Colors.white),
                                                                         ),

                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       const Padding(
                                                         padding: EdgeInsets.all(8.0),
                                                         child: Image(
                                                           image: AssetImage(
                                                               'asset/ImageContest.jpg'),
                                                           height: 80,
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ] else if (result[index].id == 4) ...[
                                               Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Container(
                                                   height:
                                                   MediaQuery.of(context).size.height /
                                                       6,
                                                   decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(15),
                                                       gradient: const LinearGradient(
                                                         colors: [
                                                           Color(0xff457fca),
                                                           Color(0xff5691c8)
                                                         ],
                                                         begin: Alignment.centerLeft,
                                                         end: Alignment.centerRight,
                                                       ),
                                                       image: const DecorationImage(
                                                         image: AssetImage("asset/wave.png"),
                                                         fit: BoxFit.fill,
                                                       )
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment.spaceEvenly,
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment.center,
                                                     children: <Widget>[
                                                       Column(
                                                         mainAxisAlignment:
                                                         MainAxisAlignment.center,
                                                         crossAxisAlignment:
                                                         CrossAxisAlignment.start,
                                                         children: [
                                                           Text(
                                                             'Quiz Contest',
                                                             style: GoogleFonts.poppins(
                                                                 color: Colors.white,
                                                                 fontWeight: FontWeight.w600,
                                                                 fontSize: 16),
                                                           ),
                                                           Padding(
                                                             padding:
                                                             const EdgeInsets.all(
                                                                 2.0),
                                                             child: InkWell(
                                                               onTap: () {
                                                                 Navigator.push(
                                                                     context,
                                                                     MaterialPageRoute(
                                                                         builder: (context) =>
                                                                             LatestQuizContest(
                                                                                 result[index]
                                                                                     .id
                                                                                     .toString())));
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
                                                                         20),
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
                                                                           20),
                                                                       gradient:
                                                                       const LinearGradient(
                                                                         colors: [
                                                                           Color(0xff457fca),
                                                                           Color(0xff5691c8)
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
                                                                           padding: const EdgeInsets.all(4.0),
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
                                                                               .all(4.0),
                                                                           child: Icon(
                                                                               Icons.arrow_forward_ios,
                                                                               size: 16,
                                                                               color: Colors.white),
                                                                         ),

                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       const Padding(
                                                         padding: EdgeInsets.all(8.0),
                                                         child: Image(
                                                           image: AssetImage(
                                                               'asset/QuizContest.png'),
                                                           height: 80,
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ] else if (result[index].id == 5) ...[
                                               Padding(
                                                 padding: const EdgeInsets.all(10.0),
                                                 child: Container(
                                                   height:
                                                   MediaQuery.of(context).size.height /
                                                       6,
                                                   decoration: BoxDecoration(
                                                       borderRadius: BorderRadius.circular(15),
                                                       gradient: const LinearGradient(
                                                         colors: [
                                                           Color(0xff0f0c29),
                                                           Color(0xff302b63)
                                                         ],
                                                         begin: Alignment.centerLeft,
                                                         end: Alignment.centerRight,
                                                       ),
                                                       image: const DecorationImage(
                                                         image: AssetImage("asset/wave.png"),
                                                         fit: BoxFit.fill,
                                                       )
                                                   ),
                                                   child: Row(
                                                     mainAxisAlignment:
                                                     MainAxisAlignment.spaceEvenly,
                                                     crossAxisAlignment:
                                                     CrossAxisAlignment.center,
                                                     children: <Widget>[
                                                       Column(
                                                         mainAxisAlignment:
                                                         MainAxisAlignment.center,
                                                         crossAxisAlignment:
                                                         CrossAxisAlignment.start,
                                                         children: [
                                                           Text(
                                                             'Trivia Contest',
                                                             style: GoogleFonts.poppins(
                                                                 color: Colors.white,
                                                                 fontWeight: FontWeight.w600,
                                                                 fontSize: 16),
                                                           ),
                                                           Padding(
                                                             padding:
                                                             const EdgeInsets.all(
                                                                 2.0),
                                                             child: InkWell(
                                                               onTap: () {
                                                                 Navigator.push(
                                                                     context,
                                                                     MaterialPageRoute(
                                                                         builder: (context) =>
                                                                             LatestTriviaContest(
                                                                                 result[index]
                                                                                     .id
                                                                                     .toString())));
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
                                                                         20),
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
                                                                           20),
                                                                       gradient:
                                                                       const LinearGradient(
                                                                         colors: [
                                                                           Color(0xff0f0c29),
                                                                           Color(0xff302b63)
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
                                                                           padding: const EdgeInsets.all(4.0),
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
                                                                               .all(4.0),
                                                                           child: Icon(
                                                                               Icons.arrow_forward_ios,
                                                                               size: 16,
                                                                               color: Colors.white),
                                                                         ),

                                                                       ],
                                                                     ),
                                                                   ),
                                                                 ),
                                                               ),
                                                             ),
                                                           ),
                                                         ],
                                                       ),
                                                       const Padding(
                                                         padding: EdgeInsets.all(8.0),
                                                         child: Image(
                                                           image: AssetImage(
                                                               'asset/Triva.png'),
                                                           height: 80,
                                                         ),
                                                       ),
                                                     ],
                                                   ),
                                                 ),
                                               ),
                                             ] else ...[
                                               Text(
                                                 'No Data Found',
                                                 style: GoogleFonts.poppins(
                                                     fontWeight: FontWeight.w600,
                                                     fontSize: 22),
                                               )
                                             ]
                                           ]);
                                         }),
                                    ),
                              ],
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            margin: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Image(image: AssetImage('asset/Add1.png')),
                                  ),
                                  loading
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
                                      : SizedBox(
                                    height: height/1,
                                    child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: result1.length,
                                        itemBuilder: (context, index) {
                                          return Column(children: [
                                            if (result1[index].id == 1) ...[
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xff1cd8d2),
                                                          Color(0xff93edc7)
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                      image: const DecorationImage(
                                                        image: AssetImage("asset/wave.png"),
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Naming Contest',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PreviousAppNameContest(
                                                                                result1[index]
                                                                                    .id
                                                                                    .toString())));
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
                                                                        20),
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
                                                                          20),
                                                                      gradient:
                                                                      const LinearGradient(
                                                                        colors: [
                                                                          Color(0xff1cd8d2),
                                                                          Color(0xff93edc7)
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
                                                                          padding: const EdgeInsets.all(4.0),
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
                                                                              .all(4.0),
                                                                          child: Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: 16,
                                                                              color: Colors.white),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'asset/AppName.png'),
                                                          height: 80,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ] else if (result1[index].id == 2) ...[
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xffad5389),
                                                          Color(0xff3c1053)
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                      image: const DecorationImage(
                                                        image: AssetImage("asset/wave.png"),
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Poetry Contest',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PreviousPoemContest(
                                                                                result1[index]
                                                                                    .id
                                                                                    .toString())));
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
                                                                        20),
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
                                                                          20),
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
                                                                          padding: const EdgeInsets.all(4.0),
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
                                                                              .all(4.0),
                                                                          child: Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: 16,
                                                                              color: Colors.white),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'asset/Poetry.png'),
                                                          height: 80,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ] else if (result1[index].id == 3) ...[
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xffa044ff),
                                                          Color(0xff6a3093)
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                      image: const DecorationImage(
                                                        image: AssetImage("asset/wave.png"),
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Image Contest',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PreviousImageContest(
                                                                                result1[index]
                                                                                    .id
                                                                                    .toString())));
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
                                                                        20),
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
                                                                          20),
                                                                      gradient:
                                                                      const LinearGradient(
                                                                        colors: [
                                                                          Color(0xffa044ff),
                                                                          Color(0xff6a3093)
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
                                                                          padding: const EdgeInsets.all(4.0),
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
                                                                              .all(4.0),
                                                                          child: Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: 16,
                                                                              color: Colors.white),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'asset/ImageContest.jpg'),
                                                          height: 80,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ] else if (result1[index].id == 4) ...[
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xff457fca),
                                                          Color(0xff5691c8)
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                      image: const DecorationImage(
                                                        image: AssetImage("asset/wave.png"),
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Quiz Contest',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PreviousQuizContest(
                                                                                result1[index]
                                                                                    .id
                                                                                    .toString())));
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
                                                                        20),
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
                                                                          20),
                                                                      gradient:
                                                                      const LinearGradient(
                                                                        colors: [
                                                                          Color(0xff457fca),
                                                                          Color(0xff5691c8)
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
                                                                          padding: const EdgeInsets.all(4.0),
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
                                                                              .all(4.0),
                                                                          child: Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: 16,
                                                                              color: Colors.white),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'asset/QuizContest.png'),
                                                          height: 80,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ] else if (result1[index].id == 5) ...[
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  height:
                                                  MediaQuery.of(context).size.height /
                                                      6,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(15),
                                                      gradient: const LinearGradient(
                                                        colors: [
                                                          Color(0xff0f0c29),
                                                          Color(0xff302b63)
                                                        ],
                                                        begin: Alignment.centerLeft,
                                                        end: Alignment.centerRight,
                                                      ),
                                                      image: const DecorationImage(
                                                        image: AssetImage("asset/wave.png"),
                                                        fit: BoxFit.fill,
                                                      )
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.center,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Trivia Contest',
                                                            style: GoogleFonts.poppins(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16),
                                                          ),
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets.all(
                                                                2.0),
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) =>
                                                                            PreviousTriviaContest(
                                                                                result1[index]
                                                                                    .id
                                                                                    .toString())));
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
                                                                        20),
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
                                                                          20),
                                                                      gradient:
                                                                      const LinearGradient(
                                                                        colors: [
                                                                          Color(0xff0f0c29),
                                                                          Color(0xff302b63)
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
                                                                          padding: const EdgeInsets.all(4.0),
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
                                                                              .all(4.0),
                                                                          child: Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              size: 16,
                                                                              color: Colors.white),
                                                                        ),

                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const Padding(
                                                        padding: EdgeInsets.all(8.0),
                                                        child: Image(
                                                          image: AssetImage(
                                                              'asset/Triva.png'),
                                                          height: 80,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ] else ...[
                                              Text(
                                                'No Data Found',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 22),
                                              )
                                            ]
                                          ]);
                                        }),
                                  ),
                                ],
                              ),
                          ),
                        ),
                      ],),
                  ),
                )
              ],
            ),
          ),
        // bottomNavigationBar: const BottomBar(),
        ),
      ),
    );
  }
}
//bottomNavigationBar: const BottomBar(),
//LatestContest(),
//PreviousContest(),