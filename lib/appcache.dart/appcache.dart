import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Appcache {
  static LoginModel? usrRef;

  static VehicleModel? selectedVehicle;

  static List<VehicleModel> vehicleList = [];

  static List<TripDataDTO> tripList = [];

  static String loginDate = "loginDate";
  static String loginTime = "loginTime";
  static String userCredential = "userCredential";
  static String savedVehicle = "savedVehicle";
  static String liveVersion = "";
  static PackageInfo packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
    installerStore: 'Unknown',
  );

  static bool gotUpdate = false;

  static Future<void> setString(String key, String value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString(key, value);
  }

  static Future<String> getStringValue(String key) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String data = pref.getString(key) ?? "";
    return data;
  }

  static void removeValues(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  // static Future<Locale> setLocale(String languageCode) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(AppCache.languageCode, languageCode);
  //   return Locale(languageCode);
  // }

  // static Future<Locale> getLocale() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String languageCode = prefs.getString(AppCache.languageCode) ?? "en";
  //   return Locale(languageCode);
  // }

  // static void setAuthToken(String accessToken) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   pref.setString(ACCESS_TOKEN_PREF, accessToken);
  // }

  // static void removeAuthToken() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.remove(ACCESS_TOKEN_PREF);
  // }
}
