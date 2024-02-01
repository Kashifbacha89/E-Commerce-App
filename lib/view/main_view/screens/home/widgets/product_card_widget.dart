import 'package:e_commerce_app/controllers/favourite_controller.dart';
import 'package:e_commerce_app/models/constant.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/view/main_view/screens/favourite/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductCardWidget extends StatefulWidget {
  const ProductCardWidget({Key? key, required this.price, required this.category, required this.id, required this.name, required this.image}) : super(key: key);
  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCardWidget> createState() => _ProductCardWidgetState();
}

class _ProductCardWidgetState extends State<ProductCardWidget> {
  final _favBox=Hive.box('fav_box');
  Future<void> _createFav(Map<String,dynamic> addFav)async{
    await _favBox.add(addFav);
   // getFavourite();


  }
  /*getFavourite(){
    final favData=_favBox.keys.map((key) {
      final item=_favBox.get(key);
      return {
        "key":key,
        "id":item["id"],
      };
    }).toList();
    favourite=favData.toList();
    ids=favourite.map((item) => item['id']).toList();
    setState(() {
    });
  }*/
  @override
  Widget build(BuildContext context) {
    final favouriteNotifier=Provider.of<FavoritesNotifier>(context,listen: true);
    favouriteNotifier.getFavourite();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    bool selected=true;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        8,
        0,
        20,
        0,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: height,
          width: width * 0.6,
          decoration: const BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1, 1))
          ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: height * 0.23,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: NetworkImage(widget.image),
                    )),
                  ),
                  Positioned(
                      right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: (){
                          if(favouriteNotifier.ids.contains(widget.id)){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>const FavouriteScreen()));
                          }else{
                            _createFav({
                              "id":widget.id,
                              "name":widget.name,
                              "category":widget.category,
                              "price":widget.price,
                              "image":widget.image[0]
                            });
                          }
                          setState(() {
                          });

                        },
                        child: favouriteNotifier.ids.contains(widget.id)?const Icon(AntDesign.heart):const Icon(AntDesign.hearto),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: appStyleWithHt(
                          25, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,
                      style: appStyleWithHt(
                          16, Colors.grey, FontWeight.bold, 1.5),
                    ),
                  ],
                ),
              ),
              Padding(padding:  EdgeInsets.symmetric(horizontal: width*.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.price,style: appStyle(16, Colors.black, FontWeight.w800),),
                    Row(
                      children: [
                        Text('Colors',style: appStyle(14, Colors.grey, FontWeight.w600),),
                        const SizedBox(
                          width: 5,),
                        const CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 12,
                        ),
                        const SizedBox(width: 2,),
                        const CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          radius: 12,
                        ),

                      ],
                    )
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
