import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Completed_controller.dart';
import 'Completed_model.dart';

class Completed extends StatefulWidget {
  String id;
  Completed(this.id);
  @override
  _CompletedState createState() => _CompletedState();
}

class _CompletedState extends State<Completed> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CompletedController(
          customerid: widget.id.toString(), context: context),
      child:
      Consumer<CompletedController>(builder: (context, controller, child) {
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
                title: const Text(
                  'Completed Appointment',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Arial',
                  ),
                  textAlign: TextAlign.start,
                ),
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
                  child: const Center(child: LoadingIcon()),
                )
                    : controller.state == StateEnum.success
                    ? (controller.model == null ||
                    controller.model!.data == null ||
                    controller.model!.data!.appointments!.isEmpty
                    ? const Center(
                  child: Text("No Appointment available",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Gilroy')),
                )
                    : Container(
                  child: ListView.builder(
                    itemCount: controller
                        .model!.data!.appointments!.length,
                    itemBuilder: (_, int index) {
                      if (controller.model!.data!
                          .appointments?[index] !=
                          null) {
                        return Model(
                            controller.model!.data!
                                .appointments![index],
                            controller.model!.data!);
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ))
                    : Center(
                  child: ErrorRefreshIcon(onPressed: () {
                    controller.fetchGetDoctor();
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class Model extends StatefulWidget {
  Model(this.item, this.model);
  Appointments item;
  Data model;
  @override
  State<Model> createState() => _ModelState();
}

class _ModelState extends State<Model> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 180,
        width: 380,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: widget.item.customer!.user!.profileImg == null
                  ? CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage:
                const AssetImage('assets/Client dummy.png'),
                radius: 35,
              )
                  : CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: NetworkImage(
                  widget.item.customer!.user!.profileImg.toString(),
                ),
                radius: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  Text(
                    widget.item.customer!.user!.firstname == null ||
                        widget.item.customer!.user!.lastname == null
                        ? "Name Unavailable"
                        : (widget.item.customer!.user!.firstname! +
                        " " +
                        widget.item.customer!.user!.lastname!),
                    style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Age : " + widget.item.customer!.age.toString(),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Price : " + widget.item.doctor!.price.toString(),
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 30,
                    color: Colors.white,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Date : " + widget.item.date.toString(),
                            style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            "Time : " + widget.item.time.toString(),
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
            ),
          ],
        ),
      ),
    );
  }
}
