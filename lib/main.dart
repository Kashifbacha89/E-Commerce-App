import 'package:e_commerce_app/controllers/cart_provider.dart';
import 'package:e_commerce_app/controllers/main_screen_controller.dart';
import 'package:e_commerce_app/controllers/product_controller.dart';
import 'package:e_commerce_app/view/main_view/main_screen.dart';
import 'package:e_commerce_app/controllers/favourite_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('cart_box');
  await Hive.openBox('fav_box');


  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => MainScreenNotifier()),
    ChangeNotifierProvider(create: (_)=>ProductNotifier()),
    ChangeNotifierProvider(create: (_)=>FavoritesNotifier()),
    ChangeNotifierProvider(create: (_)=>CartProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375,812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: MainScreen(),
        );
      }
    );
  }
}
