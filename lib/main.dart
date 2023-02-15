import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:railway_super_app/SpalshScreen/splash_screen_view.dart';
import 'package:railway_super_app/User/Dashboard/User.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'Login/Login.dart';
import 'OnBoard/Onboard.dart';
import 'User/SignUp/SignUp/SignUp.dart';
import 'dummy.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
  runApp(const Railway());
}
class Railway extends StatelessWidget {
  const Railway({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Poppins',
              primarySwatch: Colors.blue,
            ),
            home: Splash(),
          );
        }
    );
  }
}