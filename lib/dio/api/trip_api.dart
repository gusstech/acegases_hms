import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/dio/dio_repo.dart';
import 'package:acegases_hms/model/base_response_model.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class TripApi extends DioRepo {
  TripApi(BuildContext context) {
    dioContext = context;
  }

  Future<List<TripDataDTO>> getTripList(
      {required String pmId, required String driverId}) async {
    var params = {"PMId": pmId, "driverId": driverId};

    try {
      Response response = await mDio.post('/GetTrips', data: params);

      final tripList = (response.data['d'] as List).map((data) {
        return TripDataDTO.fromJson(data);
      });

      return tripList.toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<List<TripJob>> getTripJobList(
      {required String tripNo, required String driverId}) async {
    var params = {"TripNo": tripNo, "driverId": driverId};
    try {
      Response response = await mDio.post('/GetTripJobs', data: params);

      final tripJobList = (response.data['d'] as List).map((data) {
        return TripJob.fromJson(data);
      });

      return tripJobList.toList();
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> startDriving(
      {required String tripNo,
      required String driverId,
      required String pmId}) async {
    var params = {"TripNo": tripNo, "DriverId": driverId, "PMId": pmId};
    try {
      Response response = await mDio.post('/StartDriving', data: params);

      final responseModel = CommonResponse.fromJson(response.data['d']);

      return responseModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> stopDriving(
      {required String tripNo,
      required String driverId,
      required String pmId}) async {
    var params = {"TripNo": tripNo, "DriverId": driverId, "PMId": pmId};
    try {
      Response response = await mDio.post('/StopDriving', data: params);

      final responseModel = CommonResponse.fromJson(response.data['d']);

      return responseModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> tripStart({
    required String tripNo,
    required String driverId,
    required String jobNo,
    required String tripLoad,
  }) async {
    var params = {
      "TripNo": tripNo,
      "DriverId": driverId,
      "TripLoad": tripLoad,
      "JobNo": jobNo
    };

    try {
      Response response = await mDio.post('/TripStart', data: params);

      final responseModel = CommonResponse.fromJson(response.data['d']);

      return responseModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> tripStop({
    required String tripNo,
    required String driverId,
    required String jobNo,
    required String tripLoad,
  }) async {
    var params = {
      "TripNo": tripNo,
      "DriverId": driverId,
      "TripLoad": tripLoad,
      "JobNo": jobNo
    };

    try {
      Response response = await mDio.post('/TripFinish', data: params);

      final responseModel = CommonResponse.fromJson(response.data['d']);

      return responseModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> updateTripLoad({
    required String tripNo,
    required String tripLoad,
  }) async {
    var params = {
      "TripNo": tripNo,
      "TripLoad": tripLoad,
    };

    try {
      Response response = await mDio.post('/UpdateTripLoad', data: params);

      final responseModel = CommonResponse.fromJson(response.data['d']);

      return responseModel;
    } catch (e) {
      rethrow;
    }
  }
}
