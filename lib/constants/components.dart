import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:getx_structure/constants/strings.dart';
import 'app_colors.dart';
import 'app_size.dart';
import 'app_text.dart';

void removeFocus() {
  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
}

Timer? debounce;

void showSnackBar(String message, {Color? bgColor}) {
  if (debounce?.isActive ?? false) debounce?.cancel();
  debounce = Timer(const Duration(milliseconds: 500), () {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(message,
          style: AppText.textRegular.copyWith(color: Colors.black, fontSize: font_14), textAlign: bgColor == null ? TextAlign.start : TextAlign.center),
      titleText: Container(),
      borderRadius: size_4,
      backgroundColor: bgColor ?? Colors.white,
      colorText: Theme.of(Get.context!).colorScheme.surface,
      isDismissible: true,
      animationDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(size_10),

      /*mainButton: TextButton(
      child: Text('Undo'),
      onPressed: () {},
    ),*/
    );
  });
}

Future<void> openAndCloseLoadingDialog(bool isShowHide) async {
  if (Get.overlayContext != null) {
    if (isShowHide) {
      showDialog(
        context: Get.overlayContext!,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () async => false,
            child: Center(
              child: Container(
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.circular(size_100),
                  ),
                  child: CircularProgressIndicator()),
            )),
      );
    } else {
      Navigator.pop(Get.overlayContext!);
    }
  }
}

const apiBaseUrl = 'https://api.themoviedb.org/3';
const apiKey = '3f834ef77eaddfcaad9e5955dc3a6feb';
const imageBaseUrl = 'https://image.tmdb.org/t/p/original';

// Widget commonLoader({double? width, double? height}) {
//   return Lottie.asset(
//     loaderAnim,
//     repeat: true,
//     width: width ?? size_80,
//     height: height ?? size_80,
//   );
// }

Future<bool> checkConnectivity() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  print('connectivityResult ${connectivityResult.first}');
  if (connectivityResult.first == ConnectivityResult.none) {
    print('No internet connection');
    showSnackBar(msgCheckConnection);
    Get.back();
    return false;
  } else {
    print('Internet connection available');
    return true;
  }
}
Widget getNetworkImageView(String imageURL, {double? width, double? height, BoxFit? boxFit, bool isShowLoader = true}) {
  // Future.delayed(Duration(milliseconds: 10), () {
    return ExtendedImage.network(
      imageURL,
      fit: boxFit ?? BoxFit.cover,
      cache: true,
      // Enable caching of the image
      clearMemoryCacheWhenDispose: true,
      clearMemoryCacheIfFailed: true,
      // Clear memory cache when widget is disposed
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            return Container(
              child: const CircularProgressIndicator(
                color: colorDarkRed,
              ),
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              alignment: Alignment.center,
              margin: isShowLoader ? EdgeInsets.zero : EdgeInsets.only(top: size_12),
            );
          case LoadState.completed:
            return null;
          case LoadState.failed:
            return SizedBox(
              width: width ?? double.infinity,
              height: height ?? double.infinity,
              child: Image.asset(
                'imgPlaceHolder',
                fit: BoxFit.contain,
              ).marginAll(size_10),
            );
        }
      },

    );
  // });
}

// Widget getNetworkImageView1(String imageURL,
//     {double? width, double? height, BoxFit? boxFit, bool isShowLoader = true, Color? loaderColor,String? deviceType}) {
//   // print('getNetworkImageView calling ============>>>>>> true');
//   return CachedNetworkImage(
//     imageUrl: imageURL,
//     memCacheHeight: height?.toInt(), // Adjust as needed
//     memCacheWidth: 1000, // Adjust as needed
//     fit: boxFit ?? BoxFit.cover,
//     cacheKey: imageURL,
//     cacheManager: cacheManager,
//     // imageRenderingMode: ImageRenderingMode.auto,
//     progressIndicatorBuilder: (context, url, downloadProgress) => Container(
//       width: width ?? double.infinity,
//       height: height ?? double.infinity,
//       alignment: Alignment.center,
//       margin: isShowLoader ? EdgeInsets.zero : const EdgeInsets.only(top: size_12),
//       child: CircularProgressIndicator(
//         color: loaderColor ?? colorDarkRed,
//         value: downloadProgress.progress,
//       ),
//     ),
//     errorWidget: (context, url, error) => SizedBox(
//       width: width ?? double.infinity,
//       height: height ?? double.infinity,
//       child: Image.asset(
//         imgPlaceHolder,
//         fit: BoxFit.contain,
//       ).marginAll(size_10),
//     ),
//     // Additional properties for optimization
//     fadeInDuration: const Duration(milliseconds: 500), // Optional: Add fade-in animation
//     fadeOutDuration: const Duration(milliseconds: 500), // Optional: Add fade-out animation
//     placeholderFadeInDuration: const Duration(milliseconds: 300), // Optional: Fade-in duration for placeholder
//     //placeholderFadeOutDuration: Duration(milliseconds: 300), // Optional: Fade-out duration for placeholder
//     // You can adjust these durations based on your preferences
//   );
// }
//
// CacheManager cacheManager = CacheManager(
//   Config(
//     'cacheKey',
//
//     // Set a reasonable maximum number of cache objects
//     maxNrOfCacheObjects: 200,
//     // Set a reasonable maximum cache size (e.g., 100 MB)
//     // maxAgeCacheObject: const Duration(days: 7),
//   ),
// );

RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
String Function(Match) mathFunc = (Match match) => '${match[1]},';

stringFormat(String formattedNumber) {
  String value = "311111111.17859265359";
  double number = double.parse(value);
  formattedNumber = number.toStringAsFixed(2);

  print(formattedNumber); // Output: 3.14
}
//
// void commonWebsiteOpen(String url,{bool isAddress=false}) async {
//   if(isAddress==true){
//     final addressUrl = 'https://www.google.com/maps/search/?api=1&query=$url';
//     if (await canLaunchUrl(Uri.parse(addressUrl))) {
//       await launchUrl(Uri.parse(addressUrl));
//     } else {
//       throw 'Could not launch $addressUrl';
//     }
//   }else{
//     if (await canLaunchUrl(Uri.parse(url))) {
//       await launchUrl(Uri.parse(url));
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
// }