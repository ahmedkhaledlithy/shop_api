import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/user.dart';
import 'package:dsc_shop/services/firestore.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/style.dart';
import 'package:dsc_shop/views/profile/edit_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({Key? key}) : super(key: key);

  @override
  _ProfileInfoState createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();
  String id=FirebaseAuth.instance.currentUser!.uid;
  String providerId = FirebaseAuth.instance.currentUser!.providerData[0].providerId;

 void passData(){
    DataBase().userData(Users(id: id)).then((value){
     nameController.text=value["fullName"];
      phoneController.text=value["phone"]!=null?value["phone"]:"";
      addressController.text=value["address"]!=null?value["address"]:"";
    });
  }

  @override
  void initState() {
    passData();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: DataBase().getUser(Users(id: id)),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        } else {
          Map<String, dynamic> data = snapshot.data!.data() as Map<
              String,
              dynamic>;
          return Positioned(
            top: MediaQuery
                .of(context)
                .size
                .height * 0.350,
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      EditInfo(
                        titleInfo: "Full Name",
                        dataInfo: data["fullName"],
                        onTap: () {
                          updateInfo(
                            context: context,
                            labelTxt: "FullName",
                            bottomSheetTitle: "Update Name",
                            icon: Icons.person,
                            controller: nameController,
                            validatorMessage: 'Please Enter Your FullName',
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {

                                await DataBase().updateUser(Users(id: id),{
                                  "fullName":nameController.text.trim(),
                                });
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                      ),

                        providerId=="google.com"? Container(): EditInfo(
                        titleInfo: "Address",
                        dataInfo: data["address"]== null ?"Address":data["address"],
                        onTap: () {
                          updateInfo(
                            context: context,
                            labelTxt: "Address",
                            bottomSheetTitle: "Update Address",
                            icon: Icons.location_city,
                            controller: addressController,
                            validatorMessage: 'Please Enter Your Address',
                            onPressed: () async{
                              if (_formKey.currentState!.validate()) {

                                await DataBase().updateUser(Users(id: id),{
                                  "address":addressController.text.trim(),
                                });
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                      ),
                      providerId=="google.com"? Container(): EditInfo(
                        titleInfo: "Phone",
                        dataInfo: data["phone"]==null ? "Phone": data["phone"],
                        onTap: () {
                          updateInfo(
                            context: context,
                            labelTxt: "Phone",
                            bottomSheetTitle: "Update Phone",
                            icon: Icons.phone,
                            controller: phoneController,
                            validatorMessage: 'Please Enter Your Phone',
                            onPressed: () async{
                              if (_formKey.currentState!.validate()) {

                                await DataBase().updateUser(Users(id: id),{
                                  "phone":phoneController.text.trim(),
                                });
                                Navigator.pop(context);
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  void updateInfo({
    required BuildContext context,
    required TextEditingController controller,
    required String labelTxt,
    required String bottomSheetTitle,
    IconData? icon,
    required String validatorMessage,
    required VoidCallback onPressed,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
        ),
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(bc).viewInsets.bottom,
                left: 10,
                right: 10,
                top: 15),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        bottomSheetTitle,
                        style: TextStyle(
                            color: blackColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: controller,
                      style: TextStyle(
                        color: blackColor,
                      ),
                      decoration: InputDecoration(
                        labelText: labelTxt,
                        labelStyle: labelStyle,
                        prefixIcon: Icon(
                          icon,
                          color: primaryColor,
                        ),
                        fillColor: Colors.white,
                        focusedBorder: borderF,
                        enabledBorder: borderE,
                        border: borderE,
                        filled: true,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return validatorMessage;
                        } else {
                          return null;
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: redColor),
                            )),
                        TextButton(
                            onPressed: onPressed,
                            child: Text(
                              "Update",
                              style: TextStyle(color: primaryColor),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
