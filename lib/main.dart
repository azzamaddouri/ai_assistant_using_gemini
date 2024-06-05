import 'package:ai_assistant/apis/app_write.dart';
import 'package:ai_assistant/helper/global.dart';
import 'package:ai_assistant/helper/pref.dart';
import 'package:ai_assistant/screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Pref.initialize();
  AppWrite.init();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: appName,
        debugShowCheckedModeBanner: false,
        themeMode: Pref.defaultTheme,
        darkTheme: ThemeData(
            //useMaterial3: false,
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              titleTextStyle:
                  TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            )),
        theme: ThemeData(
            //useMaterial3: false,
            appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: Colors.blue),
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
              color: Colors.blue, fontSize: 20, fontWeight: FontWeight.w500),
        )),
        home: const SplashScreen());
  }
}

extension AppTheme on ThemeData {
  Color get lightTextColor =>
      brightness == Brightness.dark ? Colors.white70 : Colors.black54;
  Color get buttonColor =>
      brightness == Brightness.dark ? Colors.cyan.withOpacity(.5) : Colors.blue;
}
