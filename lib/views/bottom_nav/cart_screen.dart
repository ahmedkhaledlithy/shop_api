import 'package:dsc_shop/controllers/cart.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/drawer.dart';
import 'package:dsc_shop/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("DSC Shop",
          style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: primaryColor,)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: primaryColor),
      ),
      drawer: DrawerWidget(),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return   GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 3.0,),
            itemCount: cart.items.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: cart.items[index],)));
                  },

                  child: Container(
                    height: height * .3,
                    width: width * .5,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(color: primaryColor)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Image.network(cart.items[index].image!)),
                        SizedBox(height: height*.02,),
                        Text("${cart.items[index].title}",maxLines: 1),
                        Text("${cart.items[index].price}",style: TextStyle(fontWeight: FontWeight.bold),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(icon: Icon(Icons.delete), onPressed: (){
                              cart.remove(cart.items[index].id!);
                            }),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }


      ),
    );
  }


}
