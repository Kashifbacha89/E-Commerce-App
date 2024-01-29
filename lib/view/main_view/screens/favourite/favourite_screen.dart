import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png"),
                    fit: BoxFit.fill)),
          )
        ],
      ),
    ));
  }
}
