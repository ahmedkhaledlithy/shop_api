import 'package:dsc_shop/controllers/cart.dart';
import 'package:dsc_shop/controllers/product_api.dart';
import 'package:dsc_shop/models/product.dart';
import 'package:dsc_shop/shared/app_bar.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/drawer.dart';
import 'package:dsc_shop/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final bool isSearching = false;
  late List<Product> allProduct;
  late List<Product> searchedProduct;
  final _searchTextController = TextEditingController();

  @override
  void dispose() {
    _searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: FutureBuilder<List<Product>>(
          future:
              Provider.of<ProductsApi>(context, listen: false).fetchAllProducts(),
          builder: (context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                cacheExtent: 9999,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final Product currentProduct = snapshot.data![index];

                  return _drawSingleCard(currentProduct, context);
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 3.0,
                ),
              );
            }

            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget _drawSingleCard(Product product, BuildContext context) {
    bool isInCart = Provider.of<CartModel>(context).items.contains(product);
   // final bool alreadyFav =Provider.of<FavouriteModel>(context).favourites.contains(product);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // return GestureDetector(
    //   child: Padding(
    //     padding: const EdgeInsets.all(10),
    //     child: Row(
    //       children: <Widget>[
    //         SizedBox(
    //           child: Image.network(
    //             product.image!,
    //             fit: BoxFit.cover,
    //           ),
    //           width: 120,
    //           height: 120,
    //         ),
    //         SizedBox(
    //           width: 16,
    //         ),
    //         Expanded(
    //           child: Column(
    //             children: <Widget>[
    //               Text(
    //                 product.title!,
    //                 maxLines: 2,
    //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    //               ),
    //               SizedBox(
    //                 height: 18,
    //               ),
    //
    //                   Text(product.description!),
    //
    //              Row(
    //                children: [

    //                ],
    //              ),
    //
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: product)));
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
                  IconButton(onPressed: isInCart
                      ? null
                      : () {
                    context.read<CartModel>().add(product);
                  }, icon:  isInCart
                      ? const Icon(Icons.check, semanticLabel: 'ADDED')
                      :const Icon(Icons.add_shopping_cart)),

                  // IconButton(onPressed:  () {
                  //   if (alreadyFav) {
                  //     context.read<FavouriteModel>().removeFav(product.id!);
                  //   } else {
                  //     context.read<FavouriteModel>().addFav(product);
                  //   }
                  // }, icon: alreadyFav?const Icon(Icons.favorite,color: redColor,)
                  //     :const Icon(Icons.favorite_border)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
