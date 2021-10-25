import 'dart:io';
import 'package:dsc_shop/repositories/auth.dart';
import 'package:dsc_shop/repositories/progress.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/views/login_screen/login.dart';
import 'package:dsc_shop/views/register_screen/signup.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as p;

import '../../shared/custom_textformfield.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController emailController;

  final TextEditingController passwordController;

  final TextEditingController confirmPasswordController;

  final TextEditingController fullNameController;

  final TextEditingController phoneController;

  final TextEditingController addressController;

  final double screenWidth;

  RegisterForm({
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.fullNameController,
    required this.phoneController,
    required this.addressController,
    required this.screenWidth,
  });

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureText1 = false;
  bool _obscureText2 = false;

  late String genderValue;

  File? image;
  String? url;


  void radioButtonChanges(String? value) {
    setState(() {
      genderValue = value!;
      switch (value) {
        case 'Male':
          genderValue = value;
          break;
        case 'Female':
          genderValue = value;
          break;
      }
    });
  }

  @override
  void initState() {
    setState(() {
      genderValue = "Male";
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider=Provider.of<AuthProvider>(context);

    return ModalProgressHUD(
      inAsyncCall: Provider.of<PrograssHud>(context).isLoading,
      child: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 32,
                      color: primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            getImageFromGallery();
                          },
                          child: Container(
                            width: 70,
                            height: 70,
                            child: CustomPaint(
                              painter: CirclePainter(),
                              child: CircleAvatar(
                                backgroundColor: transparent,
                                backgroundImage:  image != null ? FileImage(image!) : null,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            getImageFromGallery();
                          },
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: image != null ? transparent : primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Upload Photo",
                      style: TextStyle(color: grey700Color),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, top: 25, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextForm(
                    label: "Full Name",
                    controller: widget.fullNameController,
                    prefixStyle: TextStyle(
                      color: whiteColor,
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: primaryColor,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                    keyboardType: TextInputType.emailAddress,
                    label: "UserName",
                    controller: widget.emailController,
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
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                    keyboardType: TextInputType.visiblePassword,
                    label: "Password",
                    controller: widget.passwordController,
                    prefixStyle: TextStyle(
                      color: grey50Color,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: primaryColor,
                    ),
                    suffix: IconButton(
                      color: primaryColor,
                      icon: Icon(
                        _obscureText1 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText1 = !_obscureText1;
                        });
                      },
                    ),
                    obscure: !_obscureText1,
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
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                    keyboardType: TextInputType.visiblePassword,
                    label: "Confirm Password",
                    controller: widget.confirmPasswordController,
                    prefixStyle: TextStyle(
                      color: grey50Color,
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: primaryColor,
                    ),
                    suffix: IconButton(
                      color: primaryColor,
                      icon: Icon(
                        _obscureText2 ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText2 = !_obscureText2;
                        });
                      },
                    ),
                    obscure: !_obscureText2,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Password";
                      } else if (value != widget.passwordController.text) {
                        return "Password Not Match";
                      } else if (value.length < 6) {
                        return "Password is less than 6 ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                    maxLength: 11,
                    keyboardType: TextInputType.phone,
                    label: "Phone",
                    controller: widget.phoneController,
                    prefixIcon: Icon(
                      Icons.phone,
                      color: primaryColor,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Phone";
                      } else if (value.length < 11) {
                        return "Password is less than 11 ";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextForm(
                    keyboardType: TextInputType.streetAddress,
                    label: "Address",
                    controller: widget.addressController,
                    prefixStyle: TextStyle(
                      color: whiteColor,
                    ),
                    prefixIcon: Icon(
                      Icons.location_city,
                      color: primaryColor,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Your Address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Row(
                        children: [
                          Radio(
                            value: "Male",
                            groupValue: genderValue,
                            onChanged: radioButtonChanges,
                            activeColor: primaryColor,
                          ),
                          Text("Male"),
                          const SizedBox(
                            width: 20,
                          ),
                          Radio(
                            value: "Female",
                            groupValue: genderValue,
                            onChanged: radioButtonChanges,
                            activeColor: primaryColor,
                          ),
                          Text("Female"),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: widget.screenWidth,
                    height: 55,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          letterSpacing: 1.1,
                        ),
                      ),
                      onPressed: () async {
                        final provider=Provider.of<PrograssHud>(context,listen: false);
                        if (_formKey.currentState!.validate()) {
                          provider.changeLoading(true);
                         await authProvider.signUp(widget.emailController.text,widget.passwordController.text);
                          provider.changeLoading(false);
                          await uploadImage(image!);
                          await authProvider.saveUser(
                              fullName: widget.fullNameController.text.trim(),
                              password: widget.passwordController.text.trim(),
                              email: widget.emailController.text.trim(),
                              address: widget.addressController.text.trim(),
                              phone: widget.phoneController.text.trim(),
                              gender: genderValue,
                              photo: url!,
                              );
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));

                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "I have an account!",
                        style: TextStyle(
                            fontSize: 18,
                            color: grey600Color,
                            fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(Size.zero),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 18,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void getImageFromGallery()  {

     ImagePicker().pickImage(source: ImageSource.gallery).then((value){
      setState(() {
        if (value != null) {
          image = File(value.path);
        } else {
          print('No image selected.');
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please select Your Image")));
        }
      });
    });
  }

  Future<String?> uploadImage(File image) async {
    FirebaseStorage storage = FirebaseStorage.instanceFor(bucket: "gs://dsc-shop-a48c1.appspot.com");
    final Reference storageReference = storage.ref().child(p.basename(image.path));
    await storageReference.putFile(image).whenComplete(() async {
     String downUrl= await storageReference.getDownloadURL();
     url=downUrl;
    });
    return url;
  }

}
