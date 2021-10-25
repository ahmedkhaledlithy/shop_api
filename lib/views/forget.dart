import 'package:dsc_shop/services/auth.dart';
import 'package:dsc_shop/services/progress.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/custom_textformfield.dart';
import 'package:dsc_shop/shared/image_widget.dart';
import 'package:dsc_shop/views/login_screen/login.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';


class ForgetScreen extends StatefulWidget {
  const ForgetScreen({Key? key}) : super(key: key);

  @override
  _ForgetScreenState createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {
  TextEditingController _emailController = TextEditingController();

  var forgetKey = GlobalKey<ScaffoldMessengerState>();
  var _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final AuthProvider authProvider=Provider.of<AuthProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: Provider.of<PrograssHud>(context).isLoading,
      child: Stack(
        children: [
          ImageWidget(screenHeight: screenHeight, screenWidth: screenWidth, url: "https://images.pexels.com/photos/3727255/pexels-photo-3727255.jpeg?auto=compress&cs=tinysrgb&h=750&w=1260"),
          Scaffold(
            key: forgetKey,
            backgroundColor: transparent,
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
                          padding: const EdgeInsets.only(left: 35,right: 35),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17),
                            ),
                            elevation: 8,
                            child:Image.asset("assets/logo1.png",
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 35, top: 10,right: 35),
                          child: Text(
                            "Enjoy with  \n DSC SHOP",
                            style: TextStyle(
                                color: whiteColor,
                                fontSize: 32,
                                height: 1.2,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Expanded(
                    child: Container(
                      width: screenWidth,
                      height: screenHeight,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: _form(context,screenWidth,authProvider),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _form(BuildContext context,screenWidth,AuthProvider authProvider) {

    return ListView(
      children: [
        Padding(
            padding: EdgeInsets.only(top: 30),
            child: Text("Forget Password",
              style: TextStyle(
                  fontSize: 32,
                  color: primaryColor,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )),
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
                  label: "UserName",
                  controller: _emailController,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: primaryColor,
                  ),
                  validator: (value) {
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
                SizedBox(
                  height: 40,
                ),
                Container(
                  width: screenWidth,
                  height: 55,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    child: Text("submit",
                      style: TextStyle(
                        color: whiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        letterSpacing: 1.1,
                      ),
                    ),
                    onPressed: () async {
                      final provider=Provider.of<PrograssHud>(context,listen: false);

                      if (_formKey.currentState!.validate()) {
                        provider.changeLoading(true);
                        authProvider.resetPassword(_emailController.text)
                            .catchError((onError) {
                          provider.changeLoading(false);
                          print('Error sending email verification $onError');
                        }).then((_) {
                          provider.changeLoading(false);

                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));

                        });
                      }

                    },
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("I have an account!",
                      style: TextStyle(
                          fontSize: 18,
                          color: grey600Color,
                          fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                      style: ButtonStyle(minimumSize: MaterialStateProperty.all(Size.zero)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text("Login",
                        style: TextStyle(
                          fontSize: 18,
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
              ],
            ),
          ),
        ),
      ],
    );
  }
}
