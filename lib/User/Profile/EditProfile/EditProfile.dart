import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:railway_super_app/User/Bottombar.dart';
import 'package:railway_super_app/User/Contest/LatestContest/Image%20Contest/Crop.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Profile.dart';

class EditProfile extends StatefulWidget {
  String? email;
  EditProfile(this.email, {super.key});
  @override
  EditProfileState createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true;
  bool _clicked = false;
  var crop = 0;
  int proImage = 0;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var profileimg;
  final _picker = ImagePicker();
  var statename = [];
  var cityname = [];

  ///Date
  var selected = DateTime.now();
  var initial = DateTime(1900);
  var last = DateTime.now();

  Future displayDatePicker(BuildContext context) async {
    var date = await showDatePicker(
      context: context,
      initialDate: selected,
      firstDate: initial,
      lastDate: last,
    );

    if (date != null) {
      setState(() {
        _dobController.text = date.toString().split(" ")[0];
        // _dobController.text = "$date";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getState();
  }

  form1(
      File imageFile,
      String firstname,
      String lastname,
      String gender,
      String mobile,
      String dob,
      String address,
      String state,
      String city,
      String pincode) async {
    String? token;
    String? empId;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    empId = sharedPreferences.get('emp_id') as String?;
    String url = ApiEndPoint.profile + empId.toString();
    http.MultipartRequest request =
        http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll(<String, String>{'Authorization': 'Token $token'});
    Map<String, String> body = {
      "first_name": firstname,
      "last_name": lastname,
      "full_name": firstname + lastname,
      "gender": gender,
      "phone_no": mobile,
      "email_id": widget.email.toString(),
      "dob": dob,
      "address": address,
      "state": state,
      "city": city,
      "pincode": pincode,
    };
    if (token != null) {
      var res = await http.put(
        Uri.parse(url),
        headers: {"Authorization": "Token $token"},
      );
      File file;
      file = File(imageFile.path);
      request.fields.addAll(body);
      request.files.add(http.MultipartFile(
          'prof_photo', file.readAsBytes().asStream(), file.lengthSync(),
          filename: file.path.split('/').last));
      var response = await request.send();
      if (response.statusCode == 200) {
        String message;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile Updated Successfully'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        Map map = jsonDecode(await response.stream.bytesToString());
        if (map['status'] == 200) {
          message = map["message"];
        } else {
          message = map["description"];
        }
      } else {}
    }
  }

  form2(
      String firstname,
      String lastname,
      String gender,
      String mobile,
      String dob,
      String address,
      String state,
      String city,
      String pincode) async {
    String? token;
    String? empId;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    empId = sharedPreferences.get('emp_id') as String?;
    String url = ApiEndPoint.profile + empId.toString();
    http.MultipartRequest request =
        http.MultipartRequest('PUT', Uri.parse(url));
    request.headers.addAll(<String, String>{'Authorization': 'Token $token'});
    Map<String, String> body = {
      "first_name": firstname,
      "last_name": lastname,
      "full_name": firstname + lastname,
      "gender": gender,
      "phone_no": mobile,
      "dob": dob,
      "address": address,
      "state": state,
      "city": city,
      "pincode": pincode,
      'prof_photo': "",
      "email_id": widget.email.toString(),
    };
    if (token != null) {
      var res = await http.put(
        Uri.parse(url),
        headers: {"Authorization": "Token $token"},
      );
      request.fields.addAll(body);
      var response = await request.send();
      if (response.statusCode == 200) {
        String message;
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Profile Updated Successfully'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Profile()),
        );
        Map map = jsonDecode(await response.stream.bytesToString());
        if (map['status'] == 200) {
          message = map["message"];
        } else {
          message = map["description"];
        }
      } else {}
    }
  }

  _getImageFrom({required ImageSource source}) async {
    final pickedImage = await _picker.pickImage(source: source);
    if (pickedImage != null) {
      var image = File(pickedImage.path.toString());
      // final sizeInKbBefore = image.lengthSync() / 1024;
      // var compressedImage = await AppHelper.compress(image: image);
      // final sizeInKbAfter = compressedImage.lengthSync() / 1024;
      var croppedImage = await AppHelper.cropImage(image);
      if (croppedImage == null) {
        return;
      }
      setState(() {
        profileimg = croppedImage;
        crop = 1;
        proImage = 1;
      });
    }
  }

  getState() async {
    var stateInfoUrl = '${ApiEndPoint.state}?page=1&limit=50';
    await http.get(Uri.parse(stateInfoUrl)).then((response) {
      var statedata = json.decode(response.body);
      setState(() {
        for (var i = 0; i < statedata['data'].length; i++) {
          statename.add(statedata['data'][i]);
        }
      });
    });
    return null;
  }

  getCities(myState) async {
    String cityInfoUrl = '${ApiEndPoint.city}?page=1&limit=4000';
    await http.get(Uri.parse('$cityInfoUrl &id=$myState')).then((response) {
      var data = json.decode(response.body);
      setState(() {
        for (var i = 0; i < data['data'].length; i++) {
          cityname.add(data['data'][i]);
        }
        print(cityInfoUrl);
      });
    });
  }

  // ignore: prefer_typing_uninitialized_variables
  var firstname,
      lastname,
      gender,
      mobile,
      dob,
      address,
      pincode,
      myState,
      myCity;
  DateTime _selectedDate = DateTime.now();
  DateTime get selectedDate => _selectedDate;

  setSelectedDate(DateTime newDateTime) {
    _selectedDate = newDateTime;
  }

  changeSelectedDate(DateTime selectedDate) {
    _selectedDate = selectedDate;
  }

  _selectDate(BuildContext context) async {
    DateTime? datepicker = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (datepicker != null && datepicker != _selectedDate) {
      changeSelectedDate(datepicker);
      setState(() {
        _selectedDate = datepicker;
        setSelectedDate(_selectedDate);
      });
    }
  }

  getData() async {
    String? empId;
    String? token;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    empId = sharedPreferences.get('emp_id') as String?;
    String url = ApiEndPoint.profile + empId.toString();
    var response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Token $token',
    });
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        _firstnameController.text = jsonDecode(response.body)['first_name'];
        _lastnameController.text = jsonDecode(response.body)['last_name'];
        gender = jsonDecode(response.body)['gender'];
        _mobileController.text = jsonDecode(response.body)['phone_no'];
        _dobController.text = jsonDecode(response.body)['dob'];
        _addressController.text = jsonDecode(response.body)['address_id'];
        _pincodeController.text = jsonDecode(response.body)['pincode'];
        profileimg = jsonDecode(response.body)['profile_pic'];
        myState = jsonDecode(response.body)['state'];
        myCity = jsonDecode(response.body)['city'];
      });
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Details Not Found'),
        backgroundColor: Colors.red,
      ));
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const BottomBar(index: 0)),
        );
      });
    }
  }
  Future<dynamic> Signup_cancel_dialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Are you Sure?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          'Do You want  cancel Update?',
          style: GoogleFonts.poppins(fontSize: 14),

        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const BottomBar(index: 0)),
              );
            },
            child: Text(
              "Ok",
              style: GoogleFonts.poppins(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
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
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Signup_cancel_dialog();
        return false;
      },
      child: Scaffold(
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
            : Stack(
                children: <Widget>[
                  SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image(image: AssetImage('asset/Add1.png')),
                        ),
                        Center(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Stack(
                              clipBehavior: Clip.none,
                              fit: StackFit.expand,
                              children: [
                                InkWell(
                                  onTap: _openChangeImageBottomSheet,
                                  child: Container(
                                    height: 100.0,
                                    width: 100.0,
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
                                        child: (profileimg != null)
                                            ? crop == 0
                                                ? Image.network(
                                                    profileimg,
                                                    fit: BoxFit.cover,
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        3,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1,
                                                  )
                                                : Image.file(
                                                    profileimg!,
                                                    fit: BoxFit.cover,
                                                    height: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        3,
                                                    width: MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        1,
                                                  )
                                            : Icon(Icons.person_rounded,
                                                size: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8,
                                                color: const Color(0xff0093DD)),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    right: -16,
                                    bottom: 0,
                                    child: SizedBox(
                                        height: 46,
                                        width: 46,
                                        child: FloatingActionButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            side: const BorderSide(
                                                color: Colors.white),
                                          ),
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            _openChangeImageBottomSheet();
                                          },
                                          child: const Center(
                                              child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.black,
                                          )),
                                        )))
                              ],
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Firstname",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: <Widget>[
                                           TextFormField(
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                    RegExp("[a-zA-Z]")),
                                              ],
                                             minLines: 4,
                                             maxLength: 30,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              onChanged: (value) {
                                                setState(() {
                                                  firstname = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter first name';
                                                }
                                                return null;
                                              },
                                              controller: _firstnameController,
                                              decoration: InputDecoration(
                                                hintText: firstname,
                                                hintStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Lastname",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                    RegExp("[a-zA-Z]")),
                                              ],
                                              minLines: 4,
                                              maxLength: 30,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              onChanged: (value) {
                                                setState(() {
                                                  lastname = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter last name';
                                                }
                                                return null;
                                              },
                                              controller: _lastnameController,
                                              decoration: InputDecoration(
                                                hintText: lastname,
                                                hintStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              /* Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Mobile Number",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              maxLength: 10,
                                              autovalidateMode: AutovalidateMode.onUserInteraction,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              keyboardType:
                                                  TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  mobile = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter valid Mobile Number';
                                                } else if (value.length < 10) {
                                                  return 'Please enter valid Mobile Number';
                                                }
                                                return null;
                                              },
                                              controller: _mobileController,
                                              decoration: InputDecoration(
                                                counterText: '',
                                                hintText: mobile.toString(),
                                                hintStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                border:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),*/
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Date Of Birth",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              keyboardType: TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  dob = value;
                                                });
                                              },
                                              controller: _dobController,
                                              decoration: InputDecoration(
                                                  hintText: dob,
                                                  hintStyle: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 14),
                                                  border:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 3),
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(10),
                                                    ),
                                                  ),
                                                  suffixIcon: IconButton(
                                                      onPressed: () =>
                                                          displayDatePicker(
                                                              context),
                                                      icon: const Icon(Icons
                                                          .date_range_outlined))),
                                              readOnly: true,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Address",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              textInputAction:
                                                  TextInputAction.next,
                                              maxLines: 4,
                                              maxLength: 300,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                              cursorColor: Colors.black,
                                              keyboardType: TextInputType.text,
                                              onChanged: (value) {
                                                setState(() {
                                                  address = value.trim();
                                                });
                                              },
                                              controller: _addressController,
                                              decoration: InputDecoration(
                                                counterText: '',
                                                hintText: address,
                                                labelStyle: GoogleFonts.poppins(
                                                    fontSize: 14),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 3),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter Address';
                                                }
                                                return null;
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8),
                              //   child: Container(
                              //     height: MediaQuery.of(context).size.height / 13,
                              //     width: MediaQuery.of(context).size.width / 1,
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.grey),
                              //         borderRadius: BorderRadius.circular(10)),
                              //     padding: const EdgeInsets.all(8),
                              //     // color: Colors.white,
                              //     child: DropdownButtonHideUnderline(
                              //       child: ButtonTheme(
                              //         alignedDropdown: true,
                              //         child: DropdownButton<String>(
                              //           isExpanded: true,
                              //           value: myState,
                              //           iconSize: 30,
                              //           icon: (null),
                              //           style: GoogleFonts.poppins(
                              //             color: Colors.black,
                              //             fontSize: 14,
                              //           ),
                              //           hint: Text('Select State',
                              //               style: GoogleFonts.poppins(
                              //                   color: Colors.black, fontSize: 14)),
                              //           onChanged: (newValue) {
                              //             myCity = null;
                              //             setState(() {
                              //               myState = newValue!;
                              //               getCities(myState);
                              //             });
                              //           },
                              //           items: statename.map((item) {
                              //             return DropdownMenuItem(
                              //               child: Text(item['name']),
                              //               value: item['id'].toString(),
                              //             );
                              //           }).toList() ??
                              //               [],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: const EdgeInsets.all(8),
                              //   child: Container(
                              //     height: MediaQuery.of(context).size.height / 13,
                              //     width: MediaQuery.of(context).size.width / 1,
                              //     decoration: BoxDecoration(
                              //         border: Border.all(color: Colors.grey),
                              //         borderRadius: BorderRadius.circular(10)),
                              //     padding: const EdgeInsets.all(8),
                              //     // color: Colors.white,
                              //     child: DropdownButtonHideUnderline(
                              //       child: ButtonTheme(
                              //         alignedDropdown: true,
                              //         child: DropdownButton<String>(
                              //           isExpanded: true,
                              //           value: myCity,
                              //           iconSize: 30,
                              //           icon: (null),
                              //           style: GoogleFonts.poppins(
                              //               color: Colors.black, fontSize: 14),
                              //           hint: Text('Select City',
                              //               style: GoogleFonts.poppins(
                              //                 color: Colors.black,
                              //                 fontSize: 14,
                              //               )),
                              //           onChanged: (String? newValue) {
                              //             setState(() {
                              //               myCity = newValue!;
                              //             });
                              //           },
                              //           items: cityname.map((item) {
                              //             return DropdownMenuItem(
                              //               child: Text(item['name']),
                              //               value: item['id'].toString(),
                              //             );
                              //           }).toList() ??
                              //               [],
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SizedBox(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Pin code",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Column(
                                          children: <Widget>[
                                            TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              maxLength: 6,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  color: Colors.black),
                                              cursorColor: Colors.black,
                                              inputFormatters: [
                                                FilteringTextInputFormatter.allow(
                                                    RegExp("[0-9]")),
                                              ],
                                              keyboardType: TextInputType.number,
                                              onChanged: (value) {
                                                setState(() {
                                                  pincode = value;
                                                });
                                              },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter valid Pin Number';
                                                } else if (value.length < 6) {
                                                  return 'Please enter valid Pin Number';
                                                }
                                                return null;
                                              },
                                              controller: _pincodeController,
                                              decoration: InputDecoration(
                                                counterText: '',
                                                hintText: pincode,
                                                hintStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14),
                                                border: const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.black,
                                                      width: 3),
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
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
                                      onPressed: _clicked
                                          ? null
                                          : () async {
                                              setState(() {
                                                _clicked = true;
                                              });
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                if (proImage == 0) {
                                                  form2(
                                                      _firstnameController.text,
                                                      _lastnameController.text,
                                                      gender.toString(),
                                                      _mobileController.text,
                                                      _dobController.text,
                                                      _addressController.text,
                                                      myState.toString(),
                                                      myCity.toString(),
                                                      _pincodeController.text);
                                                } else {
                                                  form1(
                                                      profileimg,
                                                      _firstnameController.text,
                                                      _lastnameController.text,
                                                      gender.toString(),
                                                      _mobileController.text,
                                                      _dobController.text,
                                                      _addressController.text,
                                                      myState.toString(),
                                                      myCity.toString(),
                                                      _pincodeController.text);
                                                }
                                                setState(() {
                                                  isLoading = true;
                                                });
                                                await Future.delayed(const Duration(seconds: 2));
                                                setState(() {
                                                  isLoading = false;
                                                });
                                              } // set it to true now
                                            },
                                      child: (isLoading)
                                          ? const SizedBox(
                                              width: 25,
                                              height: 25,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3,
                                              ))
                                          : Text(
                                              "Submit",
                                              style: GoogleFonts.poppins(
                                                textStyle: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Image(image: AssetImage('asset/Add3.png')),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
   //  bottomNavigationBar: const BottomBar(),
      ),
    );
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
                fontSize: 14,
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
