import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/controllers/cart_provider.dart';
import 'package:e_commerce_app/utils/app_utils/check_out_btn.dart';
import 'package:e_commerce_app/view/main_view/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_utils/app_styles.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {




  @override
  Widget build(BuildContext context) {
    final cartProvider=Provider.of<CartProvider>(context);
    cartProvider.getCart();


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
                        itemCount: cartProvider.cart.length,
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          final data = cartProvider.cart[index];
                          return Padding(
                              padding: EdgeInsets.all(height * .013),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
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
                                            Stack(
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
                                                Positioned(
                                                    bottom: -2,
                                                    child: GestureDetector(
                                                      onTap: (){
                                                        cartProvider.deleteCart(data['key']);
                                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>MainScreen()));
                                                      },
                                                      child: Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: const BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius: BorderRadius.only(
                                                        topRight:  Radius.circular(10),
                                                        bottomLeft: Radius.circular(10),
                                                      ),


                                                  ),
                                                        child: const Icon(AntDesign.delete,
                                                          size: 18,
                                                          color: Colors.white,),
                                                ),
                                                    ))
                                              ],
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: width * .02,
                                                  top: height * .012),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data['name'],
                                                    style: appStyle(
                                                        16,
                                                        Colors.black,
                                                        FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    data['category'],
                                                    style: appStyle(
                                                        12,
                                                        Colors.grey,
                                                        FontWeight.w500),
                                                  ),
                                                  const SizedBox(
                                                    height: 2,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "\$${data['price']}",
                                                        style: appStyle(
                                                            12,
                                                            Colors.black,
                                                            FontWeight.w500),
                                                      ),
                                                      SizedBox(
                                                        width: width * .04,
                                                      ),
                                                      Text(
                                                        "Size",
                                                        style: appStyle(
                                                            12,
                                                            Colors.black,
                                                            FontWeight.w600),
                                                      ),
                                                      SizedBox(
                                                        width: width * .02,
                                                      ),
                                                      Text(
                                                        data['sizes'],
                                                        style: appStyle(
                                                            12,
                                                            Colors.black,
                                                            FontWeight.w500),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        //cartProvider
                                                      },
                                                      child: const Icon(
                                                        AntDesign.minussquare,
                                                        size: 20,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    Text(
                                                      data['qty'].toString(),
                                                      style: appStyle(
                                                          12,
                                                          Colors.black,
                                                          FontWeight.w700),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        //cartProvider.decrement(),
                                                      },
                                                      child: const Icon(
                                                        AntDesign.plussquare,
                                                        size: 20,
                                                        color: Colors.black,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  )));
                        }),
                  )
                ],
              ),
              const Align(
                alignment: Alignment.bottomCenter,
                child: CheckoutButton(label: 'Proceed to checkout',

                ),
              )
            ],
          ),
        ));
  }
}
