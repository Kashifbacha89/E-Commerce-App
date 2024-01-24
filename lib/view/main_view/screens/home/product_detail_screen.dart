import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/services/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.id, required this.category}) : super(key: key);
  final String id;
  final String category;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController = PageController();
  late Future<Sneakers> _man;
  late Future<Sneakers> _female;
  late Future<Sneakers> _kids;
  void getShoes(){
    if(widget.category=="Men's Running"){
      _man=Helper().getMaleSneakersById(widget.id);
    }else if(widget.category=="Women's Running"){
      _female=Helper().getFemaleSneakersById(widget.id);
    }else if(widget.category=="Kid's Running"){
      _kids =Helper().getKidsSneakersById(widget.id);

    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: FutureBuilder<Sneakers>(
          future: getShoes(),
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              return Text("Error${snapshot.hasError}");
            }else{
              final male=snapshot.data!;
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
                                onTap: () {},
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
                                    itemCount: 4,
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
                                              imageUrl: '',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Positioned(
                                              top: height * .09,
                                              right: 20,
                                              child: const Icon(
                                                AntDesign.heart,
                                                color: Colors.grey,
                                              )),
                                          Positioned(
                                              top: height * 0.03,
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                children: List<Widget>.generate(
                                                    4,
                                                        (index) => Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(
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
                                              ))
                                        ],
                                      );
                                    }),
                              ),
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
        )
    );
  }
}
