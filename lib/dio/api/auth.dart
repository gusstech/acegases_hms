import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/dio/dio_repo.dart';
import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AuthApi extends DioRepo {
  AuthApi(BuildContext context) {
    dioContext = context;
  }

  Future<LoginModel> login(
      BuildContext context, String mobile, String password) async {
    var params = {
      "mobile": mobile,
      "password": password,
      // {"mobile": "012121212", "password": "1"}
    };

    try {
      Response response = await mDio.post('/login', data: params);

      print(response.data);
      return LoginModel.fromJson(response.data["d"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginModel> logout(BuildContext context) async {
    var params = {
      "driverid": Appcache.usrRef?.driverId ?? "",
      "pmid": Appcache.selectedVehicle?.id ?? "",
      "InOrOut": 1
    };

    try {
      Response response = await mDio.post('/LogInOut', data: params);

      print(response.data);
      return LoginModel.fromJson(response.data["d"]);
    } catch (e) {
      rethrow;
    }
  }

  Future<LoginModel> autoLogin(BuildContext context) async {
    var params = {
      "driverid": Appcache.usrRef?.driverId ?? "",
      "pmid": Appcache.selectedVehicle?.id ?? "",
      "InOrOut": 2
    };

    try {
      Response response = await mDio.post('/LogInOut', data: params);

      print(response.data);
      return LoginModel.fromJson(response.data["d"]);
    } catch (e) {
      rethrow;
    }
  }
}
