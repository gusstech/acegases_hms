import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:flutter/material.dart';

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
    startTimer();
  }

  startTimer() {
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushNamedAndRemoveUntil(
          context, AppRoutes.loginScreenRoute, (route) => false);
    });
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
