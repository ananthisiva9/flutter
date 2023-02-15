import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:railway_super_app/SpalshScreen/splash_screen_controller.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  // ignore: library_private_types_in_public_api
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff5CACF9), Color(0xff0D72D0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight),
              ),
            child: Center(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          image: const AssetImage('asset/Logo.png'),
                          height: MediaQuery.of(context).size.height / 5),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Railmitraa",
                        style: GoogleFonts.poppins(
                            fontSize: 30, color: Colors.white,
                        fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    // height: 50,width: 50,
                    // alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(height: 50, width: 50),
                      child: const CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
