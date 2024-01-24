import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final PageController _pageController=PageController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: CustomScrollView(
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
                        onPageChanged: (page){

                        },
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                height: height*0.39,
                                width: width,
                                color: Colors.grey.shade300,
                                child: CachedNetworkImage(imageUrl: '',fit: BoxFit.contain,),
                              ),
                              Positioned(
                                  top: height*.09,
                                  right:20,
                                  child: const Icon(AntDesign.heart,color: Colors.grey,)),
                              Positioned(
                                  top: height*0.03,
                                  left: 0,
                                  right:0,
                                  bottom:0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,

                                    children: List<Widget>.generate(4, (index) => const Padding(padding: EdgeInsets.symmetric(horizontal: 4),
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.grey,
                                    ),
                                    )),))
                            ],
                          );

                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
