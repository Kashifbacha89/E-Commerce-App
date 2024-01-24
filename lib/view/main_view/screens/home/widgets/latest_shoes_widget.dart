import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/view/main_view/screens/home/widgets/stagger_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneakers>> male,
    required this.height,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final double height;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Sneakers>>(
        future: _male,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return StaggeredGridView.countBuilder(
                padding:EdgeInsets.zero,
                crossAxisCount:2,
                crossAxisSpacing:16,
                mainAxisSpacing:14,
                itemCount: male!.length,
                scrollDirection: Axis.vertical,
                staggeredTileBuilder:(index)=>StaggeredTile.extent(
                    (index % 2==0)?1:1,(index % 4==1 ||index % 4 ==3)?
                height*0.36:height*0.32
                ),
                itemBuilder: (context, index) {
                  final shoe = snapshot.data![index];
                  return StaggerTileWidget(imageUrl: shoe.imageUrl[1],
                      name: shoe.name,
                      price: shoe.price);
                });
          }
        });
  }
}