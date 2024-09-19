import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:getx_structure/pages/splash/splash_bindings.dart';
import 'package:getx_structure/routes/app_pages.dart';

import 'constants/app_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX Structure',
      initialRoute: AppPages.initialRoute,
      getPages: AppPages.routes,
      initialBinding: SplashBindings(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
        useMaterial3: false,
        fontFamily: APP_FONT,
      ),
    );
  }
}
