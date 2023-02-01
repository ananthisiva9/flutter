import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import '../../../DisplayScreen.dart';
import 'MedicineTracker_Controller.dart';

class AddMedicine extends StatefulWidget {
  @override
  _AddMedicineState createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final TextEditingController _morningbf = TextEditingController();
  final TextEditingController _morningaf = TextEditingController();
  final TextEditingController _afternoonbf = TextEditingController();
  final TextEditingController _afternoonaf = TextEditingController();
  final TextEditingController _nightaf = TextEditingController();
  final TextEditingController _nightbf = TextEditingController();

  int _currentIndex = 0;
  Widget _buildName() {
    //print(DateTime.now().toString().split(':').first);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Hi , SuperMom',
            style: GoogleFonts.poppins(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AddMedicineController(context),
        child: Consumer<AddMedicineController>(
            builder: (context, controller, child) {
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
                      child: Container(
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      _buildName(),
                      Padding(
                        padding: EdgeInsets.all(20),
                        child: Image(
                          alignment: Alignment.bottomRight,
                          image: AssetImage('assets/Motherhood-bro.png'),
                        ),
                      ),
                      _buildContainer(controller),
                    ],
                  ),
                ],
              ),
            ),
          );
        }));
  }

  Widget _buildContainer(AddMedicineController controller) {
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
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 20,
                    color: Colors.white.withOpacity(0.3),
                  ),
                  _buildMorningbf(controller, _morningbf),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildMorningaf(controller, _morningaf),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildAfternoonbf(controller, _afternoonbf),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildAfternoonaf(controller, _afternoonaf),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildNightbf(controller, _nightbf),
                  Divider(
                    height: 20,
                    thickness: .1,
                    color: Colors.white.withOpacity(0.5),
                  ),
                  _buildNightaf(controller, _nightaf),
                  SizedBox(
                    height: 300,
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

Widget _buildMorningbf(
    AddMedicineController controller, TextEditingController _morningbf) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 150,
      width: 350,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Morning Before Food",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  controller: _morningbf,
                  decoration: InputDecoration(
                    hintText: 'Enter Medicine',
                    hintStyle:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),// foreground (text) color
                        ),
                        onPressed: () {
                          controller.addNewMedicine(
                            _morningbf.text,
                            "morning before food",
                          );
                          _morningbf.clear();
                        },
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildMorningaf(
    AddMedicineController controller, TextEditingController _morningaf) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 150,
      width: 350,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Morning After Food",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  controller: _morningaf,
                  decoration: InputDecoration(
                    hintText: 'Enter Medicine',
                    hintStyle:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),// foreground (text) color
                        ),
                        onPressed: () {
                          controller.addNewMedicine(
                              _morningaf.text, "morning after food");
                          _morningaf.clear();
                        },
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAfternoonbf(
    AddMedicineController controller, TextEditingController _afternoonbf) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 150,
      width: 350,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Afternoon Before Food",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  controller: _afternoonbf,
                  decoration: InputDecoration(
                    hintText: 'Enter Medicine',
                    hintStyle:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),// foreground (text) color
                        ),
                        onPressed: () {
                          controller.addNewMedicine(
                              _afternoonbf.text, "afternoon before food");
                          _afternoonbf.clear();
                        },
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildAfternoonaf(
    AddMedicineController controller, TextEditingController _afternoonaf) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 150,
      width: 350,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Afternoon After Food",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  controller: _afternoonaf,
                  decoration: InputDecoration(
                    hintText: 'Enter Medicine',
                    hintStyle:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),// foreground (text) color
                        ),
                        onPressed: () {
                          controller.addNewMedicine(
                              _afternoonaf.text, "afternoon after food");
                          _afternoonaf.clear();
                        },
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildNightbf(
    AddMedicineController controller, TextEditingController _nightbf) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 150,
      width: 350,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Night Before Food",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  controller: _nightbf,
                  decoration: InputDecoration(
                    hintText: 'Enter Medicine',
                    hintStyle:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),// foreground (text) color
                        ),
                        onPressed: () {
                          controller.addNewMedicine(
                            _nightbf.text,
                            "night before food",
                          );
                          _nightbf.clear();
                        },
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildNightaf(
    AddMedicineController controller, TextEditingController _nightaf) {
  return Center(
    child: Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white.withOpacity(0.1),
      ),
      height: 150,
      width: 350,
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(
                  "Night After Food",
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextField(
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  keyboardType: TextInputType.text,
                  controller: _nightaf,
                  decoration: InputDecoration(
                    hintText: 'Enter Medicine',
                    hintStyle:
                        GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green ,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),// foreground (text) color
                        ),
                        onPressed: () {
                          controller.addNewMedicine(
                              _nightaf.text, "night after food");
                          _nightaf.clear();
                        },
                        child: Text(
                          "Add",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
