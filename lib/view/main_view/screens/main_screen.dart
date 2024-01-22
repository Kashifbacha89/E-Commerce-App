import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:e_commerce_app/view/main_view/screens/cart/cart_screen.dart';
import 'package:e_commerce_app/view/main_view/screens/home/home_screen.dart';
import 'package:e_commerce_app/view/main_view/screens/profile/profile_screen.dart';
import 'package:e_commerce_app/view/main_view/screens/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../widgets/bottom_nav_widgets.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  List<Widget> pageList = const [
    HomeScreen(),
    SearchScreen(),
    HomeScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    int pageIndex = 0;
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: Center(child: pageList[pageIndex]),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16), color: Colors.black),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavWidget(
                    onTap: () {}, icon: MaterialCommunityIcons.home),
                BottomNavWidget(onTap: () {}, icon: Ionicons.search),
                BottomNavWidget(onTap: () {}, icon: Ionicons.add),
                BottomNavWidget(onTap: () {}, icon: Ionicons.cart),
                BottomNavWidget(onTap: () {}, icon: Ionicons.person),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
