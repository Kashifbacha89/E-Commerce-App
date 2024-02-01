import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/utils/app_utils/reusable_text.dart';
import 'package:e_commerce_app/view/main_view/screens/home/widgets/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
  TabController(length: 3, vsync: this);

  /*late Future<List<Sneakers>> _male;
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
  }*/



  @override
  Widget build(BuildContext context) {
    final productProvider=Provider.of<ProductNotifier>(context);
    productProvider.getMale();
    productProvider.getFemale();
    productProvider.getKids();
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
              child: Container(
                padding:  EdgeInsets.only(left: width*.02, bottom: height*.03),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableText(text: "Athletics Shoes",
                         style: appStyleWithHt(
                    38, Colors.white, FontWeight.bold, 1.5)),
                    ReusableText(text: "Collection",
                        style: appStyleWithHt(
                            38, Colors.white, FontWeight.bold, 1.2)),
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
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: height*.27,),
              child: Container(
                padding: const EdgeInsets.only(left: 12),
                child: TabBarView(controller: _tabController, children: [
                  HomeWidget(
                    male: productProvider.male,
                    tabIndex: 0,
                  ),
                  HomeWidget(
                    male: productProvider.female,
                    tabIndex: 1,
                  ),
                  HomeWidget(
                    male: productProvider.kids,
                    tabIndex: 2,
                  ),
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
