import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/dio/dio_repo.dart';
import 'package:acegases_hms/model/base_response_model.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class JobApi extends DioRepo {
  JobApi(BuildContext context) {
    dioContext = context;
  }

  Future<JobDetails> getJobDetails({required String jobId}) async {
    var params = {
      "JobId": jobId,
    };
    try {
      Response response = await mDio.post('/GetJobDetails', data: params);

      final details = JobDetails.fromJson(response.data['d'].first);

      return details;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> updateJobDetails({
    required String jobNo,
    required String dropFM,
    required String dropWB,
    required String jobRemark,
    required String jobActivity,
  }) async {
    var params = {
      "JobNo": jobNo,
      "DropFM": dropFM,
      "DropWB": dropWB,
      "JobRemark": jobRemark,
      "JobActivity": jobActivity
    };
    try {
      Response response = await mDio.post('/UpdateJobDetails', data: params);

      final responseModel = CommonResponse.fromJson(response.data['d']);

      return responseModel;
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonResponse> updateJobDropQty({
    required String jobNo,
    required String dropFM,
    required String dropWB,
    required String jobRemark,
  }) async {
    var params = {
      "JobNo": jobNo,
      "DropFM": dropFM,
      "DropWB": dropWB,
      "JobRemark": jobRemark,
    };
    try {
      Response response = await mDio.post('/UpdateJobDropQty', data: params);

      final responseModel = CommonResponse.fromJson(response.data['d']);

      return responseModel;
    } catch (e) {
      rethrow;
    }
  }

  
}
