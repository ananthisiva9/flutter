import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:railway_super_app/User/Bottombar.dart';
import 'package:railway_super_app/User/Contest/LatestContest/Image%20Contest/Crop.dart';
import 'package:railway_super_app/User/FeedBack.dart';
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EditProfile/EditProfile.dart';
import 'EmailVerification/Email.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  bool isLoading = true;
  var pinText = "";

  // ignore: non_constant_identifier_names, prefer_typing_uninitialized_variables
  var full_name,
      code,
      email_id,
      age,
      gender,
      emp_id,
      profile_pic,
      phoneno,
      firstname,
     lastname,contest_amount,wallet_amount;
  final _picker = ImagePicker();
  logOut() async {
    String url = ApiEndPoint.logout;
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    var res = await http.post(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (res.statusCode == 200) {
      sharedPreferences.remove(token!);
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
              (route) => false);
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!. Please try again'),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<dynamic> exitDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you Sure?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Do You want to Logout from the app?',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              logOut();
            },
            child: Text(
              "Logout",
              style: GoogleFonts.poppins(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Profile(),
                ),
              );
            },
            child: Text(
              "Cancel",
              style: GoogleFonts.poppins(),
            ),
          ),
        ],
      ),
    );
  }
  profile_verify_code(String otp) async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    String url = '${ApiEndPoint.securitycode}?pin_no=$pinText';
    var response = await http.get(
      Uri.parse(url),
      headers: {"Authorization": "Token $token"},
    );
    if (response.statusCode == 200) {
      if(token != null) {
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
                builder: (context) =>
                    EditProfile(
                        email_id.toString())),
          );
        }
      } else if(token == null){
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Login Details not found. You will be rerouted to the login page'),
         backgroundColor: Colors.red,
        ));
       print(token);
       logOut();
       Future.delayed(const Duration(seconds: 2), () {
         Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => const Login()),
         );
       });
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
    final TextEditingController _verifypinController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    return showDialog(
        // barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      bool isAuthenticated = await authenticate();
                      if (isAuthenticated) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>   EditProfile(
                              email_id.toString())),
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
                                color: const Color(0xff3C64B1),
                                fontWeight: FontWeight.w500,
                                fontSize: 14)),
                      ],
                    ),
                  ),
                  Center(
                    child: Text("OR",
                        style: GoogleFonts.poppins(
                            color: const Color(0xff3C64B1),
                            fontWeight: FontWeight.w400,
                            fontSize: 16)),
                  ),
                  const SizedBox(
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
                                color: const Color(0xff3C64B1),
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
                        controller: _verifypinController,
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
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width / 2.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                              0xff6891DF), // foreground (text) color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            profile_verify_code(_verifypinController.text);
                          }
                        },
                        child: Text("SUBMIT",
                            style: GoogleFonts.poppins(
                                color: const Color(0xffFFFFFF),
                                fontWeight: FontWeight.w500,
                                fontSize: 16)),
                      ),
                    ),
                  ),
                ],
              ),
           );
        });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    emp_id = sharedPreferences.get('emp_id') as String?;
    String url = ApiEndPoint.profile + emp_id.toString();
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      setState(() {
       isLoading = false;
        firstname = jsonDecode(response.body)['first_name'];
        lastname = jsonDecode(response.body)['last_name'];
        full_name = jsonDecode(response.body)['full_name'];
        code = jsonDecode(response.body)['code'];
        email_id = jsonDecode(response.body)['email_id'];
        age = jsonDecode(response.body)['age'];
        gender = jsonDecode(response.body)['gender'];
        phoneno = jsonDecode(response.body)['phone_no'];
        profile_pic = jsonDecode(response.body)['profile_pic'];
       contest_amount = jsonDecode(response.body)['contest_amount'];
       wallet_amount = jsonDecode(response.body)['wallet_amount'];
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Details Not Found'),
        backgroundColor: Colors.red,
      ));
    }
  }

  _getImageFrom({required ImageSource source}) async {
    final _pickedImage = await _picker.pickImage(source: source);
    if (_pickedImage != null) {
      var image = File(_pickedImage.path.toString());
      final _sizeInKbBefore = image.lengthSync() / 1024;
      print('Before Compress $_sizeInKbBefore kb');
      var _compressedImage = await AppHelper.compress(image: image);
      final _sizeInKbAfter = _compressedImage.lengthSync() / 1024;
      print('After Compress $_sizeInKbAfter kb');
      var _croppedImage = await AppHelper.cropImage(_compressedImage);
      if (_croppedImage == null) {
        return;
      }
      setState(() {
        profile_pic = _compressedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      double _height = MediaQuery.of(context).size.height;
      double _width = MediaQuery.of(context).size.width;
      return Scaffold(
        //  extendBody: true,
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
        body: isLoading
            ? const Center(
            child:
            CircularProgressIndicator()) // this will show when loading is true
            : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 2.0,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xff666666),
                    ),
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        blurRadius: 7.0,
                        spreadRadius: 2.0,
                        offset: Offset(0.0, 0.0),
                      )
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: SizedBox(
                                height:
                                MediaQuery.of(context).size.height /
                                    8,
                                width: MediaQuery.of(context).size.width /
                                    3.8,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      height: MediaQuery.of(context)
                                          .size
                                          .height /
                                          8,
                                      width: MediaQuery.of(context)
                                          .size
                                          .width /
                                          4,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Color(0xff0093DD),
                                              blurRadius: 0.0,
                                              offset: Offset(0.0, 0.0),
                                              spreadRadius: 5.0)
                                        ],
                                      ),
                                      child: Center(
                                        child: ClipOval(
                                          child: (profile_pic != null)
                                              ? Image.network(
                                            profile_pic!,
                                            fit: BoxFit.cover,
                                            height: MediaQuery.of(
                                                context)
                                                .size
                                                .height /
                                                3,
                                            width: MediaQuery.of(
                                                context)
                                                .size
                                                .width /
                                                1,
                                          )
                                              : Icon(Icons.person_rounded,
                                              size: MediaQuery.of(
                                                  context)
                                                  .size
                                                  .height /
                                                  8,
                                              color: const Color(
                                                  0xff0093DD)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width/2.5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      '$firstname  $lastname',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Text(
                                      'Username : $code',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () async {
                                  verify_alertbox(context);
                                  /* bool isAuthenticated =
                                            await authenticate();
                                        if (isAuthenticated) {
                                          // ignore: use_build_context_synchronously
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditProfile(
                                                        email_id.toString())),
                                          );
                                        }*/
                                },
                                icon: const Icon(
                                  Icons.mode_edit_outline_outlined,
                                  size: 30,
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.call_outlined,
                                size: 25,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    1.8,
                                child: Text(
                                  phoneno.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Icon(
                                Icons.email_outlined,
                                size: 25,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width /
                                    1.8,
                                child: Text(
                                  email_id.toString(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black, fontSize: 14),
                                ),
                              ),
                            ),
                            // InkWell(
                            //   onTap: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) =>
                            //               const ValidEmail()),
                            //     );
                            //   },
                            //   child: Container(
                            //     height:
                            //         MediaQuery.of(context).size.height /
                            //             20,
                            //     width:
                            //         MediaQuery.of(context).size.width / 5,
                            //     decoration: BoxDecoration(
                            //         color: Colors.green,
                            //         borderRadius:
                            //             BorderRadius.circular(10)),
                            //     child: Padding(
                            //       padding: const EdgeInsets.all(8.0),
                            //       child: Center(
                            //         child: Text(
                            //           'Change',
                            //           style: GoogleFonts.poppins(
                            //               color: Colors.black,
                            //               fontSize: 14,
                            //               fontWeight: FontWeight.bold),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Divider(
                          height: 10,
                          thickness: 1,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Image(
                                            image: AssetImage(
                                                'asset/Profile8.png'),
                                            height: 40,
                                          )),
                                      Text(
                                        ' Rs $wallet_amount ',
                                        style: GoogleFonts.poppins(
                                            color:
                                            const Color(0xff0093DD),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Wallet',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const VerticalDivider(
                              thickness: 1,
                              color: Color(0xFFF6F4F4),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Image(
                                            image: AssetImage(
                                                'asset/Profile9.png'),
                                            height: 35,
                                          )),
                                      Text(
                                        ' Rs $contest_amount ',
                                        style: GoogleFonts.poppins(
                                            color:
                                            const Color(0xff0093DD),
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Rewards',
                                      style: GoogleFonts.poppins(
                                          color: Colors.black,
                                          fontSize: 14),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.wallet,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'My Transaction',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.airplane_ticket_outlined,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'My Booking',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const FeedBack()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.message_outlined,
                            size: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Feedback',
                            style: GoogleFonts.poppins(
                                color: Colors.black, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: Icon(
                          Icons.headset_mic_outlined,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Help Desk',
                          style: GoogleFonts.poppins(
                              color: Colors.black, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(
                  height: 10,
                  thickness: 1,
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.power_settings_new,
                            size: 35,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'Sign Out',
                          style: GoogleFonts.poppins(
                              color: Colors.red, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    exitDialog();
                  },
                ),
              ],
            ),
          ),
        ),
      //  bottomNavigationBar: const BottomBar(),
      );
    });
  }

  _openChangeImageBottomSheet() {
    return showCupertinoModalPopup(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return CupertinoActionSheet(
            actions: <Widget>[
              _buildCupertinoActionSheetAction(
                icon: Icons.camera_alt,
                title: ' Camera ',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.camera);
                },
              ),
              _buildCupertinoActionSheetAction(
                icon: Icons.image,
                title: ' Gallery ',
                voidCallback: () {
                  Navigator.pop(context);
                  _getImageFrom(source: ImageSource.gallery);
                },
              ),
            ],
          );
        });
  }

  _buildCupertinoActionSheetAction({
    IconData? icon,
    required String title,
    required VoidCallback voidCallback,
    Color? color,
  }) {
    return CupertinoActionSheetAction(
      onPressed: voidCallback,
      child: Row(
        children: [
          if (icon != null)
            Icon(
              icon,
              color: color ?? const Color(0xFF2564AF),
            ),
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                color: color ?? const Color(0xFF2564AF),
              ),
            ),
          ),
          if (icon != null)
            const SizedBox(
              width: 25,
            ),
        ],
      ),
    );
  }
}
