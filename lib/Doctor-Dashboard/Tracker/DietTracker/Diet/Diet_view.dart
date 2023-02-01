import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Doctor-Dashboard/Tracker/DietTracker/CustomizedTracker.dart';
import 'package:shebirth/Login/Login_model.dart';
import 'package:shebirth/utility/global.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import '../DietTracker.dart';
import 'Diet_controller.dart';

class Diet extends StatefulWidget {
  int id;
  Diet(this.id);
  @override
  _DietState createState() => _DietState();
}

class _DietState extends State<Diet> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, DietController controller) async {
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
        controller.fetchDiet();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(DietController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        TextButton(
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
      create: (context) => DietController(
          context: context,
          customerid: widget.id.toString(),
          selectedDate: Global.getSelectedDate(_date)),
      child: Consumer<DietController>(builder: (context, controller, child) {
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
                              controller.fetchDiet();
                            }),
                          ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildContainer(DietController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: controller.model == null
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
                : SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        DefaultTabController(
                            length: 2,
                            initialIndex: 0,
                            child: Column(
                              children: <Widget>[
                                TabBar(
                                    indicatorColor: Color(0xffe41589),
                                    tabs: [
                                      Tab(
                                        text: 'Diet Tracker',
                                      ),
                                      Tab(text: 'Customized Tracker'),
                                    ]),
                                Container(
                                  height: 700,
                                  child: TabBarView(
                                    children: <Widget>[
                                      DietTracker(controller.model!.diet),
                                      DietCustomized(controller.customerid),
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

getToken() async {
  dynamic userDetails = await Global.getUserDetails();
  if (userDetails != null && userDetails is LoginModel) {
    return userDetails.token;
  }
}
