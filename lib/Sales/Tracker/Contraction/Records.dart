import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'contraction_controller.dart';

class Records extends StatefulWidget {
  int id;
  Records(this.id);
  @override
  _RecordsState createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, ContractionController controller) async {
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
        controller.fetchAllContraction();
        print(
          _date.toString(),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ContractionController(
              customerid: widget.id.toString(),
              context: context,
              selectedDate: Global.getSelectedDate(_date),
            ),
        child: Consumer<ContractionController>(
            builder: (context, controller, child) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: Image.asset('assets/Background.png').image,
                    fit: BoxFit.cover)),
            child: Expanded(
              child: ListView.builder(
                  itemCount: controller.sortedMap.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 90,
                      width: 385,
                      child: ExpansionTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ListView.builder(
                                itemCount: controller.valueList[index].length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          controller.valueList[index][i]
                                                  .formatedTime ??
                                              "Time unavialable",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              controller.valueList[index][i]
                                                          .contraction ==
                                                      null
                                                  ? "Contraction unavailable"
                                                  : controller
                                                      .valueList[index][i]
                                                      .contraction
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              controller.valueList[index][i]
                                                      .formatedInterval ??
                                                  "Interval unavailable",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              controller.valueList[index][i]
                                                      .painScale ??
                                                  "Painscale unavailable",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          );
        }));
  }
}
