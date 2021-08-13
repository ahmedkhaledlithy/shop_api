import 'package:dsc_shop/controllers/product_api.dart';
import 'package:dsc_shop/controllers/bottom_nav_provider.dart';
import 'package:dsc_shop/controllers/progress.dart';
import 'package:dsc_shop/views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dsc_shop/controllers/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (BuildContext context)=>AuthProvider()),
    ChangeNotifierProvider(create: (BuildContext context)=>PrograssHud()),
    ChangeNotifierProvider(create: (BuildContext context)=>BottomProvider()),
    ChangeNotifierProvider(create: (BuildContext context)=>ProductsApi()),
  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

