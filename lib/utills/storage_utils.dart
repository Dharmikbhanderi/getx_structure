import 'package:shared_preferences/shared_preferences.dart';


class StorageUtil {
  static const String keyLoginData = "loginData";
  static const String keyInitData = "initData";
  static const String keyToken = "token";
  static const String keyDeviceToken = "device_token";
  static const String keyPermissionAllow = "permissionAllow";
  static const String keyLanguageCode = "languageCode";
  static const String keyCountryCode = "countryCode";
  static const String keyLanguageName = "languageName";
  static const String keyCountryListData = "countryListData";
  static const String keyRecentSearch = "recentSearch";
  static const String keyGuestMode = "guestMode";
  static const String keyRatingValue = "keyRatingValue";
  static const String keyBanner = "checkBanner";


  static Future<dynamic> setData(String key, dynamic value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if (value is String) {
      return pref.setString(key, value);
    } else if (value is int) {
      return pref.setInt(key, value);
    } else if (value is double) {
      return pref.setDouble(key, value);
    } else if (value is bool) {
      return pref.setBool(key, value);
    } else {
      return pref.setString(key, value);
    }
  }

  static Future<dynamic> getData(String key) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get(key);
  }

  static void clearData() {
    SharedPreferences.getInstance().then((value) {
      value.clear();
    });
  }

  static Future<dynamic> clearspecfickey(String key, dynamic value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.remove(key);
  }

  static Future<void> clearLoginData() async {
    // MyNotificationManager().clearNotifications();
    SharedPreferences.getInstance().then((value) {
      value.remove(keyLoginData);
      value.remove(keyToken);
      value.setBool(keyGuestMode, true);
      value.remove(keyRecentSearch);
      value.remove(keyBanner);
    });

  }
}
