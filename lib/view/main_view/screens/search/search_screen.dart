import 'package:e_commerce_app/utils/app_utils/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

import '../../../../utils/app_utils/app_styles.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.sizeOf(context).height;
    final width=MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 100.h,
        backgroundColor: Colors.black,
        elevation: 0,
        title: CustomField(hintText: 'Search for product',
            controller: searchController,
          onEditingComplete: (){
          setState(() {
          });
          },
          prefixIcon: GestureDetector(
            onTap: (){},
            child: const Icon(AntDesign.camera,color: Colors.black,),
          ),
          suffixIcon: GestureDetector(
            onTap: (){
              setState(() {

              });
            },
            child: const Icon(AntDesign.search1,color: Colors.black,),
          ),

        ),
      ),
      body: searchController.text.isEmpty?Container(
        height: height*.6,
        child: Image.asset('assets/images/empty.jpg'),
      ):Container(),
    );
  }
}
