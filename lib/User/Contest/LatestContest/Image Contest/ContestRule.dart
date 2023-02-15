import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Image.dart';

class ImageContestRules extends StatefulWidget {
  String? rules;
     int id, type;
  ImageContestRules(this.id, this.type,this.rules,{super.key});
  @override
  State<ImageContestRules> createState() => _ImageContestRulesState();
}

class _ImageContestRulesState extends State<ImageContestRules> {
  // ignore: prefer_typing_uninitialized_variable
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Image Contest Rule', style: TextStyle(fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white),),
        flexibleSpace:  Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0xffa044ff),
                  Color(0xff6a3093)]),
          ),
        ),
       /* shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),*/
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height /1.5 ,
                width: MediaQuery.of(context).size.width / 1,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: HtmlWidget(
                              "<div style='color:black;font-size:20px;';>${widget.rules}</div"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                //LogEnd();
                // ignore: unrelated_type_equality_checks
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) =>
                    ImageContest(
                        widget.id,
                        widget.type)));
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
                          Color(0xffa044ff),
                          Color(0xff6a3093)
                        ],
                        begin: Alignment
                            .centerLeft,
                        end: Alignment
                            .centerRight,
                      ),
                    ),
                    child: Padding(
                      padding:
                      const EdgeInsets
                          .all(
                          4.0),
                      child: Center(
                        child: Text(
                          "Let's Play",
                          style: GoogleFonts.poppins(
                              fontSize:
                              20,
                              fontWeight:
                              FontWeight
                                  .w600,
                              color: Colors
                                  .white),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
           const Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(image: AssetImage('asset/Add3.png')),
            ),
          ],
        ),
      ),
    );
  }
}
