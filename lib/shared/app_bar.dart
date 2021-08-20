import 'package:dsc_shop/models/product.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const AppBarWidget({Key? key}) : super(key: key);

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50.0);
}

class _AppBarWidgetState extends State<AppBarWidget> {
  bool _isSearching = false;
  late List<Product> allProduct;
  late List<Product> searchedProduct;
  final _searchTextController = TextEditingController();



  void addSearchedFOrItemsToSearchedList(String searchedProducts) {
    searchedProduct = allProduct
        .where((product) =>
        product.title!.toLowerCase().startsWith(searchedProducts))
        .toList();
    setState(() {});
  }

  List<Widget> _buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          onPressed: () {
            _clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: primaryColor),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: primaryColor,
          ),
        ),
      ];
    }
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: primaryColor,
      decoration: InputDecoration(
        hintText: 'Search ...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: primaryColor, fontSize: 18),
      ),
      style: TextStyle(color: primaryColor, fontSize: 18),
      onChanged: (searchedProducts) {
        addSearchedFOrItemsToSearchedList(searchedProducts);
      },
    );
  }
  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: primaryColor),
    );
  }

  void _startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch() {
    setState(() {
      _searchTextController.clear();
    });
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(

      title: _isSearching ? _buildSearchField() : Text("DSC Shop",
        style: TextStyle(
            fontSize: 25, fontWeight: FontWeight.bold, color: primaryColor),),
      // decoration: InputDecoration(hintText: "Search ...", hintStyle: TextStyle(color: primaryColor)),style: TextStyle(color: Colors.white,fontSize: 20),
      centerTitle: true,
      actions: _buildAppBarActions(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
    );
  }

}