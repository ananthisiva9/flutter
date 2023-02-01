import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Activity_controller.dart';
import 'Activity_model.dart';

class Activity extends StatefulWidget {
  int id;
  Activity(this.id);
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, ActivityController controller) async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (_datepicker != null && _datepicker != _date) {
      setState(() {
        _date = _datepicker;
        controller.changeDate(_date);
        controller.fetchActivity();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(ActivityController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextButton(
            onPressed: () {
              setState(() {
                _selectDate(context, controller);
              });
            },
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                  text: 'Select Date:',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]),
            ),
          ),
        ),
        Text(
          _date.day.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        const Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.month.toString(),
          style: const TextStyle(color: Colors.white),
        ),
        const Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.year.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ActivityController(
            customerid: widget.id.toString(),
            selectedDate: Global.getSelectedDate(_date),
            context: context),
        child:
            Consumer<ActivityController>(builder: (context, controller, child) {
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
                          child: const Center(child: LoadingIcon()),
                        )
                      : controller.state == StateEnum.success
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                _buildDate(controller),
                                _buildContainer(controller.model!.predefined),
                              ],
                            )
                          : Center(
                              child: ErrorRefreshIcon(onPressed: () {
                                controller.fetchActivity();
                              }),
                            ),
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildContainer(List<Predefined>? model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: const Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            //  child: SingleChildScrollView(
            child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: model!.length,
                itemBuilder: (_, int index) {
                  return Column(
                    children: <Widget>[
                      _buildAffermation(model[index], context),
                    ],
                  );
                }),
          ),
        ),
        //   ),
      ],
    );
  }
}

Widget _buildAffermation(Predefined model, BuildContext context) {
  return Container(
    height: 100,
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.black.withOpacity(0.1),
      ),
      height: 100,
      width: 400,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  model.mainModule.toString().capitalize() ?? "not Available",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: MediaQuery.of(context).size.width * .70,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: model.subModule!.length,
                      itemBuilder: (_, int index) {
                        return Column(
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  model.subModule![index].subModuleName
                                          .toString()
                                          .capitalize(),
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  model.subModule![index].completed
                                              .toString()
                                              .capitalize() ==
                                          true
                                      ? " -Completed"
                                      : " -Not Completed",
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
