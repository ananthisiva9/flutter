import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/AddNewTracker/Medicine/MedicineTracker_View.dart';
import 'package:shebirth/Client-Dashboard/Daily%20Tracker/Tracker/Medicine/Medicine_model.dart';
import 'package:shebirth/Client-Dashboard/DisplayScreen.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Medicine_controller.dart';

class Medicine extends StatefulWidget {
  @override
  _MedicineState createState() => _MedicineState();
}

class _MedicineState extends State<Medicine> {
  DateTime _date = DateTime.now();
  Future<Null> _selectDate(
      BuildContext context, MedicationController controller) async {
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
        controller.fetchAllMedicines();
        print(
          _date.toString(),
        );
      });
    }
  }

  Widget _buildDate(BuildContext context, MedicationController controller) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(8),
          child: TextButton(
              onPressed: () {
                // setState(() {
                _selectDate(context, controller);
                // });
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              )),
        ),
        Text(
          _date.day.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.month.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.year.toString(),
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        TextButton(
            onPressed: () {
              // setState(() {
              _selectDate(context, controller);
              // });
            },
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            )),
      ],
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Hi , SuperMom',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicationController(context)..initialize(),
      child:
          Consumer<MedicationController>(builder: (context, controller, child) {
        return SafeArea(
          child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(60),
                child: AppBar(
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
                      child:Container(
                          margin: EdgeInsets.only(right: 15),
                          child: IconButton(
                            icon: Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ClientDisplay(),
                                ),
                              );
                            },
                          )),
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
                                _buildName(),
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Image(
                                    alignment: Alignment.bottomRight,
                                    image:
                                        AssetImage('assets/Motherhood-bro.png'),
                                  ),
                                ),
                                SingleChildScrollView(
                                    child:
                                        _buildContainer(controller, context)),
                              ],
                            )
                          : Center(
                              child: ErrorRefreshIcon(onPressed: () {
                                controller.fetchAllMedicines();
                              }),
                            ),
                ],
              )),
        );
      }),
    );
  }

  Widget _buildContainer(
      MedicationController controller, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Divider(
                        height: 50,
                      ),
                      Expanded(
                        child: Text(
                          "Medicine Tracker",
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      _buildDate(context, controller),
                    ],
                  ),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  Text(
                    "Morning Before Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildMorningbf(
                      controller.filterMedicine("morning before food"),
                      context,
                      controller),
                  Text(
                    "Morning After Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildMorningaf(
                      controller.filterMedicine("morning after food"),
                      context,
                      controller),
                  Text(
                    "Lunch Before Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildLunchbf(
                      controller.filterMedicine("afternoon before food"),context,
                      controller),
                  Text(
                    "Lunch After Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildLunchaf(
                      controller.filterMedicine("afternoon after food"),
                      context,
                      controller),
                  Text(
                    "Night Before Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildNightbf(controller.filterMedicine("night before food"),
                      context,
                      controller),
                  Text(
                    "Night After Food",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildNightaf(controller.filterMedicine("night after food"),
                      context,
                      controller),
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
                                              AddMedicine()),
                                    );
                                    controller.initialize();
                                  },
                                  child: Text(
                                    "Add New Medicine",
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
                    height: 250,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildMorningbf(MedicineModelItem? model, BuildContext context,
    MedicationController controller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 280,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1),
        ),
        child: (model == null)
            ? Center(
                child: Text(
                  'No data available',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Arial',
                  ),
                ),
              )
            : ListView.builder(
                itemBuilder: (_, index) => Stack(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        model.medicines![index] == true && false
                            ? SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor: Color(0xffe14589),
                                      ),
                                      child: Checkbox(
                                          value: model.medicines![index].taken,
                                          onChanged: (value) {
                                            controller.submitMedicines(
                                                model.medicines![index].id!
                                                    .toString(),
                                                value!,
                                                context,
                                                index);
                                          }),
                                    ),
                                  ),
                                  Text(
                                    model.medicines![index].name.toString().capitalize(),
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ],
                    ),
                  ],
                ),
                itemCount: model.medicines!.length,
                scrollDirection: Axis.vertical,
              ),
      ),
    ),
  );
}

Widget _buildMorningaf(MedicineModelItem? model, BuildContext context,
    MedicationController controller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 280,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1),
        ),
        child: (model == null)
            ? Center(
          child: Text(
            'No data available',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
        )
            : ListView.builder(
          itemBuilder: (_, index) => Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  model.medicines![index] == true && false
                      ? SizedBox.shrink()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffe14589),
                          ),
                          child: Checkbox(
                              value: model.medicines![index].taken,
                              onChanged: (value) {
                                controller.submitMedicines(
                                    model.medicines![index].id!
                                        .toString(),
                                    value!,
                                    context,
                                    index);
                              }),
                        ),
                      ),
                      Text(
                        model.medicines![index].name.toString().capitalize(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          itemCount: model.medicines!.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    ),
  );
}

Widget _buildLunchbf(MedicineModelItem? model, BuildContext context,
    MedicationController controller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 280,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1),
        ),
        child: (model == null)
            ? Center(
          child: Text(
            'No data available',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
        )
            : ListView.builder(
          itemBuilder: (_, index) => Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  model.medicines![index] == true && false
                      ? SizedBox.shrink()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffe14589),
                          ),
                          child: Checkbox(
                              value: model.medicines![index].taken,
                              onChanged: (value) {
                                controller.submitMedicines(
                                    model.medicines![index].id!
                                        .toString(),
                                    value!,
                                    context,
                                    index);
                              }),
                        ),
                      ),
                      Text(
                        model.medicines![index].name.toString().capitalize(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          itemCount: model.medicines!.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    ),
  );
}

Widget _buildLunchaf(MedicineModelItem? model, BuildContext context,
    MedicationController controller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 280,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1),
        ),
        child: (model == null)
            ? Center(
          child: Text(
            'No data available',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
        )
            : ListView.builder(
          itemBuilder: (_, index) => Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  model.medicines![index] == true && false
                      ? SizedBox.shrink()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffe14589),
                          ),
                          child: Checkbox(
                              value: model.medicines![index].taken,
                              onChanged: (value) {
                                controller.submitMedicines(
                                    model.medicines![index].id!
                                        .toString(),
                                    value!,
                                    context,
                                    index);
                              }),
                        ),
                      ),
                      Text(
                        model.medicines![index].name.toString().capitalize(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          itemCount: model.medicines!.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    ),
  );
}

Widget _buildNightbf(MedicineModelItem? model, BuildContext context,
    MedicationController controller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 280,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1),
        ),
        child: (model == null)
            ? Center(
          child: Text(
            'No data available',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
        )
            : ListView.builder(
          itemBuilder: (_, index) => Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  model.medicines![index] == true && false
                      ? SizedBox.shrink()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffe14589),
                          ),
                          child: Checkbox(
                              value: model.medicines![index].taken,
                              onChanged: (value) {
                                controller.submitMedicines(
                                    model.medicines![index].id!
                                        .toString(),
                                    value!,
                                    context,
                                    index);
                              }),
                        ),
                      ),
                      Text(
                        model.medicines![index].name.toString().capitalize(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          itemCount: model.medicines!.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    ),
  );
}

Widget _buildNightaf(MedicineModelItem? model, BuildContext context,
    MedicationController controller) {
  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 150,
        width: 280,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black.withOpacity(0.1),
        ),
        child: (model == null)
            ? Center(
          child: Text(
            'No data available',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Arial',
            ),
          ),
        )
            : ListView.builder(
          itemBuilder: (_, index) => Stack(
            children: <Widget>[
              Column(
                children: <Widget>[
                  model.medicines![index] == true && false
                      ? SizedBox.shrink()
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Theme(
                          data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Color(0xffe14589),
                          ),
                          child: Checkbox(
                              value: model.medicines![index].taken,
                              onChanged: (value) {
                                controller.submitMedicines(
                                    model.medicines![index].id!
                                        .toString(),
                                    value!,
                                    context,
                                    index);
                              }),
                        ),
                      ),
                      Text(
                        model.medicines![index].name.toString().capitalize(),
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          itemCount: model.medicines!.length,
          scrollDirection: Axis.vertical,
        ),
      ),
    ),
  );
}
