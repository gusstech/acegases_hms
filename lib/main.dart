import 'package:acegases_hms/controller/auth/login_controller.dart';
import 'package:acegases_hms/controller/driver_vehicle/driver_vehicle_controller.dart';
import 'package:acegases_hms/controller/trip/trip_controller.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:acegases_hms/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<DriverVehicleController>(
      create: (context) => DriverVehicleController(),
    ),
    ChangeNotifierProvider<PtiModel>(
      create: (context) => PtiModel(),
    ),
    Provider<ThemeModel>(
      create: (context) => ThemeModel(),
    ),
    ChangeNotifierProvider<LoginController>(
      create: (context) => LoginController(),
    ),
    ChangeNotifierProvider<TripController>(
      create: (context) => TripController(),
    ),
  ], child: const MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AceGases',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void configEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..progressColor = Colors.blue
      ..backgroundColor = Colors.transparent
      ..indicatorColor = Colors.blue
      ..textColor = Colors.white
      ..maskColor = Colors.black.withOpacity(0.5)
      ..userInteractions = false
      ..dismissOnTap = false;
  }

  @override
  void initState() {
    configEasyLoading();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeModel>(builder: (context, controller, _) {
      return MaterialApp(
        title: 'AceGases HMS',
        theme: controller.getTheme(),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generatedRoute,
        initialRoute: AppRoutes.splashScreenRoute,
        navigatorKey: navigatorKey,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: FlutterEasyLoading(
              child: child,
            ),
          );
        },
      );
    });
  }
}
