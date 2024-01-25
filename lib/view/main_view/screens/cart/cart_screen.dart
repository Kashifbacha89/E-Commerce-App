import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';

import '../../../../utils/app_utils/app_styles.dart';

class CartScreen extends StatelessWidget {
   CartScreen({Key? key}) : super(key: key);


  final _cartBox= Hive.box('cart_box');

  @override
  Widget build(BuildContext context) {
    List<dynamic> cart=[];
    final cartData=_cartBox.keys.map((key) {
      final item=_cartBox.get(key);
      return {
        "key":key,
        "id":item['id'],
        "name":item['name'],
        "imageUrl":item['imageUrl'],
        "price":item['price'],
        "category":item['category'],
        "qty":item['qty'],
        "sizes":item['sizes']
      };
    }).toList();
    cart=cartData.reversed.toList();
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: Padding(
          padding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * .05,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      AntDesign.close,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    "My Cart",
                    style: appStyle(30, Colors.black, FontWeight.w800),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  SizedBox(
                    height: height * 0.65,
                    child: ListView.builder(
                        itemCount: cart.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final data=cart[index];
                          return Padding(
                              padding: EdgeInsets.all(height * .013),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Slidable(
                                    key: const ValueKey(0),
                                    endActionPane: const ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        SlidableAction(
                                          flex: 1,
                                          onPressed: null,
                                          backgroundColor: Color(0xFF000000),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                      ],
                                    ),
                                    child: Container(
                                      height: height * 0.11,
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade100,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.shade300,
                                            blurRadius: 0.3,
                                            spreadRadius: 5,
                                            offset: const Offset(0, 1),
                                          )
                                        ],
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: CachedNetworkImage(
                                                  imageUrl: data['imageUrl'],
                                                  width: 70,
                                                  height: 70,
                                                  fit: BoxFit.fill,
                                                ),
                                                
                                              ),
                                              Padding(
                                                  padding: EdgeInsets.only(left: width*.02,top: height*.012),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Text(data['name'],style: appStyle(16, Colors.black, FontWeight.w600),),
                                                  const SizedBox(height: 2,),
                                                  Text(data['category'],style: appStyle(12, Colors.grey, FontWeight.w500),),
                                                  const SizedBox(height: 2,),
                                                  Row(
                                                    children: [
                                                      Text("\$${data['price']}",style: appStyle(12, Colors.black, FontWeight.w500),),
                                                      const SizedBox(width: 4,),
                                                      //Text(data['sizes'],style: appStyle(12, Colors.black, FontWeight.w500),),

                                                    ],
                                                  ),



                                                ],
                                              ),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  )));
                        }),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
