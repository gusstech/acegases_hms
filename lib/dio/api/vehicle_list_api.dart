import 'package:acegases_hms/dio/dio_repo.dart';
import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class VehicleListApi extends DioRepo {
  VehicleListApi(BuildContext context) {
    dioContext = context;
  }

  Future<List<VehicleModel>> getVehicleList() async {
    var params = {"status": ""};

    try {
      Response response = await mDio.post('/GetVehiclesLoad', data: params);

      final vehicleList = (response.data['d'] as List).map((data) {
        return VehicleModel.fromJson(data);
      });

      return vehicleList.toList();
    } catch (e) {
      rethrow;
    }
  }
}
