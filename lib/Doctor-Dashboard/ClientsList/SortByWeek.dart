import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SortByWeek extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SortByWeekState();
}

class _SortByWeekState extends State<SortByWeek> {
  List<List<int>> items = [
    [4, 8],
    [8, 12],
    [12, 16],
    [16, 20],
    [20, 24],
    [24, 28],
    [28, 32],
    [32, 36],
    [36, 40],
    [40, 44]
  ];
  bool isDescending = false;
  int selectedValue = 0;
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/appbar.jpeg'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        elevation: 0,
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.notifications_rounded,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 850,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Background.png'),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                children: [
                  TextButton.icon(
                    icon: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(Icons.compare_arrows, size: 28),
                    ),
                    label: Text(
                      isDescending ? 'Descending' : 'Ascending',
                      style: TextStyle(fontSize: 16),
                    ),
                    onPressed: () => setState(
                          () {
                        isDescending = !isDescending;
                      },
                    ),
                  ),
                  Expanded(child: buildList()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildList() => ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final sortedItems = isDescending ? items.reversed.toList() : items;
        final item = sortedItems[index];
        return ListTile(
          leading: Radio(
            activeColor: Colors.white,
            value: 1,
            groupValue: selectedValue,
            onChanged: (value) => setState(() {
              selectedValue = 1;
              Navigator.pop(context, item);
            }),
          ),
          title: Text(
            item.first.toString() + "-" + item.last.toString() + " week",
            style: TextStyle(color: Colors.white),
          ),
        );
      });
}
