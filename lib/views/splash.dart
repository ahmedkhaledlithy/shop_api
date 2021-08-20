import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/views/bottom_nav/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'login_screen/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool _isLogged = false;

  _checkLoggedIn() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    if (pref.containsKey("KeepMeLoggedIn")) {
      _isLogged = (pref.getBool('KeepMeLoggedIn') ?? false);
    }


  }




  @override
  void initState() {
    _checkLoggedIn();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateRoute: _isLogged?BottomNavigation():LoginScreen(),
      duration: 3000,
      imageSize: 130,
      imageSrc: "assets/splashScr.png",
      text: "DSC Shop",
      textType: TextType.TyperAnimatedText,
      textStyle: TextStyle(
        fontSize: 30.0,
      ),
      backgroundColor: primary200Color,
    );
  }
}
