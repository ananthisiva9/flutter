import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/OnBoard/Onboard.dart';
import 'package:railway_super_app/User/Dashboard/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../utility/api_endpoint.dart';
// import 'SecurityCode.dart';

class SplashScreenController with ChangeNotifier {
  SplashScreenController(this.context) {
    Timer(const Duration(seconds: 3), () => checkFirstTime());
    // checkForExistingUserData();
  }
  BuildContext context;
  var pinText = "";
  //Securitycode msm = new Securitycode();
  static SharedPreferences? prefs;
  LocalAuthentication auth = LocalAuthentication();
  Future authenticate() async {
    final bool isBiometricsAvailable = await auth.isDeviceSupported();

    if (!isBiometricsAvailable) return false;

    try {
      return await auth.authenticate(
        localizedReason: 'Scan Fingerprint To Enter Vault',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException {
      return;
    }
  }
  postData() async {
    String url = ApiEndPoint.token;
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    Map body = {
      "token": token,
    };
    var res = await http.post(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
      body: body,
    );
    if (res.statusCode == 200) {
      if (jsonDecode(res.body)['status'] == 200) {

      } else if (jsonDecode(res.body)['status'] == 500) {
        // // ignore: use_build_context_synchronously
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(jsonDecode(res.body)['message'].toString()),
        //   backgroundColor: Colors.red,
        // ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Login()),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }
 pincode(String otp) async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    String url = '${ApiEndPoint.securitycode}?pin_no=$pinText';
    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 500) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(response.body)['message'].toString()),
          backgroundColor: Colors.red,
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(jsonDecode(response.body)['message'].toString()),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Dashboard()),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(response.toString()),
        backgroundColor: Colors.red[900],
      ));
    }
  }
  Future verify_alertbox(BuildContext context) {
    final TextEditingController _securtiypinController =
    TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      bool isAuthenticated = await authenticate();
                      postData();
                      if (isAuthenticated) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Dashboard()),
                        );
                      } else {
                        Container();
                      }
                    },
                    child: Row(
                      children: [
                        // Image.asset('asset/fingerprint.png'),
                        const Icon(
                          Icons.fingerprint,
                          color: Color(0xff3C64B1),
                          size: 40,
                        ),

                        const SizedBox(
                          width: 5,
                        ),
                        Text("Login using Finger print",
                            style: GoogleFonts.poppins(
                                color: Color(0xff3C64B1),
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                      ],
                    ),
                  ),
                  Center(
                    child: Text("OR",
                        style: GoogleFonts.poppins(
                            color: Color(0xff3C64B1),
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.lock,
                          color: Color(0xff3C64B1),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Text("Enter security code",
                            style: GoogleFonts.poppins(
                                color: Color(0xff3C64B1),
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: PinCodeTextField(
                        keyboardType: TextInputType.number,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.none,
                        cursorColor: Colors.black,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 40,
                          fieldWidth: 40,
                          activeFillColor: Colors.white38, //, 006817
                          activeColor: Colors.black,
                          disabledColor: Colors.deepPurple,
                          errorBorderColor: Colors.yellowAccent,
                          inactiveColor: Colors.black,
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white38,
                          selectedColor: Colors.black,
                        ),
                        //  animationDuration: const Duration(milliseconds: 1000),
                        enableActiveFill: true,
                        controller: _securtiypinController,
                        onCompleted: (v) {},
                        onChanged: (value) {
                          // setState(() {
                          pinText = value;
                          //   });
                        },
                        beforeTextPaste: (text) {
                          return false;
                        },
                        appContext: context,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xff6891DF),
                          elevation: 10.0,
                          // foreground (text) color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          postData();
                         if (_formKey.currentState!.validate()) {
                            pincode(_securtiypinController.text);
                          }
                        },
                        child: Text("SUBMIT",
                            style: GoogleFonts.poppins(
                                color: Color(0xffFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<dynamic> authendication_alertbox() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: () {
              return Future.value(false);
            },
            child: AlertDialog(
              title: Column(
                children: const [
                  Text("Please Add your finger print or Password"),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
              actions: [
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                    authenticate();
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    height: MediaQuery.of(context).size.height / 15,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                          colors: [Color(0xFFD4418E), Color(0xFF0652C5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                    ),
                    child: const Center(
                      child: Text(
                        "Finger print",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  static Future<void> getPreferences() async {
    prefs ??= await SharedPreferences.getInstance();
  }

  Future<void> checkFirstTime() async {
    await getPreferences();
    bool showOnboarding = !(prefs!.containsKey("firsttime"));
    if (showOnboarding) {
      await prefs!.setBool("firsttime", true);
      goToOnboarding();
    } else {
      checkForExistingUserData();
    }
  }

  Future<void> checkForExistingUserData() async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    if (token == null) {
      goToLogin();
    } else {
     verify_alertbox(context);

    }
  }

  goToOnboarding() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const OnBoard()));
  }

  goToLogin() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  goToDashboard() async {
    bool isAuthenticated = await authenticate();
    if (isAuthenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Dashboard()),
      );
    } else if (isAuthenticated == false) {
      authendication_alertbox();
    } else {
      Container();
    }
  }
}