import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'AllClientSubscription/AllClientSubscription.dart';
import 'Subscriptions_controller.dart';
import 'Subscriptions_model.dart';

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  @override
  Widget build(BuildContext context) {
    return initWidget(context);
  }

  Widget initWidget(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SubscriptionController(context),
        child: Consumer<SubscriptionController>(
            builder: (context, controller, child) {
          return Scaffold(
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
                    'Subscription Plan',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              body: Stack(children: <Widget>[
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
                        ? SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildTotal1(controller.model),
                                _buildTotal2(controller.model),
                                _buildTotal3(controller.model),
                                _buildTotal4(controller.model),
                              ],
                            ),
                          )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchDisplayActivity();
                            }),
                          ),
              ]));
        }));
  }

  Widget _buildTotal1(SubscriptionModel? model) {
    return Container(
      height: 150,
      width: 500,
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 140,
                    width: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          model!.oneMonthPlan == null
                              ? "Not Available"
                              : model.oneMonthPlan.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "1 Month Plan",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10.0)),
                  alignment: Alignment.center,
                  height: 140,
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        model.threeMonthPlan == null
                            ? "Not Available"
                            : model.threeMonthPlan.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "3 Month Plan",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ],
          )
    );
  }

  Widget _buildTotal2(SubscriptionModel? model) {
    return Container(
      height: 150,
      width: 500,
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10.0)),
                  alignment: Alignment.center,
                  height: 140,
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        model!.pregnancyClass == null
                            ? "Not Available"
                            : model.pregnancyClass.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Pregnancy Class",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    height: 140,
                    width: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          model.fullPregnancyPackage == null
                              ? "Not Available"
                              : model.fullPregnancyPackage.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Full Pregnancy Package",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {}),
            ],
          )
    );
  }
  Widget _buildTotal3(SubscriptionModel? model) {
    return Container(
      height: 150,
      width: 500,
      child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.0)),
                    alignment: Alignment.center,
                    height: 140,
                    width: 140,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        const Icon(
                          Icons.person,
                          size: 50,
                          color: Colors.white,
                        ),
                        Text(
                          model!.activeClients == null
                              ? "Not Available"
                              : model.activeClients.toString(),
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Active Clients",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {}),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(10.0)),
                  alignment: Alignment.center,
                  height: 140,
                  width: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                      Text(
                        model.disabledClients == null
                            ? "Not Available"
                            : model.disabledClients.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Disabled Clients",
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                onTap: () {},
              ),
            ],
          )
    );
  }

  Widget _buildTotal4(SubscriptionModel? model) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          height: 35,
          width: 200,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xffe14589) , // foreground (text) color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SubscriptionClient()),
              );
            },
            child: Text(
              "Client Subscription List",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

@override
getToken() async {
  dynamic userDetails = await Global.getUserDetails();
  if (userDetails != null && userDetails is LoginModel) {
    return userDetails.token;
  }
}
