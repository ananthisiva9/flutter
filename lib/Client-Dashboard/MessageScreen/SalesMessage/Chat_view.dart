import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shebirth/Client-Dashboard/MessageScreen/Massage/Message.dart';
import 'package:shebirth/utility/state_enum.dart';
import 'package:shebirth/widgets/error_refresh_icon.dart';
import 'package:shebirth/widgets/loading_icon.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'chat_controller.dart';
import 'chat_model.dart';

class SalesChat extends StatefulWidget {
  @override
  _SalesChatState createState() => _SalesChatState();
}

class _SalesChatState extends State<SalesChat> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SalesController(context),
      child: Consumer<SalesController>(builder: (context, controller, child) {
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
                        height: 1000,
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Center(child: LoadingIcon()),
                      )
                    : controller.state == StateEnum.success
                        ? (controller.model != null &&
                                controller.model!.details != null &&
                                controller.model!.details!.isNotEmpty)
                            ? Container(
                                child: new ListView.builder(
                                  itemBuilder: (_, int index) =>
                                      Data(controller.model!.details![index]),
                                  itemCount: controller.model!.details!.length,
                                ),
                              )
                            : Center(
                                child: Text(
                                  "No Clients Available",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: 'Arial',
                                  ),
                                ),
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchAllSales();
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
  Data(this.sales);
  Details sales;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        child: Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white.withOpacity(0.1),
                  ),
                  height: 100,
                  width: 420,
                  child: Stack(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: sales.profile_pic == null
                                  ? CircleAvatar(
                                backgroundColor: Colors.cyan[100],
                                backgroundImage: AssetImage('assets/Client dummy.png'),
                                radius: 35,
                              )
                                  : CircleAvatar(
                                backgroundColor: Colors.cyan[100],
                                backgroundImage: NetworkImage(
                                  sales.profile_pic.toString(),
                                ),
                                radius: 35,
                              ),
                            ),
                            Text(
                              sales.firstname.toString().capitalize(),
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MessagesScreen(sales.id!.toString(),
                    sales.firstname!, sales.profile_pic.toString())),
          );
        },
      ),
    );
  }
}
