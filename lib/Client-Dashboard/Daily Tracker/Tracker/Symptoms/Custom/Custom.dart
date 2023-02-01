import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/AddNewTracker/Activity/Activity_view.dart.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/AddNewTracker/Symptoms/Symptoms_view.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';

import '../Symptoms_controller.dart';

class Custom extends StatelessWidget {
  Custom(this.controller);
  SymptomController controller;
  @override
  Widget build(BuildContext context) {
    if (controller.state == StateEnum.loading) {
      return Align(alignment: Alignment.topCenter, child: LoadingIcon());
    } else if (controller.state == StateEnum.success) {
      return Container(
        height: 750,
        width: 300,
        padding: const EdgeInsets.all(5.0),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    controller.allCustom.isEmpty
                        ? Text(
                            "No Symptoms Available",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          )
                        : Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.1),
                              ),
                              width: 500,
                              child: controller.checkBoxState ==
                                      StateEnum.loading
                                  ? Center(child: LoadingIcon())
                                  : GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: controller.allCustom.length,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 3 / 1,
                                              crossAxisCount: 1),
                                      itemBuilder: (_, index) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Theme(
                                                data:
                                                    Theme.of(context).copyWith(
                                                  unselectedWidgetColor:
                                                      Color(0xffe14589),
                                                ),
                                                child: Checkbox(
                                                    value: controller
                                                        .allCustom[index]
                                                        .positive,
                                                    onChanged: (value) {
                                                      controller
                                                          .submitCustomSymptom(
                                                              controller
                                                                  .allCustom[
                                                                      index]
                                                                  .id!
                                                                  .toString(),
                                                              value!,
                                                              context,
                                                              index);
                                                    }),
                                              ),
                                            ),
                                            Text(
                                              controller
                                                      .allCustom[index].name ??
                                                  "Name Unavailable",
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                            ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddSymptoms()),
                                      );
                                      controller.initialize();
                                    },
                                    child: Text(
                                      "Add New Symptoms",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 1.5,
                                        fontSize: 15,
                                        fontFamily: 'Avenir',
                                      ),
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 200,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ErrorRefreshIcon(onPressed: () {
        controller.fetchAllSymptom();
      });
    }
  }
}
