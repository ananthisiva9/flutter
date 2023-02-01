import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../Exercise_controller.dart';

class ExerciseTracker extends StatelessWidget {
  ExerciseTracker(this.controller);
  ExerciseController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.state == StateEnum.loading) {
      return Align(alignment: Alignment.topCenter, child: LoadingIcon());
    } else if (controller.state == StateEnum.success) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withOpacity(0.1),
          ),
              height: 30,
              width: 300,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        controller.videoState == StateEnum.loading
                            ? Align(
                                alignment: Alignment.topCenter,
                                child: LoadingIcon())
                            : controller.videoState == StateEnum.success
                                ? YoutubePlayerControllerProvider(
                                    controller: controller.youtubeController,
                                    child: YoutubePlayerIFrame(
                                      controller: controller.youtubeController,
                                    ),
                                  )
                                : ErrorRefreshIcon(
                                    errorMessage: "Error loading the video",
                                    onPressed: () {
                                      controller.fetchAllExercises();
                                    }),
                        Divider(
                          height: 30,
                          thickness: .8,
                          color: Colors.white.withOpacity(0.5),
                        ),
                        controller.allExercises.isEmpty
                            ? Text("No data")
                            : Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                ),
                                child: controller.checkBoxState ==
                                        StateEnum.loading
                                    ? Center(child: LoadingIcon())
                                    : Column(
                                        children: [
                                          (controller.model!.exercises ==
                                                      null ||
                                                  controller.model!.exercises!
                                                      .isEmpty)
                                              ? SizedBox.shrink()
                                              : GridView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                      .model!.exercises!.length,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          childAspectRatio:
                                                              6 / 1,
                                                          crossAxisCount: 1),
                                                  itemBuilder: (_, index) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                              unselectedWidgetColor:
                                                                  Color(
                                                                      0xffe14589),
                                                            ),
                                                            child: Checkbox(
                                                                value: controller
                                                                    .model!
                                                                    .exercises![
                                                                        index]
                                                                    .completed,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .submitExcercise(
                                                                          value!,
                                                                          context,
                                                                          index);
                                                                }),
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                                  .model!
                                                                  .exercises![
                                                                      index]
                                                                  .name.toString().capitalize(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                          Divider(
                                            height: 30,
                                          ),
                                          (controller.model!.custom == null ||
                                                  controller
                                                      .model!.custom!.isEmpty)
                                              ? SizedBox.shrink()
                                              : GridView.builder(
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  itemCount: controller
                                                      .model!.custom!.length,
                                                  shrinkWrap: true,
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          childAspectRatio:
                                                              6 / 1,
                                                          crossAxisCount: 1),
                                                  itemBuilder: (_, index) {
                                                    return Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10.0),
                                                          child: Theme(
                                                            data: Theme.of(
                                                                    context)
                                                                .copyWith(
                                                              unselectedWidgetColor:
                                                                  Color(
                                                                      0xffe14589),
                                                            ),
                                                            child: Checkbox(
                                                                value: controller
                                                                    .model!
                                                                    .exercises![
                                                                        index]
                                                                    .completed,
                                                                onChanged:
                                                                    (value) {
                                                                  controller
                                                                      .submitExcercise(
                                                                          value!,
                                                                          context,
                                                                          index);
                                                                }),
                                                          ),
                                                        ),
                                                        Text(
                                                          controller
                                                                  .model!
                                                                  .custom![
                                                                      index]
                                                                  .name.toString().capitalize(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle:
                                                                TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
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
                        Divider(
                          height: 15,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Total Colorizes Burned",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        controller.caloriesState == StateEnum.loading
                            ? Center(child: LoadingIcon())
                            : TextField(
                                style: TextStyle(color: Colors.white),
                                cursorColor: Colors.white,
                                keyboardType: TextInputType.text,
                                controller: controller.caloriesController,
                                decoration: InputDecoration(
                                  hintText: 'Energy',
                                  hintStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontFamily: 'Avenir'),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                ),
                              ),
                        Divider(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height:
                                  1 * (MediaQuery.of(context).size.height / 20),
                              width:
                                  3 * (MediaQuery.of(context).size.width / 08),
                              margin: EdgeInsets.only(bottom: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {
                                  if (controller
                                      .caloriesController.text.isEmpty) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          "Enter the total calories burned"),
                                      backgroundColor: Colors.red,
                                    ));
                                  } else {
                                    if (controller.caloriesState !=
                                        StateEnum.loading) {
                                      controller.submitCalories();
                                    }
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 20,
                                    fontFamily: 'Avenir',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () async {

                                },
                                child: Text(
                                  "Add New Exercise",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    letterSpacing: 1.5,
                                    fontSize: 15,
                                  ),
                                ))
                          ],
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
        controller.fetchAllExercises();
      });
    }
  }
}
