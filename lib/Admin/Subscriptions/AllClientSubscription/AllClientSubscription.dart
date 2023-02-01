import 'package:admin_dashboard/Admin/Patient/AllCLients/Tracker/DailyTracker.dart';
import 'package:admin_dashboard/Admin/Patient/Patient.dart';
import 'package:admin_dashboard/Admin/Subscriptions/Search.dart';
import 'package:admin_dashboard/Login/Login_model.dart';
import 'package:admin_dashboard/utility/api_endpoint.dart';
import 'package:admin_dashboard/utility/global.dart';
import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:admin_dashboard/widgets/error_refresh_icon.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:string_capitalize/string_capitalize.dart';
import 'package:http/http.dart' as http;
import 'AllClientSubscription_controller.dart';
import 'AllClientSubscription_model.dart';

class SubscriptionClient extends StatefulWidget {
  @override
  _SubscriptionClientState createState() => _SubscriptionClientState();
}

class _SubscriptionClientState extends State<SubscriptionClient> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ClientSubscriptionController(context),
      child: Consumer<ClientSubscriptionController>(
          builder: (context, controller, child) {
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
                  'Clients All Time',
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
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      showSearch(
                          context: context,
                          delegate: DataSearch(controller.model!.items!));
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
                controller.state == StateEnum.loading
                    ? const Center(child: LoadingIcon())
                    : controller.state == StateEnum.success
                        ? (controller.model!.items == null ||
                                controller.model!.items!.isEmpty)
                            ? Center(
                                child: Text(
                                  'No Patient available',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : ListView.builder(
                                itemBuilder: (_, int index) =>
                                    Data(controller.model!.items![index]),
                                itemCount: controller.model!.items!.length,
                              )
                        : Center(
                            child: ErrorRefreshIcon(onPressed: () {
                              controller.fetchAllClients();
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

class Data extends StatefulWidget {
  Data(this.client, {Key? key}) : super(key: key);
  Client client;
  @override
  State<Data> createState() => _DataState();
}

class _DataState extends State<Data> {
  final items = [
    'Free Version',
    '1 month',
    '3 month',
    'Pregnancy class',
    'Full Package'
  ];
  String? selectedItems = 'Free Version';
  postData() async {
    String appointmentId = widget.client.id.toString();
    String url = Admin.account_status;
    Map body = {
      "id": appointmentId,
    };
    String? token = await getToken();
    if (token != null) {
      var res = await http.post(
        Uri.parse(url),
        headers: {"Authorization": "Token $token"},
        body: body,
      );
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Updated Successfully'),
          backgroundColor: Colors.green,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Something Went Wrong. Please try again'),
          backgroundColor: Colors.red,
        ));
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Patient()),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.1),
        ),
        height: 225,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircleAvatar(
                backgroundColor: Colors.cyan[100],
                backgroundImage: const AssetImage('assets/Client dummy.png'),
                radius: 35,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      (widget.client.firstname.toString().capitalize()) +
                          " " +
                          (widget.client.lastname.toString().capitalize()),
                      style: GoogleFonts.poppins(
                          fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Age : " + (widget.client.age.toString()),
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
                        "Location : " +
                            (widget.client.location.toString().capitalize()),
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
                        "Current Week : " + (widget.client.week.toString()),
                        style: GoogleFonts.poppins(
                          color: Colors.lightBlueAccent,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Subscription : " + (widget.client.subscription.toString()),
                        style: GoogleFonts.poppins(
                            color: Colors.lightBlueAccent, fontSize: 12),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 10,
                    thickness: .8,
                    color: Colors.white,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: DropdownButton<String>(
                                  value: selectedItems,
                                  elevation: 5,
                                  underline: Container(
                                    color: Colors.grey.withOpacity(0.1),
                                  ),
                                  hint: Text(
                                    'AccountStatus',
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                  iconDisabledColor: Colors.white,
                                  iconEnabledColor: Colors.white,
                                  iconSize: 25,
                                  dropdownColor: Colors.lightBlueAccent,
                                  items: items
                                      .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item,
                                              style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 12))))
                                      .toList(),
                                  onChanged: (item) => setState(
                                      () => selectedItems = (postData())),
                                ),
                              ),
                            ),
                            Container(
                              height: 35,
                              width: 175,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xffe14589) , // foreground (text) color
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DailyTracker(widget.client.id!)),
                                  );
                                },
                                child: Text(
                                  "Tracking Details",
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ]),
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

getToken() async {
  dynamic userDetails = await Global.getUserDetails();
  if (userDetails != null && userDetails is LoginModel) {
    return userDetails.token;
  }
}
