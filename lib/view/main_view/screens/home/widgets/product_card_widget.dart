import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

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
  @override
  Widget build(BuildContext context) {
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
                        onTap: null,
                        child: const Icon(MaterialCommunityIcons.heart_outline),
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
                        ChoiceChip(label: const Text(""),
                            selected: selected,
                        visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30), // Adjust the radius as needed
                          ),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        )

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
