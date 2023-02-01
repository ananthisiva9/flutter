import 'package:admin_dashboard/utility/state_enum.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Login_Controller.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  void initState() {
    super.initState();
  }
  Widget _buildWelcome() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Welcome To Our',
              maxLines: 2,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Sukh Prasavam',
              maxLines: 2,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEmail() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        controller: _emailController,
        decoration: const InputDecoration(
          prefixIcon: const Icon(
            Icons.email,
            color: Colors.white,
          ),
          labelText: 'E-mail',
          labelStyle: const TextStyle(
              color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildPassword(LoginController controller) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.white,
        keyboardType: TextInputType.text,
        obscureText: controller.isPasswordObscured,
        controller: _passwordController,
        decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.lock,
              color: Colors.white,
            ),
            labelText: 'Password',
            labelStyle: const TextStyle(
                color: Colors.white, fontSize: 14, fontFamily: 'Avenir'),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            suffixIcon: InkWell(
              onTap: controller.togglePassword,
              child: const Icon(
                Icons.visibility,
                color: Colors.white,
              ),
            )),
      ),
    );
  }

  Widget _buildLoginBtn(LoginController controller) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 1.4 * (MediaQuery.of(context).size.height / 20),
            width: 5 * (MediaQuery.of(context).size.width / 08),
            margin: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xffe14589) , // foreground (text) color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                if (controller.state != StateEnum.loading) {
                  controller.loginMethod(
                      _emailController.text, _passwordController.text);
                }
              },
              child: controller.state == StateEnum.loading
                  ? const CircularProgressIndicator(
                color: Colors.white,
              )
                  : const Text(
                "Login",
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 1.5,
                  fontSize: 20,
                  fontFamily: 'Avenir',
                ),
              ),
            ),
          ),
        ],
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
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildWelcome(),
                  _buildLogo(),
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
            const Radius.circular(20),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Please Login to continue",
                        maxLines: 2,
                        style: GoogleFonts.poppins(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                _buildEmail(),
                _buildPassword(controller),
                _buildLoginBtn(controller),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
