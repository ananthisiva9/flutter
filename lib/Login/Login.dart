import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:railway_super_app/ForgotPassword/OTPVerification/EmailVerification.dart';
import 'package:railway_super_app/Network/NetworkValidation.dart';
import 'package:railway_super_app/User/Bottombar.dart';
import 'package:railway_super_app/User/SignUp/OTPVerification/EmailVerification.dart';
import 'package:railway_super_app/utility/api_endpoint.dart';
import 'package:railway_super_app/utility/state_enum.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  BaseWidget? baseWidget;
  bool _isChecked = false;
  @override
  void initState() {
    super.initState();
    _rememberUserDetail();
    baseWidget = BaseWidget();
  }

  @override
  dispose() {
    super.dispose();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool login = false;
  bool isLoading = false;
  StateEnum? state;
  void _handleRemeberme(bool? value) {
    _isChecked = value ?? false; //change
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value ?? false); //change
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _isChecked = value ?? false; //change
    });
  }

  void _rememberUserDetail() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("email") ?? "";
      var password = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;
      if (remeberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text = email;
        _passwordController.text = password;
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  signIn(var email, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String url = ApiEndPoint.login;
    // ignore: prefer_typing_uninitialized_variables
    var token, empId, code;
    Map body = {
      "username": email,
      "password": password,
      "entity_id": "1",
      "agent": "0",
      "device": "1"
    };
    var response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['token'] != null) {
        token = jsonDecode(response.body)['token'];
        empId = jsonDecode(response.body)['employee_id'];
        code = jsonDecode(response.body)['code'];
        sharedPreferences.setString('token', token);
        sharedPreferences.setString('token', token.toString());
        sharedPreferences.setString('emp_id', empId.toString());
        sharedPreferences.setString('code', code.toString());
        if (jsonDecode(response.body)['role_name'] == 'USER') {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Login Successfully'),
            backgroundColor: Colors.green,
          ));
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar(index: 0)),
          );
        }
      } else if (jsonDecode(response.body)['code'] == 500) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Incorrect Username or Password'),
          backgroundColor: Colors.red[900],
        ));
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Invalid Credential'),
        backgroundColor: Colors.red[900],
      ));
    }
  }

  final _formKey = GlobalKey<FormState>();
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image(
            image: const AssetImage('asset/Logo.png'),
            height: MediaQuery.of(context).size.height / 10)
      ],
    );
  }

  Widget _buildName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Railmitraa ',
              style: GoogleFonts.roboto(
                color: const Color(0xff0093DD),
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInput() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SizedBox(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(fontSize: 20),
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLength: 100,
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:
                            const BorderSide(width: 5, color: Colors.green)),
                    hintStyle: TextStyle(
                        color: Colors.grey[800], fontFamily: 'Segoe UI'),
                    labelText: "User Name / Email / Phone Number",
                    labelStyle: GoogleFonts.roboto(fontSize: 18),
                    fillColor: Colors.white70,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter valid User Name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  maxLines: 1,
                  maxLength: 25,
                  // obscureText: isPasswordObscured,
                  style: const TextStyle(fontSize: 20),
                  controller: _passwordController,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        borderSide:
                            const BorderSide(width: 5, color: Colors.green)),
                    hintStyle: TextStyle(color: Colors.grey[800]),
                    labelText: "Password",
                    labelStyle: GoogleFonts.roboto(fontSize: 20),
                    fillColor: Colors.white70,
                    suffixIcon: InkWell(
                      onTap: _toggle,
                      child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        size: 25.0,
                        color: const Color(0xffAEAEAE),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter valid password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    SizedBox(
                        height: 24.0,
                        width: 24.0,
                        child: Theme(
                          data: ThemeData(
                              unselectedWidgetColor:
                                  const Color(0xff00C8E8) // Your color
                              ),
                          child: Checkbox(
                              activeColor: const Color(0xff00C8E8),
                              value: _isChecked,
                              onChanged: _handleRemeberme),
                        )),
                    const SizedBox(width: 10.0),
                    Text("Remember Me",
                        style: GoogleFonts.poppins(
                          color: const Color(0xff646464),
                          fontSize: 14,
                        ))
                  ]),
                  TextButton(
                    onPressed: () async {
                      if (await baseWidget!.isInternet(context)) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PassEmail()),
                        );
                      }
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.roboto(
                        color: const Color(0xff0093DD),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () async {
                  if (await baseWidget!.isInternet(context)) {
                    if (_formKey.currentState!.validate()) {
                      signIn(_emailController.text.trim(),
                          _passwordController.text.trim());
                    }
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(const Duration(seconds: 2));
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                        colors: [Color(0xff5CACF9), Color(0xff0D72D0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 100, right: 100, top: 10, bottom: 10),
                    child: (isLoading)
                        ? const SizedBox(
                            child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ))
                        : Text(
                            "Log In",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, deviceType) {
      return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Image(
                        image: const AssetImage('asset/Add1.png'),
                        height: MediaQuery.of(context).size.height / 8,
                        width: 400),
                  ),
                  _buildLogo(),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildName(),
                  _buildContainer(),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image(
                      image: AssetImage('asset/Add2.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildContainer() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
          width: MediaQuery.of(context).size.width / 1,
          child: Column(children: [
            _buildInput(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  onPressed: () async {
                    if (await baseWidget!.isInternet(context)) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailVerification()),
                      );
                    }
                  },
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Don't have an account? ",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      TextSpan(
                        text: 'Please Register',
                        style: GoogleFonts.poppins(
                          color: const Color(0xff0093DD),
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          ])),
    );
  }
}
