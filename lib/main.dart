import 'package:flutter/material.dart';
import 'SpalshScreen/SpalshScreen.dart';

void main() {
  runApp(Sgx());
}

class Sgx extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}