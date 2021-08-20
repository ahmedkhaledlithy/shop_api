import 'package:dsc_shop/shared/colors.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary50Color,
      appBar: AppBar(title: Text("About Us",
          style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: primaryColor,)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0, ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Description : DSC Shop is an online shop give you everything you need. ",style: TextStyle(fontSize: 25,color: primaryColor),),
              SizedBox(height: 30,),
              Text("Created by : \n - Ahmed Khaled \n - Athar Hasan",style: TextStyle(fontSize: 25,color: primaryColor)),
              SizedBox(height: 50,),
              Text("Version 1.0",style: TextStyle(fontSize: 25,color: primaryColor))
            ],
          ),
        ),
      ),
    );
  }
}
