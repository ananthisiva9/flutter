import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:railway_super_app/User/Bottombar.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wifi_iot/wifi_iot.dart';
import 'package:wifi_scan/wifi_scan.dart';

class WifiConnect extends StatefulWidget {
  const WifiConnect({Key? key}) : super(key: key);
  @override
  State<WifiConnect> createState() => _WifiConnectState();
}

class _WifiConnectState extends State<WifiConnect> {
  List<WiFiAccessPoint> accessPoints = <WiFiAccessPoint>[];
  StreamSubscription<List<WiFiAccessPoint>>? subscription;
  bool shouldCheckCan = true;
  bool status = false;
  bool get isStreaming => subscription != null;
  var ssid;

  Future<bool> _canGetScannedResults(BuildContext context) async {
    if (shouldCheckCan) {
      // check if can-getScannedResults
      final can = await WiFiScan.instance.canGetScannedResults();
      // if can-not, then show error
      if (can != CanGetScannedResults.yes) {
        if (mounted) kShowSnackBar(context, "Cannot get scanned results: $can");
        accessPoints = <WiFiAccessPoint>[];
        return false;
      }
    }
    return true;
  }

  Future<void> _getScannedResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      // get scanned results
      final results = await WiFiScan.instance.getScannedResults();
      setState(() => accessPoints = results);
    }
  }

  Future<void> _startListeningToScanResults(BuildContext context) async {
    if (await _canGetScannedResults(context)) {
      subscription = WiFiScan.instance.onScannedResultsAvailable
          .listen((result) => setState(() => accessPoints = result));
    }
  }

  void _stopListeningToScanResults() {
    subscription?.cancel();
    setState(() => subscription = null);
  }
  void initState() {
    super.initState();
    LogStart();
  }
  String? message;
  LogStart() async {
    String url =
        '${ApiEndPoint.log_start}?app_label=Railway&Module_name=WiFi';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      message = jsonDecode(res.body)['message'];
      print(message);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }

  LogEnd() async {
    String url =
        '${ApiEndPoint.log_end}?id=$message';
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    print(token);
    var res = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      print(res);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(res.toString()),
        backgroundColor: Colors.red,
      ));
    }
  }
  @override
  void dispose() {
    super.dispose();
    // stop subscription for scanned results
    _stopListeningToScanResults();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        //wrap with PreferredSize
        preferredSize: const Size.fromHeight(10),
        child: AppBar(
          backgroundColor: const Color(0xff0093DD),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25))),
        ),
      ),
      body: Builder(
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Image(image: AssetImage('asset/Add1.png'))),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Wi-Fi',
                      style: GoogleFonts.poppins(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Transform.scale(scale: 1.5,
                          child: Switch(
                            activeColor: const Color(0xf0093DD),
                            value: status,
                            onChanged: (value) {
                              if(value == true){
                                setState(() {
                                  status = value;
                                  _getScannedResults(context);
                                });
                              }else if(value == false){
                                setState(() {
                                  status = value;
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 30,
                thickness: .5,
                color: Colors.grey,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Available Networks',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              Flexible(
                child: Center(
                  child: status == false
                      ? const Text(
                    "Device Unavailable",
                    style:
                    TextStyle(fontSize: 18, color: Color(0xff0093DD)),
                  )
                      : ListView.builder(
                      itemCount: accessPoints.length,
                      itemBuilder: (context, i) =>
                          _AccessPointTile(accessPoint: accessPoints[i])),
                ),
              ),
              const Center(child: Image(image: AssetImage('asset/Add2.png'))),
            ],
          ),
        ),
      ),
  //   bottomNavigationBar: const BottomBar(),
    );
  }
}

/// Show tile for AccessPoint.
///
/// Can see details when tapped.
class _AccessPointTile extends StatefulWidget {
  final WiFiAccessPoint accessPoint;
  _AccessPointTile({Key? key, required this.accessPoint}) : super(key: key);

  @override
  State<_AccessPointTile> createState() => _AccessPointTileState();
}

class _AccessPointTileState extends State<_AccessPointTile> {
  var ssid;
   WifiLoading() {
    return  showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          Future.delayed(Duration(seconds: 30), () {
            Navigator.of(context).pop(true);
          });
          return AlertDialog(
              title: Column(
                children: [
                  Image.asset(
                      'asset/Wi_fi_Loading.gif'),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Loading....',
                    style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: const Color(
                            0xff0093DD),
                        fontWeight: FontWeight
                            .bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              )
          );
        });
  }
  // build row that can display info, based on label: value pair.
  Widget _buildInfo(String label, dynamic value) => Container(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey)),
    ),
    child: Container(
      child: Row(
        children: [
          Text(
            "$label :  ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value.toString()))
        ],
      ),
    ),
  );

  final TextEditingController _wifipwdController = TextEditingController();

  var _isSucceed = false;

  var password;
  final _formKey = GlobalKey<FormState>();
  bool _wifi_visible = true;
  void _wifi_toggle() {
    setState(() {
      if(_wifi_visible == true) {
        _wifi_visible = false;
        SystemChannels.textInput.invokeMethod('TextInput.show');
      }
      else{
          _wifi_visible = true;
          SystemChannels.textInput.invokeMethod('TextInput.hide');
      }

      // Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.accessPoint.ssid.isNotEmpty ? widget.accessPoint.ssid : "**EMPTY**";
    final signalIcon = widget.accessPoint.capabilities == "[ESS]"
        ? Icons.signal_wifi_4_bar
        : Icons.signal_wifi_4_bar_lock;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        visualDensity: VisualDensity.compact,
        leading: Icon(
          signalIcon,
          color: const Color(0xff221E22),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                    color: const Color(0xff221E22), fontSize: 20),
              ),
            ),
            IconButton(
              onPressed: () {
                widget.accessPoint.capabilities == "[ESS]"
                    ? showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(
                        title,
                        style: const TextStyle(
                            color: Color(0xff000080), fontSize: 20),
                      ),
                      content: Container(
                        height: 1.4 * (MediaQuery.of(context).size.height / 20),
                        width: 5 * (MediaQuery.of(context).size.width / 10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: const LinearGradient(
                              colors: [Color(0xff5CACF9), Color(0xff0D72D0)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                        ),
                        child: TextButton(
                            onPressed: () async {
                              widget.accessPoint.ssid;
                               ssid = widget.accessPoint.ssid;
                              final res =
                              await WiFiForIoTPlugin.connect(
                                ssid,
                                security: NetworkSecurity.NONE,
                                withInternet: true,
                              );
                              WifiLoading();
                            },
                            child: const Text(
                              'Connect',
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                    ))
                    : showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: Center(

                      child: Text(
                        title,
                        style: GoogleFonts.poppins(
                            color: const Color(0xff221E22), fontSize: 18),
                      ),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                      Form(
                      key: _formKey,
                        child:  Padding(
                          padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                          child: TextFormField(
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            maxLines: 1,
                            maxLength: 16,
                            style: const TextStyle(fontSize: 20),
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.name,
                            onChanged: (value) {
                              setState(() {
                                password = value;
                              });
                            },
                            controller: _wifipwdController,
                            obscureText: _wifi_visible,
                            decoration: InputDecoration(
                              errorMaxLines: 2,
                              counterText: '',
                              labelText: 'Password',
                              labelStyle: GoogleFonts.poppins(fontSize: 20),
                              border: const OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.white, width: 3),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              suffixIcon: InkWell(
                                onTap: _wifi_toggle,
                                child: Icon(
                                  _wifi_visible
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  size: 25.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                } else if (password.isEmpty) {
                                  return 'Please enter valid Password';
                                }
                                return null;
                              },
                          ),
                        ),

                      ),
                        Container(
                          height: 1.4 *
                              (MediaQuery.of(context).size.height / 20),
                          width: 5 *
                              (MediaQuery.of(context).size.width / 10),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: const LinearGradient(
                                colors: [
                                  Color(0xff5CACF9),
                                  Color(0xff0D72D0)
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight),
                          ),
                          child: TextButton(
                            onPressed: () async {
                              if(_formKey.currentState!.validate()){
                                widget.accessPoint.ssid;
                                _wifipwdController;

                                 ssid = widget.accessPoint.ssid;
                                final res = await WiFiForIoTPlugin.connect(
                                  ssid,
                                  password: _wifipwdController.text,
                                  security: NetworkSecurity.WPA,
                                  withInternet: true,
                                );

                             /*   Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WifiConnect()),
                                );*/
                                WifiLoading();
                              } } ,
                            child: Text(
                              "Connect",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              icon: const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Color(0xff221E22),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/// Show snackbar.
void kShowSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));
}
