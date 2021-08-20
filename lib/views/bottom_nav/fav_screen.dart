import 'package:dsc_shop/controllers/favourite.dart';
import 'package:dsc_shop/shared/colors.dart';
import 'package:dsc_shop/shared/drawer.dart';
import 'package:dsc_shop/views/details/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({Key? key}) : super(key: key);

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
      body: Consumer<FavouriteModel>(
          builder: (context, fav, child) {

            return   GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 3.0,),
              itemCount: fav.favourites.length,
              itemBuilder: (context,index){
                final bool alreadyFav =fav.favourites.contains(fav.favourites[index]);

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsScreen(product: fav.favourites[index],)));
                    },

                    child: Container(
                      height: height * .3,
                      width: width * .5,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),border: Border.all(color: primaryColor)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(child: Image.network(fav.favourites[index].image!)),
                          SizedBox(height: height*.02,),
                          Text("${fav.favourites[index].title}",maxLines: 1),
                          Text("${fav.favourites[index].price}",style: TextStyle(fontWeight: FontWeight.bold),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed:  () {
                                if (alreadyFav) {
                                  context.read<FavouriteModel>().removeFav(fav.favourites[index].id!);
                                } else {
                                  context.read<FavouriteModel>().addFav(fav.favourites[index]);
                                }
                              }, icon: alreadyFav?const Icon(Icons.favorite,color: redColor,)
                                  :const Icon(Icons.favorite_border)),
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
