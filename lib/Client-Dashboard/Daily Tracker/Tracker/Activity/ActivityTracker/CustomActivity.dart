import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/AddNewTracker/Activity/Activity_view.dart.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../Activity_controller.dart';

class Custom extends StatelessWidget {
  Custom(this.controller);
  ActivityController controller;
  @override
  Widget build(BuildContext context) {
    if (controller.state == StateEnum.loading) {
      return Align(alignment: Alignment.topCenter, child: LoadingIcon());
    } else if (controller.state == StateEnum.success) {
      return Center(
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.1),
          ),
          width: 300,
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    controller.allCustom.isEmpty
                        ? Text(
                            "No Activity Available",
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontSize: 15)),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: controller.checkBoxState == StateEnum.loading
                                ? Center(child: LoadingIcon())
                                : GridView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: controller.allCustom.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 3/ 1,
                                            crossAxisCount: 1),
                                    itemBuilder: (_, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(25.0),
                                        child: Row(
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
                                                        .completed,
                                                    onChanged: (value) {
                                                      controller
                                                          .submitCustomActivity(
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
                                                      .allCustom[index].name.toString().capitalize(),
                                              style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
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
                                                AddActivity()),
                                      );
                                      controller.initialize();
                                    },
                                    child: Text(
                                      "Add New Activity",
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
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return ErrorRefreshIcon(onPressed: () {
        controller.fetchAllActivity();
      });
    }
  }
}
