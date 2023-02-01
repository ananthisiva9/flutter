import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import '../CustomizedTracker.dart';
import '../ExerciseTracker.dart';
import 'Excercise_controller.dart';

class Exercise extends StatefulWidget {
  int id;
  Exercise(this.id);
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, ExerciseController controller) async {
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
        controller.fetchExercise();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(ExerciseController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: TextButton(
            onPressed: () {
              setState(() {
                _selectDate(context, controller);
              });
            },
            child: RichText(
              text: TextSpan(children: [
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
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.month.toString(),
          style: TextStyle(color: Colors.white),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white),
        ),
        Text(
          _date.year.toString(),
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExerciseController(
          context: context,
          customerid: widget.id.toString(),
          selectedDate: Global.getSelectedDate(_date)),
      child:
          Consumer<ExerciseController>(builder: (context, controller, child) {
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
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              _buildDate(controller),
                              _buildContainer(controller),
                            ],
                          )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchExercise();
                            }),
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContainer(ExerciseController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DefaultTabController(
                      length: 2,
                      initialIndex: 0,
                      child: Column(
                        children: <Widget>[
                          TabBar(indicatorColor: Color(0xffe41589), tabs: [
                            Tab(
                              text: 'Exercise Tracker',
                            ),
                            Tab(text: 'Customized Tracker'),
                          ]),
                          Container(
                            height: 850,
                            child: TabBarView(
                              children: <Widget>[
                                controller.model == null
                                    ? Center(
                                        child: Column(
                                          children: [
                                            ErrorRefreshIcon(onPressed: () {
                                              controller.changeState(
                                                  StateEnum.success);
                                            }),
                                            Text("No Response")
                                          ],
                                        ),
                                      )
                                    : ExerciseTracker(
                                        controller.allExercises,
                                        controller.model!.calorieBurnt == null
                                            ? "Not available"
                                            : controller.model!.calorieBurnt
                                                .toString()),
                                ExerciseCustomized(controller.customerid),
                              ],
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
