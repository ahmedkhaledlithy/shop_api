import 'package:dsc_shop/shared/circle_paint.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/views/profile/profile_image.dart';
import 'package:dsc_shop/views/profile/profile_info.dart';
import 'package:dsc_shop/views/profile/user_info.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static final _scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.indigo[800],
        ),
        CustomPaint(
          painter: Background(),
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: transparent,
              elevation: 0,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: whiteColor,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              title: Text(
                'Profile',
                style: TextStyle(color: whiteColor),
              ),
              centerTitle: true,
            ),
            backgroundColor: transparent,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: grey50Color,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                  ),
                ),
                ProfileImage(),
                UserInfo(),
                ProfileInfo(),
              ],
            ),
          ),
        ),
      ],
    );
  }



}
