import 'package:flutter/material.dart';

import '../../../../utils/app_utils/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'This is profile screen',
          style: appStyle(30, Colors.black, FontWeight.w600),
        ),
      ),
    );
  }
}
