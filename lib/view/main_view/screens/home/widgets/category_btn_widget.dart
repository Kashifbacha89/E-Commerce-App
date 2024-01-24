import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';
class CategoryBtn extends StatelessWidget {
  const CategoryBtn({Key? key, this.onPress, required this.btnColor, required this.label, required this.btnTextColor}) : super(key: key);
  final void Function()? onPress;
  final Color btnColor;
  final String label;
  final Color btnTextColor;

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
    final width=MediaQuery.sizeOf(context).width;
    return MaterialButton(onPressed: onPress,
      child: Container(
        height: 40,
        width: width*.255,
        decoration: BoxDecoration(
          border: Border.all(color: btnColor,
          width: 1.5,
          style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Center(child: Text(label,style: appStyle(16, btnTextColor, FontWeight.w700),)),

      ),

    );
  }
}
