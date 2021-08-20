import 'package:dsc_shop/models/product.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/image_widget.dart';
import 'package:dsc_shop/views/details/details_content.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;


  const DetailsScreen({Key? key, required this.product,}) : super(key: key);

  static final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: whiteColor,
      child: SafeArea(
        child: Stack(
          children: [
            ImageWidget(
                screenHeight: screenHeight * 0.8,
                screenWidth: screenWidth,
                url: product.image!),
            Scaffold(
              key: _scaffoldKey,
              backgroundColor: transparent,
              appBar: AppBar(
                title: Text(
                  "Details",
                  style: TextStyle(color: whiteColor),
                ),
                centerTitle: true,
                backgroundColor: transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: whiteColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                const  SizedBox(
                    height: 155 ,
                  ),
                  Expanded(
                    child: Container(
                      height: screenHeight,
                      decoration: BoxDecoration(
                        color: grey50Color,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(35),
                          topRight: Radius.circular(35),
                        ),
                      ),
                      child: DetailsContent(product: product,),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              right:  25,
              child: MaterialButton(
                height: 25,
                minWidth: 25,
                color: whiteColor,
                onPressed: () {

                },
                child:const Icon(
                        Icons.favorite_border_outlined,
                        color: redAccentColor,
                        size: 30,
                      ),
                padding: EdgeInsets.all(14),
                shape: CircleBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
