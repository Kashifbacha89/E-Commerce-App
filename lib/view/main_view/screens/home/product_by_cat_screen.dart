import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/services/helper.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/utils/app_utils/custom_spacer.dart';
import 'package:e_commerce_app/view/main_view/screens/home/widgets/category_btn_widget.dart';
import 'package:e_commerce_app/view/main_view/screens/home/widgets/latest_shoes_widget.dart';
import 'package:e_commerce_app/view/main_view/screens/home/widgets/stagger_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ProductByCatScreen extends StatefulWidget {
  const ProductByCatScreen({Key? key,required this.tabIndex}) : super(key: key);
  final int tabIndex;

  @override
  State<ProductByCatScreen> createState() => _ProductByCatScreenState();
}

class _ProductByCatScreenState extends State<ProductByCatScreen>
    with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale() {
    _male = Helper().getMaleSneakers();
  }

  void getFemale() {
    _female = Helper().getFemaleSneakers();
  }

  void getKids() {
    _kids = Helper().getKidsSneakers();
  }

  @override
  void initState() {
    super.initState();
    getMale();
    getKids();
    getFemale();
  }
  List<String> brand=[
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(width * .02, height * .05, 0, 0),
              height: height * .4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            AntDesign.close,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            filter();
                          },
                          child: const Icon(
                            FontAwesome.sliders,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: null,
                    indicatorColor: Colors.red,
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: Colors.white,
                    labelStyle: appStyle(16, Colors.white, FontWeight.w900),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),
                    tabs: const [
                      Tab(
                        text: "Men Shoes",
                      ),
                      Tab(
                        text: "Women Shoes",
                      ),
                      Tab(
                        text: "Kids Shoes",
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: height * 0.2, left: width * .04, right: width * .03),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: TabBarView(controller: _tabController, children: [
                  //future builder
                  LatestShoes(male: _male, height: height),
                  LatestShoes(male: _female, height: height),
                  LatestShoes(male: _kids, height: height),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Future<dynamic> filter(){
    final height=MediaQuery.sizeOf(context).height;
    final width=MediaQuery.sizeOf(context).width;
    double _value=100;
    return showModalBottomSheet(
      isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,


        context: context,
        builder: (context)=>Container(
          height: height*0.82,
          width: width,
          decoration: const BoxDecoration(
            color:Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),
            topRight: Radius.circular(25)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 10,),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black38
                ),
              ),
              SizedBox(
                height: height*0.7,
                child: Column(
                  children: [
                    const CustomSpacer(),
                    Text('Filter',style: appStyle(30, Colors.black, FontWeight.w800),),
                    const CustomSpacer(),
                    Text('Gender',style: appStyle(18, Colors.black, FontWeight.bold),),
                    const SizedBox(height: 20,),
                    const Row(
                      children: [
                        CategoryBtn(btnColor:Colors.black , label: 'Men', btnTextColor: Colors.black),
                        CategoryBtn(btnColor:Colors.black , label: 'Women', btnTextColor: Colors.grey),
                        CategoryBtn(btnColor:Colors.black , label: 'Kids', btnTextColor: Colors.grey),
                      ],
                    ),
                    const CustomSpacer(),
                    Text('Category',style: appStyle(20, Colors.black, FontWeight.w700),),
                    const SizedBox(height: 20,),
                    const Row(
                      children: [
                        CategoryBtn(btnColor:Colors.black , label: 'Shoes', btnTextColor: Colors.black),
                        CategoryBtn(btnColor:Colors.black , label: 'Apparels', btnTextColor: Colors.grey),
                        CategoryBtn(btnColor:Colors.black , label: 'Acesories', btnTextColor: Colors.grey),
                      ],
                    ),
                    const CustomSpacer(),
                    Text('price',style: appStyle(20, Colors.black, FontWeight.w700),),
                    const CustomSpacer(),
                    Slider(
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500,
                        divisions: 50,
                        label: _value.toString(),
                        secondaryTrackValue: 200,

                        value: _value,
                        onChanged: (double value){}),
                    const CustomSpacer(),
                    Text('Brand',style: appStyle(20, Colors.black, FontWeight.w700),),
                    const SizedBox(height: 10,),
                    Container(
                      padding: const EdgeInsets.all(8),
                      height: height*.09,
                      child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index){
                            return Padding(padding: const EdgeInsets.all(8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                                
                              ),
                              child: Image.asset(brand[index],
                              width: 80,
                                height: 60,
                                color: Colors.black,
                              ),
                            ),
                            );

                      }),
                    )
                    
                  ],
                ),
              )

            ],
          ),

        ));

  }
}
