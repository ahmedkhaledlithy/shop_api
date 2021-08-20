import 'package:dsc_shop/models/product.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:flutter/material.dart';

class DetailsContent extends StatelessWidget {
  final Product product;
  const DetailsContent({Key? key,required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 36),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:const EdgeInsets.only(left: 25),
              child: Text(product.title!,
                style: TextStyle(
                    color: pink600Color,
                    fontSize: 30,
                    fontWeight: FontWeight.w600),
              ),
            ),

           const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Category :",
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            "${product.category}",
                            style: TextStyle(
                                color: grey700Color,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              letterSpacing: 1.1
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Description :",
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${product.description}",
                        style: TextStyle(
                          color: grey700Color,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text("Price :",
                            style: TextStyle(
                                fontSize: 20,
                                color: blackColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(width: 5,),
                      Text(
                        "${product.price!.toInt()}",
                        style: TextStyle(
                            fontSize: 18,
                            color: pink600Color,
                            fontWeight: FontWeight.w500),
                      ),
                      Text("\$",
                        style: TextStyle(
                            fontSize: 18,
                            color: pink600Color,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    height: 40,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
                        backgroundColor:MaterialStateProperty.all(primaryColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                        ),
                      ),

                      child:Text('CheckOut',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          letterSpacing: 1.1,
                        ),
                      ),
                      onPressed: ()  {

                      },
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
