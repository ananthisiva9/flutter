import 'package:admin_dashboard/SplashScreen/splash_screen_controller.dart';
import 'package:admin_dashboard/widgets/loading_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SplashScreenController(context),
      child: Consumer<SplashScreenController>(
              builder: (context, controller, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: Image.asset('assets/Background.png').image,
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: const [
                       Divider(
                        height: 100,
                        thickness: .1,
                      ),
                      Text(
                        "SUKH PRASAVAM",
                        textAlign: TextAlign.center,
                        style:  TextStyle(
                          color: Color(0xffe14589),
                          fontWeight: FontWeight.bold,
                          fontSize: 50.0,
                        ),
                      ),
                      Text(
                        "An Initiative By Shebirth",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      LoadingIcon()
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
