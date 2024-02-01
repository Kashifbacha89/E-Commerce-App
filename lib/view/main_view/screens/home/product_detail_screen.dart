import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/controllers/favourite_controller.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/models/constant.dart';
import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/services/helper.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/utils/app_utils/check_out_btn.dart';
import 'package:e_commerce_app/view/main_view/screens/favourite/favourite_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen(
      {Key? key, required this.id, required this.category})
      : super(key: key);
  final String id;
  final String category;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();

  final _cartBox = Hive.box('cart_box');
  Future<void>  _createCart(Map<dynamic,dynamic> newCart)async{
    await _cartBox.add(newCart);
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final favouriteNotifier=Provider.of<FavoritesNotifier>(context,listen: true);
    favouriteNotifier.getFavourite();
    final productNotifier=Provider.of<ProductNotifier>(context,listen: false);
    productNotifier.getShoes(widget.category, widget.id);

    return Scaffold(
        body: FutureBuilder<Sneakers>(
      future: productNotifier.sneakers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Text("Error${snapshot.hasError}");
        } else {
          final sneaker = snapshot.data!;
          return Consumer<ProductNotifier>(
            builder: (context, productNotifier, child) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    automaticallyImplyLeading: false,
                    leadingWidth: 0,
                    pinned: true,
                    snap: false,
                    backgroundColor: Colors.transparent,
                    expandedHeight: height,
                    title: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              productNotifier.shoesSizes.clear();
                            },
                            child: const Icon(
                              AntDesign.close,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Icon(Ionicons.ellipsis_horizontal),
                          )
                        ],
                      ),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Stack(
                        children: [
                          SizedBox(
                            height: height * 0.5,
                            width: width,
                            child: PageView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sneaker.imageUrl.length,
                                controller: _pageController,
                                onPageChanged: (page) {
                                  productNotifier.activePage = page;
                                },
                                itemBuilder: (context, index) {
                                  return Stack(
                                    children: [
                                      Container(
                                        height: height * 0.39,
                                        width: width,
                                        color: Colors.grey.shade300,
                                        child: CachedNetworkImage(
                                          imageUrl: sneaker.imageUrl[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      Positioned(
                                          top: height * .1,
                                          right: 15,
                                          child: GestureDetector(
                                            onTap:(){
                                              if(favouriteNotifier.ids.contains(widget.id)){
                                                Navigator.push(context, MaterialPageRoute(builder: (_)=>const FavouriteScreen()));

                                              }else{
                                                favouriteNotifier.createFav({
                                                  "id":sneaker.id,
                                                  "name":sneaker.name,
                                                  "price":sneaker.price,
                                                  "category":sneaker.category,
                                                  "imageUrl":sneaker.imageUrl[0],
                                                });

                                              }

                                            },
                                            child: favouriteNotifier.ids.contains(sneaker.id)?const Icon(
                                              AntDesign.heart,
                                            ):const Icon(AntDesign.hearto),
                                          ),),
                                      Positioned(
                                          top: height * 0.16,
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List<Widget>.generate(
                                                sneaker.imageUrl.length,
                                                (index) => Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 4),
                                                      child: CircleAvatar(
                                                        radius: 5,
                                                        backgroundColor:
                                                            productNotifier
                                                                        .activePage !=
                                                                    index
                                                                ? Colors.grey
                                                                : Colors.black,
                                                      ),
                                                    )),
                                          )),
                                    ],
                                  );
                                }),
                          ),
                          Positioned(
                              bottom: height * .03,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: height * 0.645,
                                  width: width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          sneaker.name.toString(),
                                          style: appStyle(25, Colors.black,
                                              FontWeight.w900),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              sneaker.category.toString(),
                                              style: appStyle(18, Colors.grey,
                                                  FontWeight.w600),
                                            ),
                                            SizedBox(
                                              width: width * 0.02,
                                            ),
                                            RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Colors.black,
                                                    ),
                                                onRatingUpdate: (rating) {}),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price.toString()}",
                                              style: appStyle(20, Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Text('color',style: appStyle(18, Colors.black, FontWeight.w500),),
                                                const SizedBox(width: 5,),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.black,
                                                ),
                                                const SizedBox(width: 5,),
                                                const CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.redAccent,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(height: height*.02,),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text('Select Sizes',style: appStyle(18, Colors.black, FontWeight.w600),),
                                                SizedBox(width: width*.02,),
                                                Text('View size guide',style: appStyle(18, Colors.grey, FontWeight.w600),),

                                              ],
                                            ),
                                            SizedBox(height: height*.01,),
                                            SizedBox(
                                              height: height*.055,
                                              child: ListView.builder(
                                                  itemCount:
                                                  productNotifier
                                                      .shoesSizes
                                                      .length,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  padding:
                                                  EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sizes =
                                                    productNotifier
                                                        .shoesSizes[
                                                    index];

                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 4.0,
                                                      ),
                                                      child: ChoiceChip(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                60),
                                                            side: const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                                style: BorderStyle
                                                                    .solid)),
                                                        disabledColor:
                                                        Colors.white,
                                                        label: Text(
                                                          sizes['size'],
                                                          style: appStyle(
                                                              14,
                                                              sizes['isSelected']
                                                                  ? Colors
                                                                  .white
                                                                  : Colors
                                                                  .black,
                                                              FontWeight
                                                                  .w700),
                                                        ),
                                                        selectedColor:
                                                        Colors.redAccent.shade400,
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                            8),
                                                        selected: sizes[
                                                        'isSelected'],
                                                        onSelected:
                                                            (newState) {
                                                          if(productNotifier.sizes.contains(sizes['size'])){
                                                            productNotifier.sizes.remove(sizes['size']);
                                                          }else{
                                                            productNotifier.sizes.add(sizes['size']);
                                                          }
                                                          print(productNotifier.sizes);
                                                          productNotifier
                                                              .toggleCheck(
                                                              index);
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                         SizedBox(
                                          height: height*.01,
                                        ),

                                        const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: height*.01,),
                                        SizedBox(
                                          width: width*.8,
                                          child: Text(
                                            sneaker.title.toString(),
                                            style: appStyle(22, Colors.black, FontWeight.w600),
                                          ),
                                        ),
                                        SizedBox(height: height*.01,),
                                        Flexible(
                                          child: Text(sneaker.description.toString(),
                                            textAlign: TextAlign.justify,
                                            style: appStyle(10, Colors.black54, FontWeight.w500),),
                                        ),
                                        SizedBox(height: height*.01,),
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Padding(
                                            padding:  EdgeInsets.only(top: height*.01),
                                            child:  CheckoutButton(
                                              label: 'Add to cart',
                                              onTap: (){
                                                _createCart({
                                                  'id':sneaker.id,
                                                  'name':sneaker.name,
                                                  'category':sneaker.category,
                                                  'sizes':productNotifier.sizes[0],
                                                  'imageUrl':sneaker.imageUrl[0],
                                                  'price':sneaker.price,
                                                  'qty':1
                                                });
                                                productNotifier.sizes.clear();
                                                Navigator.pop(context);
                                              },
                                            )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        }
      },
    ));
  }
}


