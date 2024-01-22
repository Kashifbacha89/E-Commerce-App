import 'package:e_commerce_app/controllers/main_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

import 'bottom_nav_widgets.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenProvider, child) {
      return SafeArea(
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
                    onTap: () {
                      mainScreenProvider.pageIndex = 0;
                    },
                    icon: mainScreenProvider.pageIndex == 0
                        ? MaterialCommunityIcons.home
                        : MaterialCommunityIcons.home_outline),
                BottomNavWidget(
                    onTap: () {
                      mainScreenProvider.pageIndex = 1;
                    },
                    icon: mainScreenProvider.pageIndex == 1
                        ? Ionicons.search
                        : Ionicons.search),
                BottomNavWidget(
                    onTap: () {
                      mainScreenProvider.pageIndex = 2;
                    },
                    icon: mainScreenProvider.pageIndex == 2
                        ? Ionicons.add
                        : Ionicons.add_circle_outline),
                BottomNavWidget(
                    onTap: () {
                      mainScreenProvider.pageIndex = 3;
                    },
                    icon: mainScreenProvider.pageIndex == 3
                        ? Ionicons.cart
                        : Ionicons.cart_outline),
                BottomNavWidget(
                    onTap: () {
                      mainScreenProvider.pageIndex = 4;
                    },
                    icon: mainScreenProvider.pageIndex == 4
                        ? Ionicons.person
                        : Ionicons.person_outline),
              ],
            ),
          ),
        ),
      );
    });
  }
}
