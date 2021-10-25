import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dsc_shop/models/user.dart';
import 'package:dsc_shop/services/auth.dart';
import 'package:dsc_shop/services/firestore.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return StreamBuilder<DocumentSnapshot>(
      stream: DataBase().getUser(Users(id: Provider.of<AuthProvider>(context).currentUser())),
      builder:(context,snapshot) {
        if(snapshot.hasError){
          return Text(snapshot.error.toString());
        }
        else if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasData && !snapshot.data!.exists) {
          return Text("Document does not exist");
        }

        else {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: 0,
            right: 0,
            child:Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(data["fullName"],
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(data["username"],
                  style: TextStyle(
                      color: grey500Color,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          );
        }


      },
    );
  }
}
