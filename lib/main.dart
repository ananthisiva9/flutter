import 'package:flutter/material.dart';
import 'package:shebirth/Splash_Screen/splash_screen_view.dart';

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
