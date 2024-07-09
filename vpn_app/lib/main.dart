import 'package:flutter/material.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:vpn_basic_project/allScreens/splash_screen.dart';
import 'package:vpn_basic_project/appPreferences/app_preferences.dart';

late Size sizeScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppPreferences.initHive();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Free Vpn',
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 3),
      ),
      themeMode: AppPreferences.isModeDark ? ThemeMode.dark : ThemeMode.light,
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: AppBarTheme(centerTitle: true, elevation: 3),
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

extension AppTheme on ThemeData {
  Color get lightTextColor =>
      AppPreferences.isModeDark ? Colors.white70 : Colors.black;
  Color get bottomNavigationColor =>
      AppPreferences.isModeDark ? Colors.white12 : Colors.pinkAccent;
  Color get backgroundColor =>
      AppPreferences.isModeDark ? Colors.blueGrey : Colors.black38;
  Color get backgroundColor2 => AppPreferences.isModeDark
      ? Colors.black38
      : Color.fromARGB(255, 218, 217, 211);
  Color get iconColor =>
      AppPreferences.isModeDark ? Colors.white : Colors.black;
  DecorationImage get backgroundImage => AppPreferences.isModeDark
      ? DecorationImage(
          image: AssetImage('assets/images/dark_background.jpg'),
          fit: BoxFit.fill,
        )
      : DecorationImage(
          image: AssetImage('assets/images/light_background.jpg'),
          fit: BoxFit.fill,
        );
}
