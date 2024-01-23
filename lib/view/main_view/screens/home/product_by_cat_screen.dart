import 'package:e_commerce_app/models/sneaker_model.dart';
import 'package:e_commerce_app/services/helper.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/view/main_view/screens/home/widgets/stagger_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
class ProductByCatScreen extends StatefulWidget {
  const ProductByCatScreen({Key? key}) : super(key: key);

  @override
  State<ProductByCatScreen> createState() => _ProductByCatScreenState();
}

class _ProductByCatScreenState extends State<ProductByCatScreen> with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
    final width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(
              padding:  EdgeInsets.fromLTRB(width*.02, height*.05, 0, 0),
              height: height*.4,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/top_image.png"),
                      fit: BoxFit.fill)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: const EdgeInsets.fromLTRB(6, 12, 16, 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          AntDesign.close,
                          color: Colors.white,
                        ),

                      ),
                      GestureDetector(
                        onTap: (){

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
              padding:  EdgeInsets.only(top: height*0.2,left: width*.04,right: width*.03),
              child: TabBarView(
                  controller: _tabController,
                  children: [
                    //future builder
              FutureBuilder<List<Sneakers>>(
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
                          crossAxisSpacing:20,
                          mainAxisSpacing:16,
                          itemCount: male!.length,
                          scrollDirection: Axis.vertical,
                          staggeredTileBuilder:(index)=>StaggeredTile.extent(
                              (index % 2==0)?1:1,(index % 4==1 ||index % 4 ==3)?
                              height*0.35:height*0.3
                          ),
                          itemBuilder: (context, index) {
                            final shoe = snapshot.data![index];
                            return StaggerTileWidget(imageUrl: shoe.imageUrl[1],
                                name: shoe.name,
                                price: shoe.price);
                          });
                    }
                  }),
                Container(
                  color: Colors.green,
                  height: 500,
                  width: 300,
                ),
                Container(
                  color: Colors.green,
                  height: 500,
                  width: 300,
                ),
                Container(
                  color: Colors.green,
                  height: 500,
                  width: 300,
                )

              ]),
            ),

          ],
        ),

      ),
    );
  }
}
