import 'package:dsc_shop/constants_languages.dart';
import 'package:dsc_shop/controllers/cart.dart';
import 'package:dsc_shop/controllers/favourite.dart';
import 'package:dsc_shop/controllers/product_api.dart';
import 'package:dsc_shop/controllers/bottom_nav_provider.dart';
import 'package:dsc_shop/controllers/progress.dart';
import 'package:dsc_shop/controllers/theme.dart';
import 'package:dsc_shop/localization_delegate.dart';
import 'package:dsc_shop/views/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    ChangeNotifierProvider(create: (BuildContext context)=>ThemeChanger(ThemeData.light())),
    ChangeNotifierProvider(create: (BuildContext context)=>CartModel()),
    ChangeNotifierProvider(create: (BuildContext context)=>FavouriteModel()),
  ],
  child: MyApp()));
}

class MyApp extends StatefulWidget {

  static void setLocale(BuildContext context,Locale locale){
    _MyAppState? state=context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  void setLocale(Locale locale){
    setState(() {
      _locale=locale;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getLocale().then((locale) {
      setState(() {
        this._locale=locale;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: theme.getTheme(),
      locale: _locale,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalization.delegate
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('ar', 'EG'),
      ],
      localeResolutionCallback: (currentLocale,supportedLocales){
        if(currentLocale != null){
          for(Locale locale in supportedLocales){
            if(currentLocale.languageCode==locale.languageCode ){
              return currentLocale;
            }
          }
        }
        return supportedLocales.first;
      },
    );
  }
}

