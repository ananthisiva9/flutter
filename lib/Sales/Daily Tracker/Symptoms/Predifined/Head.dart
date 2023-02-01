import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../Symptoms_controller.dart';
import '../Symptoms_model.dart';

class Head extends StatefulWidget {
  Head(this.controller);
  SymptomController controller;
  @override
  State<Head> createState() => _HeadState();
}

class _HeadState extends State<Head> {
  List<Symptom> ll = [];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < widget.controller.allSymptom.length; i++) {
      if (widget.controller.allSymptom[i].category == "Head") {
        ll.add(Symptom(
            id: widget.controller.allSymptom[i].id,
            positive: widget.controller.allSymptom[i].positive,
            category: widget.controller.allSymptom[i].category,
            name: widget.controller.allSymptom[i].name));
      }
    }
    ;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.state == StateEnum.loading) {
      return Align(alignment: Alignment.topCenter, child: LoadingIcon());
    } else if (widget.controller.state == StateEnum.success) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(5.0),
            height: 10000,
            width: 300,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      widget.controller.allSymptom.isEmpty
                          ? Text("No data")
                          : Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                              ),
                              child: widget.controller.checkBoxState ==
                                      StateEnum.loading
                                  ? Center(child: LoadingIcon())
                                  : Column(
                                      children: [
                                        (widget.controller.model!.Symptoms ==
                                                    null ||
                                                widget.controller.model!
                                                    .Symptoms!.isEmpty)
                                            ? SizedBox.shrink()
                                            : Center(
                                                child: Text(
                                                "Head",
                                                style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        GridView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: ll.length,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  childAspectRatio: 5 / 1,
                                                  crossAxisCount: 1),
                                          itemBuilder: (_, index) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Theme(
                                                    data: Theme.of(context)
                                                        .copyWith(
                                                      unselectedWidgetColor:
                                                          Color(0xffe14589),
                                                    ),
                                                    child: Checkbox(
                                                        value:
                                                            ll[index].positive,
                                                        onChanged: (value) {
                                                          widget.controller
                                                              .submitPredifinedSymptom(
                                                                  ll[index]
                                                                      .id!
                                                                      .toString(),
                                                                  value!,
                                                                  context,
                                                                  index);
                                                        }),
                                                  ),
                                                ),
                                                Text(
                                                  ll[index]
                                                      .name
                                                      .toString()
                                                      .capitalize(),
                                                  style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                            ),
                      SizedBox(
                        height: 200,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return ErrorRefreshIcon(onPressed: () {
        widget.controller.fetchAllSymptom();
      });
    }
  }
}
