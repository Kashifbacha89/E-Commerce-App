import 'package:flutter/material.dart';

import '../../../../utils/app_utils/app_styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This is cart screen',
          style: appStyle(30, Colors.black, FontWeight.w600),
        ),
      ),
    );
  }
}
