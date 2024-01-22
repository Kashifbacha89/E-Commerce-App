import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return Scaffold(
        body: SizedBox(
      height: height,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
        height: height * 0.4,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
          '',
        ))),
      ),
    ));
  }
}
