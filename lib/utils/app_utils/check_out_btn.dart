import 'package:e_commerce_app/utils/app_utils/app_styles.dart';
import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  const CheckoutButton({
    super.key, this.onTap, required this.label,});

  final void Function()? onTap;
  final String label;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Container(
          height: height * .055,
          width: width * .9,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Text(
              label,
              style: appStyle(12, Colors.white, FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
