import 'package:dsc_shop/models/product.dart';
import 'package:dsc_shop/services/cart.dart';
import 'package:dsc_shop/services/favourite.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleCard extends StatelessWidget {
  final Product product;
  const SingleCard({Key? key,required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isInCart = Provider.of<CartModel>(context).items.contains(product);
    bool alreadyFav = Provider.of<FavouriteModel>(context).favourites.contains(product);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsScreen(product: product)));
        },
        child: Container(
          height: height * .3,
          width: width * .5,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: primaryColor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Image.network(product.image!, fit: BoxFit.fill)),
              SizedBox(
                height: height * .02,
              ),
              Text(product.title!, maxLines: 1),
              Text(
                product.price.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: isInCart
                          ? null
                          : () {
                        context.read<CartModel>().add(product);
                      },
                      icon: isInCart
                          ? const Icon(Icons.check, semanticLabel: 'ADDED')
                          : const Icon(Icons.add_shopping_cart)),
                  IconButton(
                      onPressed: () {
                        if (alreadyFav) {
                          context.read<FavouriteModel>().removeFav(product.id!);
                        } else {
                          context.read<FavouriteModel>().addFav(product);
                        }
                      },
                      icon: alreadyFav
                          ? const Icon(
                        Icons.favorite,
                        color: redColor,
                      )
                          : const Icon(Icons.favorite_border)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
