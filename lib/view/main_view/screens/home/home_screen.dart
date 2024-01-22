import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 3, vsync: this);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: SizedBox(
      height: height,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
            height: height * 0.4,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/top_image.png",
                    ),
                    fit: BoxFit.fill)),
            child: Container(
              padding: const EdgeInsets.only(left: 8, bottom: 15),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Athletics Shoes',
                    style:
                        appStyleWithHt(40, Colors.white, FontWeight.bold, 1.2),
                  ),
                  Text(
                    'Collection',
                    style:
                        appStyleWithHt(42, Colors.white, FontWeight.bold, 1.2),
                  ),
                ],
              ),
            ),
          ),
          TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: Colors.transparent,
              controller: _tabController,
              isScrollable: true,
              labelColor: Colors.white,
              labelStyle: appStyle(22, Colors.white, FontWeight.bold),
              unselectedLabelColor: Colors.grey.withOpacity(0.3),
              tabs: const [
                Tab(
                  text: 'Men shoes',
                ),
                Tab(
                  text: 'Women shoes',
                ),
                Tab(
                  text: 'Kids shoes',
                ),
              ]),
          TabBarView(controller: _tabController, children: [
            Column(
              children: [
                Container(
                  height: height * 0.405,
                  color: Colors.amber,
                )
              ],
            )
          ]),
        ],
      ),
    ));
  }
}
