import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/dio/api/auth.dart';
import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginController extends DisposableProvider {
  LoginModel? usrRef;
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
    } else if (!PhoneNumberValidator.isValid(value)) {
      _mobileErr = 'Enter a valid phone number';
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
          usrRef = value;
        } else {
          Utils.printInfo('LOGIN ERROR: ${value.error}');
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
    return usrRef?.result ?? false;
  }

  void clearController() {
    mobile.text = "";
    password.text = "";
    _passErr = null;
    _mobileErr = null;
  }

  @override
  void disposeValues() {
    usrRef = null;
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
