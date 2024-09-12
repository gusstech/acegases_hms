import 'package:acegases_hms/splash_screen.dart';
import 'package:acegases_hms/view/auth/login_view.dart';
import 'package:acegases_hms/view/home/home_view.dart';
import 'package:acegases_hms/view/job/job_detail.dart';
import 'package:acegases_hms/view/job/update_job_view.dart';
import 'package:acegases_hms/view/pti/pti_checklist_view.dart';
import 'package:acegases_hms/view/pti/pti_view.dart';
import 'package:flutter/material.dart';

import '../model/trip_model/trip_model.dart';

class AppRoutes {
  static const String splashScreenRoute = "splash_screen";
  static const String loginScreenRoute = "login_screen";
  static const String homeScreenRoute = "home_screen";
  static const String ptiPmSelectionScreenRoute = "pti_pm_selection_screen";
  static const String ptiPmCheckListScreenRoute = "pti_checklist_screen";

  static const String jobDetailScreenRoute = "jobDetailScreenRoute";
  static const String updateJobDetailScreenRoute = "updateJobDetailScreenRoute";
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreenRoute:
        return MaterialPageRoute(builder: (_) => const LoginView());
      case splashScreenRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case homeScreenRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case ptiPmSelectionScreenRoute:
        var argument = settings.arguments as bool;
        return MaterialPageRoute(
            builder: (_) => PtiView(
                  fromMain: argument,
                ));
      case ptiPmCheckListScreenRoute:
        return MaterialPageRoute(builder: (_) => const PTICheckListView());
      case jobDetailScreenRoute:
        var argument = settings.arguments as TripDataDTO;
        return MaterialPageRoute(
            builder: (_) => JobDetailView(
                  data: argument,
                ));
      case updateJobDetailScreenRoute:
        var argument = settings.arguments as TripJob;

        return MaterialPageRoute(
            builder: (_) => UpdateJobDetailViewDartView(data: argument));
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}
