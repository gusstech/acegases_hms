import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/dio/dio_repo.dart';
import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:acegases_hms/model/base_response_model.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class PTIApi extends DioRepo {
  PTIApi(BuildContext context) {
    dioContext = context;
  }

  Future<dynamic> getPTIChecklist(var pmID, var driverID) async {
    var params = {"PMID": pmID, "DriverID": driverID};

    try {
      Response response = await mDio.post('/GetPTICheckItems', data: params);

      // final data = (response.data['d'] as List).map((data) {
      //   return ChecklistData.fromJson(data);
      // });
      // Utils.printInfo(data.toString(), type: PrintType.warning);
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> savePTIChecklist(
      var pmID, var driverID, String data, String remark) async {
    var params = {
      "PMID": pmID,
      "DriverID": driverID,
      "data": data,
      "remark": remark
    };

    try {
      Response response = await mDio.post('/Save_PTI_Data', data: params);

      // final data = (response.data['d'] as List).map((data) {
      //   return ChecklistData.fromJson(data);
      // });
      // Utils.printInfo(data.toString(), type: PrintType.warning);

      return CommonResponse.fromJson(response.data['d']);
    } catch (e) {
      rethrow;
    }
  }
}
