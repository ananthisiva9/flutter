import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'contraction_controller.dart';

class ContractionTracker extends StatefulWidget {
  @override
  _ContractionTrackerState createState() => _ContractionTrackerState();
}

class _ContractionTrackerState extends State<ContractionTracker> {
  @override

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ContractionController(
              context: context
            ),
        child: Consumer<ContractionController>(
            builder: (context, controller, child) {
          return SafeArea(
            child: Scaffold(
              body: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: Image.asset('assets/Background.png').image,
                            fit: BoxFit.cover)),
                  ),
                  controller.state == StateEnum.loading
                      ? Container(
                          height: double.infinity,
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Center(child: LoadingIcon()),
                        )
                      : controller.state == StateEnum.success
                          ? controller.model == null
                              ? Align(
                                  alignment: Alignment.topCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.all(75.0),
                                    child: Text(
                                      'No data available',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: 'Arial',
                                      ),
                                    ),
                                  ),
                                )
                              : (controller.model!.items == null ||
                                      controller.sortedMap.isEmpty)
                                  ? Align(
                                      alignment: Alignment.topCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.all(75.0),
                                        child: Text(
                                          'No data available',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Arial',
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: ListView.builder(
                                                itemCount:
                                                    controller.sortedMap.length,
                                                itemBuilder: (context, index) {
                                                  return SingleChildScrollView(
                                                    child: Container(
                                                      height: 350,
                                                      width: 280,
                                                      child: ExpansionTile(
                                                        title: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Text(
                                                              controller
                                                                      .keyList[
                                                                  index],
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                textStyle:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              children: <
                                                                  Widget>[
                                                               Text(
                                                                    controller
                                                                            .valueList[
                                                                                index]
                                                                            .first
                                                                            .formatedTime ??
                                                                        "Time unavailable",
                                                                    style: GoogleFonts
                                                                        .poppins(
                                                                      textStyle:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                              ],
                                                            ),
                                                            Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: <
                                                                  Widget>[
                                                                Text(
                                                                  controller
                                                                      .valueList[
                                                                          index]
                                                                      .length
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      letterSpacing:
                                                                          1.5,
                                                                      fontSize:
                                                                          20,
                                                                      fontFamily:
                                                                          'Gilroy'),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        children: <Widget>[
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  image: DecorationImage(
                                                                      image: Image.asset(
                                                                              'assets/Background.png')
                                                                          .image,
                                                                      fit: BoxFit
                                                                          .cover)),
                                                              height: 300,
                                                              child: ListView
                                                                  .builder(
                                                                      itemCount: controller
                                                                          .valueList[
                                                                              index]
                                                                          .length,
                                                                      itemBuilder:
                                                                          (context,
                                                                              i) {
                                                                        return Padding(
                                                                          padding:
                                                                              const EdgeInsets.all(8.0),
                                                                          child:
                                                                              Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceAround,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.center,
                                                                            children: <Widget>[
                                                                              Text(
                                                                                controller.valueList[index][i].formatedTime ?? "Time unavailable",
                                                                                style: TextStyle(
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0),
                                                                                child: Text(
                                                                                  controller.valueList[index][i].contraction == null ? "Contraction unavailable" : controller.valueList[index][i].contraction.toString(),
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 15.0),
                                                                                child: Text(
                                                                                  controller.valueList[index][i].formatedInterval ?? "Interval unavailable",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Padding(
                                                                                padding: const EdgeInsets.only(left: 30.0),
                                                                                child: Text(
                                                                                  controller.valueList[index][i].painScale ?? "PainsScale unavailable",
                                                                                  style: TextStyle(
                                                                                    color: Colors.white,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        );
                                                                      }),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ],
                                      ),
                                    )
                          : Center(
                              child: ErrorRefreshIcon(onPressed: () {
                                controller.fetchAllContraction();
                              }),
                            ),
                ],
              ),
            ),
          );
        }));
  }
}
