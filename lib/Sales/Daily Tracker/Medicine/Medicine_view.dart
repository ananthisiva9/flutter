import 'package:admin_dashboard/Sales/Display/Display.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'Medicine_controller.dart';
import 'Medicine_model.dart';

class Medicine extends StatefulWidget {
  int id;
  Medicine(this.id);
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
        controller.selectedDate;
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
          padding: const EdgeInsets.all(8),
          child: TextButton(
              onPressed: () {
                // setState(() {
                _selectDate(context, controller);
                // });
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 15,
              )),
        ),
        Text(
          _date.day.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.month.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        const Text(
          '/',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        Text(
          _date.year.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 15),
        ),
        TextButton(
            onPressed: () {
              // setState(() {
              _selectDate(context, controller);
              // });
            },
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white,
              size: 15,
            )),
      ],
    );
  }

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MedicationController(
          context: context,
          customerid: widget.id.toString(),
          selectedDate: Global.getSelectedDate(_date)),
      child:
          Consumer<MedicationController>(builder: (context, controller, child) {
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
                  actions: [
                    GestureDetector(
                      child: Container(
                          margin: const EdgeInsets.only(right: 15),
                          child: IconButton(
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
                          child: const Center(child: const LoadingIcon()),
                        )
                      : controller.state == StateEnum.success
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
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
          borderRadius: const BorderRadius.only(
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
                      const Divider(
                        height: 50,
                      ),
                      Expanded(
                        child: Text(
                          "Medicine Tracker",
                          maxLines: 2,
                          style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildLunchbf(
                      controller.filterMedicine("afternoon before food"),
                      context,
                      controller),
                  Text(
                    "Lunch After Food",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
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
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildNightbf(controller.filterMedicine("night before food"),
                      context, controller),
                  Text(
                    "Night After Food",
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  _buildNightaf(controller.filterMedicine("night after food"),
                      context, controller),
                  const SizedBox(
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
            ? const Center(
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
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffe14589),
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
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
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
            ? const Center(
                child: const Text(
                  'No data available',
                  style: const TextStyle(
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
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffe14589),
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
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
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
            ? const Center(
                child: const Text(
                  'No data available',
                  style: const TextStyle(
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
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffe14589),
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
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
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
            ? const Center(
                child: const Text(
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
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffe14589),
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
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
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
            ? const Center(
                child: const Text(
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
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffe14589),
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
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
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
            ? const Center(
                child: const Text(
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
                            ? const SizedBox.shrink()
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                        unselectedWidgetColor:
                                            const Color(0xffe14589),
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
                                    model.medicines![index].name
                                        .toString()
                                        .capitalize(),
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
