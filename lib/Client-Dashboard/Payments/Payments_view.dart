import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import '../DisplayScreen.dart';
import 'Payments_controller.dart';
import 'Payments_model.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PaymentsController(context),
      child:
          Consumer<PaymentsController>(builder: (context, controller, child) {
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
                title: Text(
                  'Payment',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.start,
                ),
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
                controller.state == StateEnum.loading
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Center(child: LoadingIcon()),
                      )
                    : controller.state == StateEnum.success
                        ? (controller.model!.items == null ||
                                controller.model!.items!.isEmpty)
                            ? Center(
                                child: Text(
                                  "No Payments Available",
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : Container(
                                child: new ListView.builder(
                                  itemBuilder: (_, int index) =>
                                      Data(controller.model!.items![index]),
                                  itemCount: controller.model!.items!.length,
                                ),
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchAllPayments();
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

class Data extends StatelessWidget {
  PaymentsItem item;
  Data(this.item);
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
          width: 400,
          child: Center(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/Client dummy.png'),
                    height: 75,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:  Column(
                      children: <Widget>[
                        Text(
                          item.doctorFirstname == null ||
                                  item.doctorLastname == null
                              ? "Not Available"
                              : ("Dr " +
                                  item.doctorFirstname.toString().capitalize() +
                                  " " +
                                  item.doctorLastname.toString().capitalize()),
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              item.doctorQualification == null
                                  ? "Not Available"
                                  : (item.doctorQualification
                                      .toString()
                                      .capitalize()),
                              style: GoogleFonts.poppins(
                                color: Colors.lightBlueAccent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              item.doctorExperience == null
                                  ? "Not Available"
                                  : (item.doctorExperience! +
                                      " years of Experience"),
                              style: GoogleFonts.poppins(
                                color: Colors.lightBlueAccent,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Divider(
                          height: 30,
                          thickness: .8,
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              height: 45,
                              width: 150,
                              margin: EdgeInsets.only(bottom: 20),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blue , // foreground (text) color
                                ),
                                onPressed: () {},
                                child: Text(
                                  item.payment == null
                                      ? "Not Available"
                                      : ("Paid " + item.payment.toString()),
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
      ),
    );
  }
}
