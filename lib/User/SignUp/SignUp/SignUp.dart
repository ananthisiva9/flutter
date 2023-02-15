import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:railway_super_app/Login/Login.dart';
import 'package:railway_super_app/User/Contest/LatestContest/Image%20Contest/Crop.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Registration extends StatefulWidget {
  String? email;
  Registration({Key? key, this.email}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late StreamSubscription connectivitySubscription;
  String? token, message;
  int withoutImage = 0;
  late DateTime pickedDate;
  bool isLoading = false;
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var gender,
      dropdownvalue,
      profileimg,
      nameData,
      desc,
      first_name,
      last_name,
      user_name,
      dob,
      number,
      address,
      password,
      code,
      pincode,
      myState,
     myCity,myStateId,myCityId;
  String selected = "0";
  final _picker = ImagePicker();
  List<RadioModel> sampleData = <RadioModel>[];
  ScrollController scrollController = ScrollController();
  bool loading = false;
  int page = 1;
  var statename = [];
  var cityname = [];

  Future<void> signupimg(
      File imageFile,
      String firstname,
      String lastname,
      String username,
      String dob,
      String gender,
      String mobile,
      String address,
      String state,
      String city,
      String pinCode,
      String password,
      String confirmPassword,
      String email,
      String code) async {
    String url = ApiEndPoint.signUp;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    http.MultipartRequest request =
    http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> body = {
      "firstname": firstname,
      "lastname": lastname,
      "code": username,
      "dob": dob,
      "gender": gender,
      "ph_no": mobile,
      "address": address,
      "state": state,
      "city": city,
      "pincode": pinCode,
      "password": password,
      "password": confirmPassword,
      "country": '1',
      "email_id": widget.email.toString(),
      "2FA-Code": code,
      "entity_id": "1",
      "is_agent": "0",
      "latitude": "",
      "longitude": "",
      "role": "0",
    };

    File file = File(imageFile.path);
    request.fields.addAll(body);
    request.files.add(http.MultipartFile(
        'prof_photo', file.readAsBytes().asStream(), file.lengthSync(),
        filename: file.path.split('/').last));
    var response = await request.send();
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      if (map['code'] == 500) {
        // ignore: use_build_context_synchronously

        if(map["description"]=="MOBILE NUMBER ALREADY REGISTER" || map["description"]=="EMAIL ID ALREADY REGISTER"){
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(map["description"]),
            backgroundColor: Colors.red,
          ));
        }
        else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("User Name Already Registered"),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account Register Successfully'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } else {
      return;
    }
  }

  Future<void> signup(
      String firstname,
      String lastname,
      String username,
      String dob,
      String gender,
      String mobile,
      String address,
      String state,
      String city,
      String pinCode,
      String password,
      String confirmPassword,
      String email,
      String code) async {
    String url = ApiEndPoint.signUp;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.get('token') as String?;
    http.MultipartRequest request =
    http.MultipartRequest('POST', Uri.parse(url));
    Map<String, String> body = {
      "firstname": firstname,
      "lastname": lastname,
      "code": username,
      "dob": dob,
      "gender": gender,
      "ph_no": mobile,
      "address": address,
      "state": state,
      "city": city,
      "pincode": pinCode,
      "password": password,
      "password": confirmPassword,
      "country": '1',
      "email_id": widget.email.toString(),
      "2FA-Code": code,
      "entity_id": "1",
      "is_agent": "0",
      "latitude": "",
      "longitude": "",
      "prof_photo": "",
      "role": "0",
    };
    request.fields.addAll(body);
    var response = await request.send();
    if (response.statusCode == 200) {
      Map map = jsonDecode(await response.stream.bytesToString());
      if (map['code'] == 500) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(map["description"]),
          backgroundColor: Colors.red,
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Account Register Successfully'),
          backgroundColor: Colors.green,
        ));
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
        );
      }
    } else {
      return;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    initPlatformState();
    getState();
    getUserName();
    super.initState();
    sampleData.add(RadioModel(false, 'Male', '1'));
    sampleData.add(RadioModel(false, 'Female', '2'));
    sampleData.add(RadioModel(false, 'Others', '3'));
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
    await http.get(Uri.parse('$cityInfoUrl &id=$myStateId')).then((response) {
      var data = json.decode(response.body);
      setState(() {
        for (var i = 0; i < data['data'].length; i++) {
          cityname.add(data['data'][i]);
        }
        print(cityInfoUrl);
      });
    });
  }

  getUserName() async {
    var url =
        'https://www.railmitraa.app:8088/usrserv/validate_user?query=$user_name';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      desc = jsonDecode(response.body)['message'];
      nameData = jsonDecode(response.body)['status'];
      if (nameData == 200) {
        print('200' + message.toString());
      } else if (nameData == 500) {
        print('500' + message.toString());
      }
    }
  }

  @override
  dispose() {
    super.dispose();
  }

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

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  bool _confirmPassword = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _confirmToggle() {
    setState(() {
      _confirmPassword = !_confirmPassword;
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    if (!mounted) return;
    setState(() {});
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
          'Do You want  cancel Registration?',
          style: GoogleFonts.poppins(fontSize: 14),

        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Login()),
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
        withoutImage = 1;
      });
    }
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
        body: SizedBox(
          /* height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,*/
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Image(
                    image: AssetImage('asset/Add1.png'),
                  ),
                ),
                //   _buildLogo(),
                //  _buildName(),
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
                            height: 300.0,
                            width: 300.0,
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
                                    ? Image.file(
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
                                  // TODO: Icon not centered.
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
                const SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    child: TextFormField(
                                      style: const TextStyle(fontSize: 14),
                                      cursorColor: Colors.black,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                      ],
                                      keyboardType: TextInputType.text,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      onChanged: (value) {
                                        setState(() {
                                          first_name = value.trim();
                                        });
                                      },
                                      controller: _firstnameController,
                                      textInputAction: TextInputAction.next,
                                      maxLength: 30,
                                      decoration: InputDecoration(
                                        errorMaxLines: 2,
                                        counterText: '',
                                        labelText: 'First Name',
                                        labelStyle:
                                        GoogleFonts.poppins(fontSize: 14),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 3),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter First Name';
                                        } else if (first_name.isEmpty) {
                                          return 'Please enter First Name';
                                        }else if (value.length < 4) {
                                          return 'Minimum 4 Characters';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding:
                                    const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    child: TextFormField(
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                                      ],
                                      textInputAction: TextInputAction.next,
                                      autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                      maxLength: 30,
                                      style: const TextStyle(fontSize: 14),
                                      cursorColor: Colors.black,
                                      keyboardType: TextInputType.name,
                                      onChanged: (value) {
                                        setState(() {
                                          last_name = value.trim();
                                        });
                                      },
                                      controller: _lastnameController,
                                      decoration: InputDecoration(
                                        errorMaxLines: 2,
                                        counterText: '',
                                        labelText: 'Last Name',
                                        labelStyle:
                                        GoogleFonts.poppins(fontSize: 14),
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.white, width: 3),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(10),
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter Last Name';
                                        } else if (last_name.isEmpty) {
                                          return 'Please enter Last Name';
                                        }
                                        else if (value.length < 4) {
                                          return 'Minimum 4 Characters';
                                        }
                                        return null;
                                      },
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: Column(
                          children: [
                            TextFormField(
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                              ],
                              textInputAction: TextInputAction.next,
                              maxLength: 30,
                              autovalidateMode:
                              AutovalidateMode.onUserInteraction,
                              style: const TextStyle(fontSize: 14),
                              cursorColor: Colors.black,
                              keyboardType: TextInputType.name,
                              onChanged: (value) {
                                setState(() {
                                  user_name = value.trim();
                                });
                                getUserName();
                              },
                              controller: _usernameController,
                              decoration: InputDecoration(
                                errorMaxLines: 2,
                                counterText: '',
                                labelText: 'User Name',
                                labelStyle: GoogleFonts.poppins(fontSize: 14),
                                border: const OutlineInputBorder(
                                  borderSide:
                                  BorderSide(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter User Name';
                                } else if (user_name.isEmpty) {
                                  return 'Please enter User Name';
                                } else if (value.length < 4) {
                                  return 'Minimum 4 Characters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          textInputAction: TextInputAction.next,
                          controller: _dobController,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            counterText: '',
                            labelText: 'Date Of Birth',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          readOnly: true,
                          validator: (value) {
                            Duration diff;
                            var year = 0;
                            if(value != null && value.isNotEmpty && value != "") {
                              diff = DateTime.now().difference(pickedDate);
                              year = ((diff.inDays) / 365).round();
                            }
                            if (value == null || value.isEmpty || value == "") {
                              return 'Please enter your DOB';
                            } else if (year < 18) {
                              return 'Please enter age above  18';
                            } else if (year > 100) {
                              return 'Please enter age below  100';
                            }
                            return null;
                          },
                          onTap: () async {
                            pickedDate = (await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime.now()))!;
                            setState(() {
                              _dobController.text =DateFormat('dd-MM-yyyy').format(pickedDate);
                            });
                          },

                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height/10,
                        child: Center(
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(10),
                            shrinkWrap: true,
                            itemCount: sampleData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    for (var element in sampleData) {
                                      element.isSelected = false;
                                    }
                                    sampleData[index].isSelected = true;
                                    gender = sampleData[index].id;
                                  });
                                },
                                child: Container(
                                    width: MediaQuery.of(context).size.width/3.15,
                                    child: RadioItem(sampleData[index])),
                              );
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                         textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          maxLines: 1,
                          maxLength: 10,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              number = value;
                            });
                          },
                          controller: _mobileController,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            counterText: '',
                            labelText: 'Mobile Number',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter Mobile Number';
                            } else if (value.length < 10) {
                              return 'Please enter valid Mobile Number';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          maxLines: 3,
                          maxLength: 300,
                          style: const TextStyle(fontSize: 14),
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
                            labelText: 'Address',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Address';
                            } else if (address.isEmpty) {
                              return 'Enter Address';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 13,
                          width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton2(
                                  isExpanded: true,
                                  focusColor: Colors.white,
                                  hint: Text(
                                    'Select State',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),

                                  //style: Colors.red,

                                  items: statename
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        value: item["name"]
                                            .toString(), //MSM_id
                                        child: Text(
                                          item["name"].toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                  value: myState,
                                  onChanged: (value) {
                                    myCity = null;
                                    setState(() {
                                      myState = statename.where((c) => c['name'] == value).toList().first;
                                      myStateId = myState['id'];
                                      myState = myState['name'];
                                      getCities(myState);
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 200,
                                  itemHeight: 40,
                                  dropdownMaxHeight: 400,
                                  searchController: stateController,
                                  searchInnerWidget: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      controller: stateController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Select State',
                                        hintStyle:
                                        const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (myState == null) {
                                          return 'Enter your state';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return (item.value
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(searchValue
                                        .toString()
                                        .toLowerCase()));
                                  },
                                  //This to clear the search value when you close the menu
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      stateController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 13,
                          width: MediaQuery.of(context).size.width / 1,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8),
                          child: DropdownButtonHideUnderline(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButton2(
                                  isExpanded: true,
                                  focusColor: Colors.white,
                                  hint: Text(
                                    'Select City',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context).hintColor,
                                    ),
                                  ),
                                  items: cityname
                                      .map((item) =>
                                      DropdownMenuItem<String>(
                                        value: item["name"].toString(),
                                        child: Text(
                                          item["name"].toString(),
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                      .toList(),
                                  value: myCity,
                                  onChanged: (newValue) {
                                    setState(() {
                                      myCity = cityname.where((c) => c['name'] == newValue).toList().first;
                                      myCityId = myCity['id'];
                                      myCity = myCity['name'];
                                    });
                                  },
                                  buttonHeight: 40,
                                  buttonWidth: 200,
                                  itemHeight: 40,
                                  dropdownMaxHeight: 400,
                                  searchController: cityController,
                                  searchInnerWidget: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 8,
                                      bottom: 4,
                                      right: 8,
                                      left: 8,
                                    ),
                                    child: TextFormField(
                                      controller: cityController,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        contentPadding:
                                        const EdgeInsets.symmetric(
                                          horizontal: 10,
                                          vertical: 8,
                                        ),
                                        hintText: 'Select State',
                                        hintStyle:
                                        const TextStyle(fontSize: 12),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                          BorderRadius.circular(8),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.isEmpty) {
                                          return 'Enter your city';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  searchMatchFn: (item, searchValue) {
                                    return (item.value
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(searchValue
                                        .toString()
                                        .toLowerCase()));
                                  },
                                  //This to clear the search value when you close the menu
                                  onMenuStateChange: (isOpen) {
                                    if (!isOpen) {
                                      cityController.clear();
                                    }
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                         textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                          maxLines: 1,
                          maxLength: 6,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              pincode = value;
                            });
                          },
                          controller: _pincodeController,
                          decoration: InputDecoration(
                            counterText: '',
                            labelText: 'Pincode',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Pincode';
                            } else if (value.length < 6) {
                              return 'Enter Pincode';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          maxLines: 1,
                          maxLength: 16,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            errorMaxLines: 3,
                            counterText: '',
                            labelText: 'Password',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: _toggle,
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 25.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            print(value);
                            bool passValid = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                                .hasMatch(value!);
                            if (value.isEmpty) {
                              return 'Please enter valid password';
                            } else if (!passValid) {
                              print(passValid);
                              return 'Use 8 or more character with mix of letters,numbers and symbol';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(" ")
                          ],
                          maxLines: 1,
                          maxLength: 16,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.name,
                          onChanged: (value) {
                            setState(() {
                              password = value;
                            });
                          },
                          controller: _confirmController,
                          obscureText: _confirmPassword,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            counterText: '',
                            labelText: 'Confirm Password',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                            suffixIcon: InkWell(
                              onTap: _confirmToggle,
                              child: Icon(
                                _confirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 25.0,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter valid password';
                            } else if (value != _passwordController.text) {
                              return 'Password Not Match';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.next,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                          ],
                         maxLines: 1,
                          maxLength: 4,
                          style: const TextStyle(fontSize: 14),
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              code = value;
                            });
                          },
                          controller:  _codeController,
                          decoration: InputDecoration(
                            errorMaxLines: 2,
                            counterText: '',
                           labelText: 'Security code for Verification Login',
                            labelStyle: GoogleFonts.poppins(fontSize: 14),
                            border: const OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter code Number';
                            } else if (value.length < 4) {
                              return 'Please enter valid code Number';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
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
                      if (_formKey.currentState!.validate()) {
                        if (myState == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please select state"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (myCity == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please select city"),
                            backgroundColor: Colors.red,
                          ));
                        } else if (gender == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Please select gender"),
                            backgroundColor: Colors.red,
                          ));
                        } else {
                          if(withoutImage == 0){
                            signup(
                              _firstnameController.text.toString().trim(),
                              _lastnameController.text.toString().trim(),
                              _usernameController.text.toString().trim(),
                              _dobController.text.toString().trim(),
                              gender.toString().toString().trim(),
                              _mobileController.text.toString().trim(),
                              _addressController.text.toString().trim(),
                              myStateId.toString(),
                              myCityId.toString(),
                              _pincodeController.text.toString().trim(),
                              _passwordController.text.toString().trim(),
                              _confirmController.text.toString().trim(),
                              widget.email.toString().toString().trim(),
                              _codeController.text.toString().trim(),
                            );
                          }
                          else{
                            signupimg(
                              profileimg!,
                              _firstnameController.text.toString().trim(),
                              _lastnameController.text.toString().trim(),
                              _usernameController.text.toString().trim(),
                              _dobController.text.toString().trim(),
                              gender.toString().toString().trim(),
                              _mobileController.text.toString().trim(),
                              _addressController.text.toString().trim(),
                              myStateId.toString(),
                              myCityId.toString(),
                              _pincodeController.text.toString().trim(),
                              _passwordController.text.toString().trim(),
                              _confirmController.text.toString().trim(),
                              widget.email.toString().toString().trim(),
                              _codeController.text.toString().trim(),

                            );
                          }
                        }
                      }
                      setState(() {
                        loading = true;
                      });
                      await Future.delayed(const Duration(seconds: 2));
                      setState(() {
                        loading = false;
                      });
                    },
                    child: (loading)
                        ? const SizedBox(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ))
                        : Text(
                      "Submit",
                      style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(image: AssetImage('asset/Add2.png')),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Powered By ',
                      style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 16),
                    ),
                    const Image(image: AssetImage('asset/Fisst.png')),
                  ],
                )
              ],
            ),
          ),
        ),
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
                fontSize: 16,
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

// Future<dynamic> StateDialog() {
//   return showDialog(
//     context: context,
//     builder: (context) => AlertDialog(
//       title:
//           Container(
//             height: 700,
//             child: ListView.builder(
//                 controller: scrollController,
//                 itemCount: result.length,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(result[index].name),
//                 )),
//       ),
//     ),
//   );
// }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 100,
      margin: const EdgeInsets.all(7),
      child: Container(
        decoration: BoxDecoration(
          color:
          _item.isSelected ? const Color(0xff0093DD) : Colors.transparent,
          border: Border.all(
              width: 1.0,
              color: _item.isSelected ? Colors.blueAccent : Colors.grey),
          borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_item.buttonText,
                  style: TextStyle(
                      color: _item.isSelected ? Colors.white : Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ],
          ),
        ),
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText, id;
  RadioModel(this.isSelected, this.buttonText, this.id);
}