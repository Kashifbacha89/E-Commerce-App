import 'package:e_commerce_app/controllers/main_screen_controller.dart';
import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/view/main_view/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/view/main_view/screens/home/home_screen.dart';
import 'package:e_commerce_app/view/main_view/screens/home/product_by_cat_screen.dart';
import 'package:e_commerce_app/view/main_view/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/view/main_view/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import 'widgets/bottom_nav_bar.dart';
import 'widgets/bottom_nav_widgets.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  List<Widget> pageList = const [
    HomeScreen(),
    SearchScreen(),
    ProductByCatScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenProvider, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: Center(child: pageList[mainScreenProvider.pageIndex]),
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
