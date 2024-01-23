import 'package:flutter/material.dart';
class ProductByCatScreen extends StatefulWidget {
  const ProductByCatScreen({Key? key}) : super(key: key);

  @override
  State<ProductByCatScreen> createState() => _ProductByCatScreenState();
}

class _ProductByCatScreenState extends State<ProductByCatScreen> {
  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(6, 12, 16, 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){},

                      )

                    ],
                  ),
                  )
                ],
              ),
            ),

          ],
        ),

      ),
    );
  }
}
