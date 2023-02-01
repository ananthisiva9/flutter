import 'package:admin_dashboard/Admin/Display/Display.dart';
import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'NormalRange.dart';
import 'NormalValue.dart';

class Report extends StatefulWidget {
  int id;
  Report(this.id);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context) async {
    DateTime? _datepicker = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
    if (_datepicker != null && _datepicker != _date) {
      setState(() {
        _date = _datepicker;
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextButton(
            onPressed: () {
              setState(() {
                _selectDate(context);
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: AppBar(
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/appbar.jpeg'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            elevation: 0,
            title: Text(
              'Investigation Report',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.start,
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SalesDisplay(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                _buildDate(),
                _buildContainer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 1.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.asset('assets/Background.png').image,
                  fit: BoxFit.cover),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: <Widget>[
                        const TabBar(indicatorColor: Color(0xffe41589), tabs: [
                          Tab(text: 'Enter Value'),
                          Tab(text: 'Normal Range'),
                        ]),
                        SingleChildScrollView(
                          child: Container(
                            height: 400,
                            child: TabBarView(
                              children: <Widget>[
                                NormalValue(widget.id,_date.toString()),
                                NormalRange(widget.id,_date.toString()),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
