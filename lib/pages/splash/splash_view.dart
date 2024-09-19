import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_structure/pages/splash/splash_controller.dart';
import '../../constants/app_images.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1), // Adjust animation duration
          curve: Curves.easeInOut, // Customize animation curve
          child: Image.asset(
            icAppLogo, // Replace with your image path
          ),
        ),
      ),
    );
  }
}