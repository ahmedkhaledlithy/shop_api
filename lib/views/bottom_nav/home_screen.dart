import 'package:dsc_shop/models/product.dart';
import 'package:dsc_shop/shared/app_bar.dart';
import 'package:dsc_shop/shared/drawer.dart';
import 'package:dsc_shop/view_models/products_view_model.dart';
import 'package:dsc_shop/views/bottom_nav/single_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  void didChangeDependencies() {
        super.didChangeDependencies();
       final productsApi=Provider.of<ProductsViewModel>(context, listen: false);
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          productsApi.fetchProducts();
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      drawer: DrawerWidget(),
      body: Consumer<ProductsViewModel>(
        builder: (context,model,_){

          return GridView.builder(
            cacheExtent: 9999,
            itemCount: model.productsList.length,
            itemBuilder: (context, index) {
              final Product currentProduct = model.productsList[index];

              return SingleCard(product:currentProduct);
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 3.0,
            ),
          );
        },
      ),
    );
  }

}
