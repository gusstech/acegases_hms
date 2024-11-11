import 'dart:convert';

import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/auth/login_controller.dart';
import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashScreen();
  }
}

class _SplashScreen extends State<SplashScreen> {
  @override
  void initState() {
    // Utils.setFirebaseAnalyticsCurrentScreen(Constants.analyticsSplashScreen);
    super.initState();
    _initPackageInfo();
    Future.delayed(Duration(milliseconds: 1000), () {
      startTimer();
    });
  }

  Future<void> _initPackageInfo() async {
    FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration
          .zero, // Forces Remote Config to fetch on every app start during development
    ));

    await remoteConfig.fetchAndActivate();

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Appcache.packageInfo = packageInfo;
    String currentLiveVersion =
        remoteConfig.getValue("current_version").asString();
    String currentLiveBuild = remoteConfig.getValue("build_version").asString();
    print(remoteConfig.toString());
    print(packageInfo.toString());
    Appcache.liveVersion = "$currentLiveVersion.$currentLiveBuild";
  }

  startTimer() async {
    String savedDated = await Appcache.getStringValue(Appcache.loginDate);

    if (savedDated.isNotEmpty &&
        savedDated == DateFormat("yyyy-MM-dd").format(DateTime.now())) {
      try {
        await Appcache.getStringValue(Appcache.userCredential).then((v) {
          Appcache.usrRef = LoginModel.fromJson(jsonDecode(v));
        });
        await Appcache.getStringValue(Appcache.savedVehicle).then((v) {
          Appcache.selectedVehicle = VehicleModel.fromJson(jsonDecode(v));
        });
        LoginController controller =
            Provider.of<LoginController>(context, listen: false);
        controller.autoLogin(context);
        Future.delayed(const Duration(seconds: 1), () async {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.ptiPmSelectionScreenRoute, (route) => false,
              arguments: false);
        });
      } catch (e) {
        Future.delayed(const Duration(seconds: 1), () async {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.loginScreenRoute, (route) => false);
        });
        rethrow;
      }
    } else {
      Future.delayed(const Duration(seconds: 1), () async {
        Navigator.pushNamedAndRemoveUntil(
            context, AppRoutes.loginScreenRoute, (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(),
        width: screenWidth,
        height: screenHeight,
        child: Center(
          child: SizedBox(
            width: 200,
            child: Image.asset(
              Constants.assetImages + 'appicon/ac.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
