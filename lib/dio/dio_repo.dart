import 'package:acegases_hms/view/auth/login_view.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'interceptor/logging.dart';

class DioRepo {
  late Dio mDio;
  int retryCount = 0;
  late BuildContext dioContext;
  final cookieJar = CookieJar();

  Dio baseConfig() {
    Dio dio = Dio();

    dio.options.baseUrl = "https://acegasestms.x1.com.my/AppWebService.asmx";
    dio.options.connectTimeout = Duration(milliseconds: 30000);
    dio.options.receiveTimeout = Duration(milliseconds: 30000);
    dio.httpClientAdapter;

    return dio;
  }

  DioRepo() {
    mDio = baseConfig();
    mDio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // mDio.interceptors.requestLock.lock();
          // // AppCache.getStringValue(AppCache.ACCESS_TOKEN_PREF).then((value) {
          // //   if (value.length > 0) {
          // //     options.headers[HttpHeaders.authorizationHeader] = value;
          // //   }
          // // }).whenComplete(() {
          // mDio.interceptors.requestLock.unlock();
          // });
          return handler.next(options);
        },
        onError: (e, handler) async {
          if (EasyLoading.isShow) {
            EasyLoading.dismiss();
          }
          showErrorDialog("Error", "An error occurred");

          return handler.next(e);
        },
        onResponse: (response, handler) {
          if (response.data is List<int>) {
            return handler.next(response);
          } else if (response.data['errcode'].toString().contains('no-token')) {
            handler.next(response);
            print(response.data);
          } else {
            // if (response.data['Status']
            //     .toString()
            //     .toLowerCase()
            //     .contains('fail')) {
            //   if (EasyLoading.isShow) {
            //     EasyLoading.dismiss();
            //   }
            //   showErrorDialog("Error", response.data["Msg"].toString());
            // }
            // print('67534565346346345634563463456346456');
            return handler.next(response);
          }
        },
      ),
      LoggingInterceptors()
    ]);
  }
  void showErrorDialog(String title, String message) {
    showDialog(
      context: dioContext,
      barrierDismissible: true,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () {
              Navigator.pop(context);
              // AppCache.removeAuthToken();

              // Navigator.pushAndRemoveUntil(
              //     dioContext,
              //     MaterialPageRoute(builder: (context) => LandingScreen()),
              //     (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }

  void showAlertDialog(String title, String message) {
    showDialog(
      context: dioContext,
      barrierDismissible: false,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () {
              // AppCache.removeAuthToken();
              // AppCache.removeValues('usrRef');
              // AppCache.removeValues('usrIC');
              // AppCache.removeValues('fcm');
              Navigator.pushAndRemoveUntil(
                  dioContext,
                  MaterialPageRoute(builder: (context) => const LoginView()),
                  (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}
