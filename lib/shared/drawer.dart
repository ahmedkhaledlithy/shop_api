import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/constants_languages.dart';
import 'package:dsc_shop/services/auth.dart';
import 'package:dsc_shop/services/firestore.dart';
import 'package:dsc_shop/services/theme.dart';
import 'package:dsc_shop/localization_delegate.dart';
import 'package:dsc_shop/main.dart';
import 'package:dsc_shop/models/language.dart';
import 'package:dsc_shop/models/user.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/views/about_screen.dart';
import 'package:dsc_shop/views/login_screen/login.dart';
import 'package:dsc_shop/views/profile/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Provider.of<ThemeChanger>(context);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Drawer(
      child: ListView(
        children: [
          StreamBuilder<DocumentSnapshot>(
            stream: DataBase().getUser(Users(id: FirebaseAuth.instance.currentUser!.uid)),
            builder:(context,AsyncSnapshot<DocumentSnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && !snapshot.data!.exists) {
                return Text("Document does not exist");
              } else{
                Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic> ;

                return DrawerHeader(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                    },
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: UserAccountsDrawerHeader(
                                decoration: BoxDecoration(color: grey400Color, borderRadius: BorderRadius.all(Radius.circular(8)) ),
                                currentAccountPicture: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: NetworkImage(data["image"]),
                                ),
                                accountName: Text(data["fullName"]), accountEmail: Text(data["username"])),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }

            },
          ),
          SizedBox(height: height*.05,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('DARK MODE',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: primary200Color),),
              SizedBox(width: width*.04),
              CupertinoSwitch(
                activeColor: red900Color,
                value: _switchValue,
                onChanged: (value){
                  setState(() {
                    _switchValue = value;
                    if (_switchValue == false){
                      _themeChanger.setTheme(ThemeData.light());
                    }else{
                      _themeChanger.setTheme(ThemeData.dark());
                    }
                  });
                },
              ),
            ],
          ),
          SizedBox(height: height*.02,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButton(
              underline: Container(),
              iconEnabledColor: primaryColor,
              iconDisabledColor: primaryColor,
              isExpanded: true,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 16,
              hint: Text(
                AppLocalization.of(context).getTranslated("change_language")!,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: grey900Color,
                ),
              ),
              style: TextStyle(
                  color: grey900Color,
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
              items: Language.languageList()
                  .map<DropdownMenuItem<Language>>((lang) {
                return DropdownMenuItem(
                  value: lang,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(lang.flag),
                      Text(
                        lang.name,
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (Language? value) {
                setState(() {
                  _changeLanguage(value!);
                });
              },
            ),
          ),

          SizedBox(height: height*.02,),
          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> AboutScreen()));
            },
            child: Row(
              children: [
                Icon(Icons.info_outline, color: primary200Color),
                SizedBox(width: width*.09,),
                Text("About", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: primary200Color),)
              ],
            ),
            style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
          ),
          SizedBox(height: height*.02,),
          ElevatedButton(
            onPressed: (){
              _logOut(context);
            },
            child: Row(
              children: [
                Icon(Icons.exit_to_app, color: redColor),
                SizedBox(width: width*.09,),
                Text("Sign Out", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: redColor),)
              ],
            ),
            style: ElevatedButton.styleFrom(primary: Colors.transparent, shadowColor: Colors.transparent),
          ),
        ],
      ),
    );
  }

  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
    MyApp.setLocale(context, _locale);
  }

  void _logOut(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("KeepMeLoggedIn");
    await authProvider.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}