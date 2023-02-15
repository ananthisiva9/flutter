import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Quiz_model.dart';

class QuizHistory extends StatefulWidget {
  String? id;
  QuizHistory(this.id, {super.key});
  @override
  State<QuizHistory> createState() => _QuizHistoryState();
}

class _QuizHistoryState extends State<QuizHistory> {
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
        '${ApiEndPoint.quiz_score}?page=$parapage&limit=20&history=${widget.id}';
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Token $token"},
    );

    QuizModel model = QuizModel.fromJson(jsonDecode(response.body));

    result = result + model.data;
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
          :  Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Image(image: AssetImage('asset/Add1.png')),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                   ),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : result.isEmpty
                        ?
                            Text(
                            "No Contest Data Available",
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                              textAlign: TextAlign.center,
                        )
                        :
                    DataTable(
                      showCheckboxColumn: false,
                      dataRowHeight: 55,
                      headingRowHeight: 60,
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.blueGrey),
                      columns: [
                        DataColumn(
                          label: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("Score",
                                style: GoogleFonts.poppins(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                                textAlign: TextAlign.start),
                          ),
                        ),
                        DataColumn(
                            label: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
                              "Date",
                              style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                              textAlign: TextAlign.start,
                            ),
                          ),
                        )),
                      ],
                      rows: List.generate(
                        result.length,
                        (index) {
                          return DataRow(
                              color: MaterialStateColor.resolveWith((states) {
                                return index % 2 == 0
                                    ? const Color(0xffD3D3D3)
                                    : const Color(0xffE5E4E2); //make tha magic!
                              }),
                              cells: <DataCell>[
                                DataCell(
                                  Text(
                                    result[index].score.toString(),
                                    style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    result[index].date,
                                    style: GoogleFonts.poppins(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ]);
                        },
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage('asset/Add3.png')),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 80,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
