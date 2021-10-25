import 'package:dsc_shop/repositories/bottom_nav_provider.dart';
import 'package:dsc_shop/shared/custom_bottom_nav.dart';
import 'package:dsc_shop/views/bottom_nav/cart_screen.dart';
import 'package:dsc_shop/views/bottom_nav/fav_screen.dart';
import 'package:dsc_shop/views/bottom_nav/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
final provider=Provider.of<BottomProvider>(context);
    return Scaffold(
      body: getBody(provider.selectedIndex),
      bottomNavigationBar: _buildBottomBar(context,provider),
    );
  }

  Widget getBody(int index) {
    List<Widget> pages = [HomeScreen(), FavScreen(), CartScreen()];
    return IndexedStack(index: index, children: pages);
  }

  Widget _buildBottomBar(BuildContext context,BottomProvider provider) {

    return FlashyTabBar(
      selectedIndex: provider.selectedIndex,
      backgroundColor: Colors.white,

      items: <FlashyTabBarItem>[
        FlashyTabBarItem(
          icon: Icon(Icons.home_rounded,),
          title: Text('HOME'),

        ),
        FlashyTabBarItem(
          icon: Icon(Icons.favorite,),
          title: Text('FAVORITES'),
        ),
        FlashyTabBarItem(
          icon: Icon(Icons.shopping_cart),
          title: Text('CART'),
        ),
      ],
      onItemSelected: (index) {
       provider.changeIndex(index);
      },
    );
  }


}