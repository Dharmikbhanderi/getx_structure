import 'dart:async';
import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:getx_structure/routes/app_pages.dart';


class SplashController extends GetxController with GetTickerProviderStateMixin {

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 2), () {
      Get.offAllNamed(Routes.home);
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

}

