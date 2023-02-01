import 'package:admin_dashboard/SplashScreen/splash_screen_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Shebirth());
}

class Shebirth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
