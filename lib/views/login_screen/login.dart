import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/image_widget.dart';
import 'package:dsc_shop/views/login_screen/login_form.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  var loginKey = GlobalKey<ScaffoldMessengerState>();
  bool keepMeLoggedIn = false;
  final bool obscureText = false;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        ImageWidget(screenHeight: screenHeight, screenWidth: screenWidth, url: "https://images.pexels.com/photos/3727255/pexels-photo-3727255.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
        Scaffold(
          backgroundColor: transparent,
          key: loginKey,
          body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Transform.translate(
                    offset: Offset(0, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 35, right: 35),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            elevation: 8,
                            child: Image(
                              image:
                              NetworkImage("https://images.pexels.com/photos/3727255/pexels-photo-3727255.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 35,
                            top: 10,
                            right: 35,
                          ),
                          child: Text(
                            "Enjoy With\nDSC SHOP",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 32,
                                height: 1.2,
                                fontWeight: FontWeight.bold,),

                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration: BoxDecoration(
                        color: grey50Color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: LoginFormWidget(controller1: _emailController, controller2: _passwordController,),
                    ),
                  ),
                ],
              ),
            ),

        ),
      ],
    );
  }



}

