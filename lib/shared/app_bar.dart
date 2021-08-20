import 'package:dsc_shop/controllers/product_api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  final _searchTextController = TextEditingController();



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
        Provider.of<ProductsApi>(context, listen: false).changeSearchString(searchedProducts);
       // addSearchedFOrItemsToSearchedList(searchedProducts);
      },
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
      centerTitle: true,
      actions: _buildAppBarActions(),
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: IconThemeData(color: primaryColor),
    );
  }

}