import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ImageHistory_model.dart';

class ImageHistory extends StatefulWidget {
  String? id;
  ImageHistory(this.id,{super.key});
  @override
  State<ImageHistory> createState() => _ImageHistoryState();
}

class _ImageHistoryState extends State<ImageHistory> {
  List<Datum> result = [];
  ScrollController scrollController = ScrollController();
  bool isLoading = true;
 int page = 1;
 var desc;
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
        '${ApiEndPoint.image_history}?history=${widget.id}';
    var response = await http.get(
      Uri.parse(baseUrl),
      headers: {"Authorization": "Token $token"},
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['code'] == 500) {
        desc = jsonDecode(response.body)['description'];
        print(desc);
        setState(() {
          result;
          isLoading = false;
        });
      } else {
        ImageHistoryModel model = ImageHistoryModel.fromJson(
            jsonDecode(response.body));

        result = result + model.data;
        int localpage = page + 1;

        setState(() {
          result;
          isLoading = false;
          page = localpage;
        });
      }
    }
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
      body: isLoading
          ? const Center(
          child:
          CircularProgressIndicator()) // this will show when loading is true
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(image: AssetImage('asset/Add1.png')),
            SizedBox(
              height: MediaQuery.of(context).size.height / 50,
            ),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : result.isEmpty || desc == "No Contest Image Data Available"
                ? Center(
              child: Text(
                desc,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
                textAlign: TextAlign.center,
              ),
            )
                :   SizedBox(
              height: MediaQuery.of(context).size.height / 1.9,
              child: GridView.builder(
                  gridDelegate:
                  const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 3 / 3,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20),
                  controller: scrollController,
                  itemCount: result.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.start,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Image Contest',
                                        style: GoogleFonts.poppins(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xff0093DD)),
                                      ),
                                    ),
                                    Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height /
                                          2.5,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          1,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: const Color(0xff666666),
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(5),
                                        color: Colors.white,
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.grey,
                                            blurRadius: 7.0,
                                            spreadRadius: 2.0,
                                            offset: Offset(0.0, 0.0),
                                          )
                                        ],
                                      ),
                                      child: Center(
                                        child: Image.network(
                                          result[index].url.toString(),
                                          fit: BoxFit.fill,
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 130.0),
                                      child: Text(
                                        'Uploaded Date ${result[index].date}',
                                        style: GoogleFonts.poppins(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 2.5,
                        width: MediaQuery.of(context).size.width / 1,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff666666),
                          ),
                        ),
                        child: (result[index].url.toString() != null)
                            ? Image.network(
                          result[index].url.toString(),
                          fit: BoxFit.fill,
                          height:
                          MediaQuery.of(context).size.height,
                          width:
                          MediaQuery.of(context).size.width / 1,
                        )
                            : Icon(Icons.person_rounded,
                            size: MediaQuery.of(context).size.height /
                                8,
                            color: const Color(0xff0093DD)),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
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
    );
  }
}
