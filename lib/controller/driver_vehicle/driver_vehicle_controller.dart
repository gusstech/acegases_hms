import 'dart:convert';

import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/dio/api/vehicle_list_api.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
// import model

class DriverVehicleController extends DisposableProvider {
  DriverVehicleController();

  Future<bool> getVehicleList(BuildContext context) async {
    VehicleListApi dioApi = VehicleListApi(context);

    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    await dioApi.getVehicleList().then((value) async {
      if (value.isNotEmpty) {
        Appcache.vehicleList.clear();
        // if (Appcache.selectedVehicle != null &&
        //     !Appcache.vehicleList.any((e) {
        //       return e.id == Appcache.selectedVehicle!.id;
        //     })) {
        //   Appcache.vehicleList.add(Appcache.selectedVehicle!);
        // }
        Appcache.vehicleList.addAll(value);

        notifyListeners();
      } else {
        Utils.printInfo('VEHICLE LSIT ERROR: ${value}');
      }
    }, onError: (e) {
      Utils.printInfo('VEHICLE LSIT ERROR: $e');
    }).whenComplete(() {
      EasyLoading.dismiss();
    });

    return Appcache.vehicleList.isNotEmpty;
  }

  void setVehicle(VehicleModel t) {
    Appcache.selectedVehicle = t;
    Appcache.setString(Appcache.savedVehicle, jsonEncode(t));
  }

  // void setVehicleStatus(VehicleStatus t) {
  //   vehicleStatus = t;
  //   notifyListeners();
  // }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
}
