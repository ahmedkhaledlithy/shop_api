import 'package:dsc_shop/services/auth.dart';
import 'package:dsc_shop/services/progress.dart';
import 'package:dsc_shop/localization_delegate.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/custom_textformfield.dart';
import 'package:dsc_shop/views/bottom_nav/bottom_navigation.dart';
import 'package:dsc_shop/views/forget.dart';
import 'package:dsc_shop/views/register_screen/signup.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginFormWidget extends StatefulWidget {

   final TextEditingController controller1;
   final TextEditingController controller2;

  LoginFormWidget({required this.controller1,required this.controller2});

  @override
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
   bool obscureText = false;
  bool keepMeLoggedIn = false;

  void keepUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setBool("KeepMeLoggedIn", keepMeLoggedIn);
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider=Provider.of<AuthProvider>(context);
    return ModalProgressHUD(
      inAsyncCall: Provider.of<PrograssHud>(context).isLoading,
      child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(AppLocalization.of(context).getTranslated("login")!,
              style: TextStyle(
                fontSize: 32,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  CustomTextForm(

                    keyboardType: TextInputType.emailAddress,
                    label: AppLocalization.of(context).getTranslated("user_name")!,
                    controller: widget.controller1,
                    prefixIcon: Icon(
                      Icons.email_outlined,
                      color: primaryColor,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your UserName";
                      } else if (!RegExp(
                          "^[a-zA-Z0-9.!#%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*")
                          .hasMatch(value)) {
                        return "Invalid Email";
                      } else {
                        return null;
                      }
                    },

                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                    keyboardType:TextInputType.visiblePassword,
                    label: AppLocalization.of(context).getTranslated("password")!,
                    controller:widget.controller2,
                    prefixStyle: TextStyle(
                      color: whiteColor,
                    ),
                    prefixIcon:Icon(
                      Icons.lock_outlined,
                      color: primaryColor,
                    ),
                    suffix: IconButton(
                      color: primaryColor,
                      icon: Icon(
                        obscureText
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    ),
                    obscure:!obscureText,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Password";
                      } else if (value.length < 6) {
                        return "Password is less than 6 ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                    ),
                    child: InkWell(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text("Forget Password ?",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),

                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgetScreen()));
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: primaryColor,
                          value: keepMeLoggedIn,
                          onChanged: (value) {
                            setState(() {
                              keepMeLoggedIn = value!;
                            });
                          }),
                      Text(AppLocalization.of(context).getTranslated("remember_ms")!,
                        style: TextStyle(color: blackColor, fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Builder(
                    builder: (context) =>
                        Container(
                          width: double.infinity,
                          height: 55,
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  primaryColor),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                              ),
                            ),
                            child: Text(AppLocalization.of(context).getTranslated("login")!,
                              style: TextStyle(
                                color: whiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.1,
                              ),
                            ),
                            onPressed: ()  {
                              final provider=Provider.of<PrograssHud>(context,listen: false);
                              if (_formKey.currentState!.validate()) {
                                provider.changeLoading(true);

                                setState(() {
                                  keepMeLoggedIn = true;
                                });
                                if (keepMeLoggedIn == true) {
                                  keepUserLoggedIn();
                                }

                                authProvider.login(widget.controller1.text, widget.controller2.text).then((_){
                                  provider.changeLoading(false);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));
                                });
                              }
                            },
                          ),
                        ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Create New User ?",
                        style: TextStyle(
                            fontSize: 16,
                            color: grey600Color,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        // minWidth: 0,
                        style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all(Size.zero)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text("Register",
                          style: TextStyle(
                            fontSize: 16,
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
                  ),
                 const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text("Or Login With",
                      style: TextStyle(
                          fontSize: 16,
                          color: grey500Color,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  _bottom(authProvider),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottom(AuthProvider authProvider) {
    final provider=Provider.of<PrograssHud>(context,listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          child: Image(
            image: AssetImage("assets/google.png"),
            fit: BoxFit.cover,
            width: 35,
            height: 35,
          ),
          onTap: () async{
            provider.changeLoading(true);
            setState(() {
              keepMeLoggedIn = true;
            });
            if (keepMeLoggedIn == true) {
              keepUserLoggedIn();
            }
            await authProvider.signInWithGoogle();
            provider.changeLoading(false);
            await authProvider.saveGoogleUser();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>BottomNavigation()));

          },
        ),
      ],
    );
  }



}



