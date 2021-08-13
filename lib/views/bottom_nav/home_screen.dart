import 'package:dsc_shop/controllers/auth.dart';
import 'package:dsc_shop/controllers/product_api.dart';
import 'package:dsc_shop/models/product.dart';
import 'package:dsc_shop/views/login_screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 // ProductsApi api = ProductsApi();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_){
      Provider.of<ProductsApi>(context, listen: false).fetchAllProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<ProductsApi>(context).productsList;
    return Scaffold(
      body: ListView.builder(
          cacheExtent: 9999,
          itemCount: products.length > 0 ? products.length : 0,
          itemBuilder: (context, index) {
            final Product currentProduct = products[index];

            return _drawSingleCard(currentProduct);
          }
          ),

    );
  }

  Widget _drawSingleCard(Product product) {
    return GestureDetector(
      onTap: (){
       
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            SizedBox(
              child: Image.network(
                product.image!,
                fit: BoxFit.cover,
              ),
              width: 120,
              height: 120,
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    product.title!,
                    maxLines: 2,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                
                      Text(product.description!),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  void logOut(
    BuildContext context,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("KeepMeLoggedIn");
    await authProvider.logout();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
