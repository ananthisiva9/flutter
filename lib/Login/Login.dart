import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sgx/ForgotPassword/ForgotPassword.dart';
import 'package:sgx/Utility/api_endpoint.dart';
import 'package:sgx/Utility/state_enum.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Login_controller.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void initState() {
    super.initState();
    getData();
  }

  var logo, name;
  late String data;
  bool isLoading = true;
  @override
  getData() async {
    String url = ApiEndPoint.school_data;
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 201) {
      data = response.body;
      setState(() {
        isLoading = false;
        data = response.body;
        name = jsonDecode(data)['data']['name'];
        logo = jsonDecode(data)['logo'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Something Went Wrong!!!'),
        backgroundColor: Colors.red,
      ));
    }
  }

  _launchWhatsapp() async {
    var whatsapp = "+918310361527";
    var whatsappAndroid = Uri.parse(
        "whatsapp://send?phone=$whatsapp&text=Hey, I need help in using Development App");
    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        decoration: const InputDecoration(
          labelText: 'Admin Number',
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildPassword() {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, top: 5, bottom: 5),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        cursorColor: Colors.black,
        keyboardType: TextInputType.text,
        controller: _passwordController,
        decoration: const InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginBtn(LoginController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: Colors.indigo),
        onPressed: () {
          if (controller.state != StateEnum.loading) {
            controller.loginMethod(
                _emailController.text, _passwordController.text);
          }
        },
        child: const Text(
          "Login",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Avenir',
          ),
        ),
      ),
    );
  }

  Widget _buildNeedHelp() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: () {
          _launchWhatsapp();
        },
        child: Text(
          'Need Help ?',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.blue,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ForgotPassword()),
          );
        },
        child: Text(
          'Forgot Password ?',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ChangeNotifierProvider(
          create: (context) => LoginController(context),
          child:
              Consumer<LoginController>(builder: (context, controller, child) {
            return Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/login.jpg').image,
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildContainer(controller),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildContainer(LoginController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.65,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                // Padding(
                // padding: const EdgeInsets.all(8.0),
                //   child: Image(
                // image: NetworkImage(logo.toString()),
                //  height: 50,
                //),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        name.toString(),
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                _buildEmail(),
                _buildPassword(),
                _buildLoginBtn(controller),
                _buildForgotPassword(),
                _buildNeedHelp(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
