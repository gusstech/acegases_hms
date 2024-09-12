import 'dart:convert';

import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/dio/api/auth.dart';
import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';

class LoginController extends DisposableProvider {
  TextEditingController mobile = TextEditingController();
  TextEditingController password = TextEditingController();
  String? _mobileErr;
  String? _passErr;
  LoginController();

  String? get mobileErr => _mobileErr;
  String? get passErr => _passErr;
  bool get canSubmit => mobileErr == null && passErr == null;

  void validatePhone(String value) {
    if (value.isEmpty) {
      _mobileErr = 'Phone number cannot be empty';
      // } else if (!PhoneNumberValidator.isValid(value)) {
      //   _mobileErr = 'Enter a valid phone number';
    } else {
      _mobileErr = null;
    }
    notifyListeners();
  }

  void validatePass(String value) {
    if (value.isEmpty) {
      _passErr = 'Password number cannot be empty';
    } else {
      _passErr = null;
    }
    notifyListeners();
  }

  //Function starts here
  Future<bool> getUserLogin(BuildContext context) async {
    AuthApi authApi = AuthApi(context);

    if (mobile.text.isNotEmpty && password.text.isNotEmpty && canSubmit) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      await authApi.login(context, mobile.text, password.text).then(
          (value) async {
        print("#############");
        if (value.result == true) {
          // if (DateFormat("M/d/yyyy h:mm:ss a")
          //     .parse(value.gdlExpiryDate!)
          //     .isAfter(DateTime.now())) {
          //   Appcache.usrRef = value;
          //   Appcache.setString(Appcache.loginDate,
          //       DateFormat("yyyy-MM-dd").format(DateTime.now()));
          //   Appcache.setString(Appcache.userCredential, jsonEncode(value));

          //   return true;
          // }
          if ((value.gdlResult == false &&
              value.licenceResult == false &&
              value.passPortResult == false)) {
            Appcache.usrRef = value;
            Appcache.setString(Appcache.loginDate,
                DateFormat("yyyy-MM-dd").format(DateTime.now()));
            Appcache.setString(Appcache.userCredential, jsonEncode(value));

            if (value.gdlError!.isNotEmpty ||
                value.licenceError!.isNotEmpty ||
                value.passPortError!.isNotEmpty) {
              String displayText = value.gdlError!.isNotEmpty
                  ? value.gdlError!
                  : value.licenceError!.isNotEmpty
                      ? value.licenceError!
                      : value.passPortError!.isNotEmpty
                          ? value.passPortError!
                          : "Something went wrong";

              await showDialog(
                context: context,
                // barrierColor: Colors.transparent,
                barrierDismissible: true,
                builder: (context) => CustomAlertDialog(
                  type: CustomAlertType.alert,
                  description: displayText,
                  isLogout: false,
                  popButtonText: "OK",
                ),
              ).then((v) {
                return true;
              });
            } else {
              return true;
            }
          } else {
            if (value.gdlResult == true) {
              return await showDialog(
                context: context,
                // barrierColor: Colors.transparent,
                barrierDismissible: true,
                builder: (context) => CustomAlertDialog(
                  type: CustomAlertType.error,
                  description: value.gdlError ?? "Something went wrong",
                  isLogout: false,
                  popButtonText: "OK",
                ),
              );
            }
            if (value.licenceResult == true) {
              return await showDialog(
                context: context,
                // barrierColor: Colors.transparent,
                barrierDismissible: true,
                builder: (context) => CustomAlertDialog(
                  type: CustomAlertType.error,
                  description: value.licenceError ?? "Something went wrong",
                  isLogout: false,
                  popButtonText: "OK",
                ),
              );
            }
            if (value.passPortResult == true) {
              return await showDialog(
                context: context,
                // barrierColor: Colors.transparent,
                barrierDismissible: true,
                builder: (context) => CustomAlertDialog(
                  type: CustomAlertType.error,
                  description: value.passPortError ?? "Something went wrong",
                  isLogout: false,
                  popButtonText: "OK",
                ),
              );
            }
            return await showDialog(
              context: context,
              // barrierColor: Colors.transparent,
              barrierDismissible: true,
              builder: (context) => CustomAlertDialog(
                type: CustomAlertType.error,
                description: value.error ?? "Something went wrong",
                isLogout: false,
                popButtonText: "OK",
              ),
            );
          }
        } else {
          Utils.printInfo('LOGIN ERROR: ${value.error}');
          return await showDialog(
            context: context,
            // barrierColor: Colors.transparent,
            barrierDismissible: true,
            builder: (context) => CustomAlertDialog(
              type: CustomAlertType.error,
              description: value.error ?? "Something went wrong",
              isLogout: false,
              popButtonText: "OK",
            ),
          );
        }
      }, onError: (e) {
        Utils.printInfo('LOGIN ERROR: $e');
      }).whenComplete(() {
        EasyLoading.dismiss();
      });
    } else {
      validatePass(password.text);
      validatePhone(mobile.text);
      return false;
    }
    return Appcache.usrRef?.result ?? false;
  }

  Future logOutUser(BuildContext context) async {
    AuthApi authApi = AuthApi(context);
    await authApi.logout(context);
  }

  Future autoLogin(BuildContext context) async {
    AuthApi authApi = AuthApi(context);
    await authApi.autoLogin(context);
  }

  void clearController() {
    mobile.text = "";
    password.text = "";
    _passErr = null;
    _mobileErr = null;
  }

  @override
  void disposeValues() {
    Appcache.usrRef = null;
    mobile.text = "";
    password.text = "";
  }
}

class PhoneNumberValidator {
  static final RegExp _phoneRegExp = RegExp(r'^01\d');

  static bool isValid(String phoneNumber) {
    return _phoneRegExp.hasMatch(phoneNumber);
  }
}
