import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';
class StaggerTileWidget extends StatefulWidget {
  const StaggerTileWidget({Key? key,required this.imageUrl,required this.name,required this.price}) : super(key: key);
  final String imageUrl;
  final String name;
  final String price;

  @override
  State<StaggerTileWidget> createState() => _StaggerTileWidgetState();
}

class _StaggerTileWidgetState extends State<StaggerTileWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            CachedNetworkImage(imageUrl: widget.imageUrl,
            fit: BoxFit.fill,
            ),
            Container(
              padding: const EdgeInsets.only(top: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.name,style: appStyleWithHt(18, Colors.black, FontWeight.w800,1),),
                  Text(widget.price,style: appStyleWithHt(18, Colors.black, FontWeight.w600,1),),

                ],
              ),
            )




          ],
        ),
      ),
    );
  }
}
