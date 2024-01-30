import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/models/constant.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/view/main_view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  final _favBox = Hive.box('fav_box');
  _deleteFav(int key) async {
    await _favBox.delete(key);
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> fav=[];
    final favData=_favBox.keys.map((key){
      final item=_favBox.get(key);
      return {
        "key":key,
        "id":item["id"],
        "name":item['name'],
        "category":item["category"],
        "price":item['price'],
        "imageUrl":item['imageUrl']
      };

    }).toList();
    fav=favData.reversed.toList();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(width * .02, height * .05, 0, 0),
            height: height * .4,
            width: width,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png"),
                    fit: BoxFit.fill)),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text('My Favourite',style: appStyle(32, Colors.white, FontWeight.w800),),
            ),
          ),
          Padding(padding:  EdgeInsets.only(top: height*.12,left: 8,right: 8),
          child: ListView.builder(
            itemCount: fav.length,
              padding: EdgeInsets.only(top: height*.02),
              itemBuilder: (context,index){
              final shoe=fav[index];
              return Padding(padding: const EdgeInsets.all(8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child:Container(
                  height: height*0.12,
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade500,
                        blurRadius: 0.3,
                        spreadRadius: 5,
                        offset: const Offset(0, 1),

                      )
                    ]

                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(padding: EdgeInsets.all(height*.012),
                          child: CachedNetworkImage(imageUrl: shoe['imageUrl']??'',
                          width: 70,
                            height: 70,
                            fit: BoxFit.fill,
                          ),
                          ),
                          Padding(padding: const EdgeInsets.only(
                            left: 20,top: 12
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(shoe['name']??'',
                              style: appStyle(14, Colors.black, FontWeight.w800),
                              ),
                              const SizedBox(height: 5,),
                              Text(shoe['category']??'',style: appStyle(12, Colors.grey, FontWeight.w600),),
                              const SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${shoe['price']??''}",style: appStyle(14, Colors.black, FontWeight.bold),),

                                ],

                              ),


                            ],
                          ),
                          ),


                        ],
                      ),
                      Padding(padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onTap: (){
                            _deleteFav(shoe['key']);
                            ids.removeWhere((element) =>element==shoe['id']);
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>MainScreen()));
                          },
                          child: const Icon(Ionicons.md_heart_dislike),
                        ),
                      )
                    ],
                  ),
                )


              ),
              );


          }),
          )
        ],
      ),
    ));
  }
}
