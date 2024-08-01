import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/dio/api/vehicle_list_api.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
// import model

class DriverVehicleController extends DisposableProvider {
  List<VehicleModel> _vehicleList = [];

  List<VehicleModel> get vehicleList => _vehicleList;

  VehicleModel? _selectedVehicle;

  VehicleModel? get selectedVehicle => _selectedVehicle;

  DriverVehicleController();

  Future<bool> getVehicleList(BuildContext context) async {
    VehicleListApi dioApi = VehicleListApi(context);

    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    await dioApi.getVehicleList().then((value) async {
      if (value.isNotEmpty) {
        _vehicleList = value;
        print("_vehicleList");
        print(_vehicleList);
        notifyListeners();
      } else {
        Utils.printInfo('VEHICLE LSIT ERROR: ${value}');
      }
    }, onError: (e) {
      Utils.printInfo('VEHICLE LSIT ERROR: $e');
    }).whenComplete(() {
      EasyLoading.dismiss();
    });

    return _vehicleList.isNotEmpty;
  }

  void setVehicle(VehicleModel t) {
    _selectedVehicle = t;
    notifyListeners();
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
