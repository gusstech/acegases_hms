import 'dart:io';

import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/auth/login_controller.dart';
import 'package:acegases_hms/controller/driver_vehicle/driver_vehicle_controller.dart';
import 'package:acegases_hms/dio/api/job_api.dart';
import 'package:acegases_hms/dio/api/trip_api.dart';
import 'package:acegases_hms/dio/api/vehicle_list_api.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
// import model

class JobController extends DisposableProvider {
  JobController();
  final picker = ImagePicker();
  File? imgFile;
  var imageFiles;
  Future<JobDetails> getJobDetails(BuildContext context, TripJob data) async {
    JobApi dioApi = JobApi(context);
    var result;
    // EasyLoading.show(maskType: EasyLoadingMaskType.black);
    await dioApi
        .getJobDetails(
      jobId: data.jobNo!,
    )
        .then((detail) {
      result = detail;
    }, onError: (e) {
      Utils.printInfo('trip LSIT ERROR: $e');
    }).whenComplete(() {
      // EasyLoading.dismiss();
    });

    return result;
  }

  Future getImage(BuildContext ctx, source, String id) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFiles = await pickedFile.readAsBytes();
        imgFile = File(pickedFile.path);
      }

      try {
        // var headers = {
        //   'Content-Type': 'application/json',
        // };
        // var data = {
        //   "id": parent!.workOrders,
        // };
        var data = FormData.fromMap({
          'files': [
            await MultipartFile.fromFile(pickedFile!.path,
                filename: "$id" + DateTime.now().toString())
          ],
        });

        var dio = Dio();
        var response = await dio.request(
          'https://acegasestms.x1.com.my/ReceiveFile.ashx?id=$id',
          options: Options(
            method: 'POST',
          ),
          data: data,
        );
        print("response");
        print(response.data);
        if (response.data["files"].isNotEmpty) {
          showDialog(
            context: ctx,
            // barrierColor: Colors.transparent,
            barrierDismissible: true,
            builder: (context) => CustomAlertDialog(
              type: CustomAlertType.success,
              description: "Succesfully upload image",
              popButtonText: "OK",
            ),
          );
        } else {
          print("error1");
          showDialog(
            context: ctx,
            // barrierColor: Colors.transparent,
            barrierDismissible: true,
            builder: (context) => CustomAlertDialog(
              type: CustomAlertType.error,
              description: "Failed to upload image.",
              popButtonText: "OK",
            ),
          );
        }
      } catch (error) {
        print("error2");
        showDialog(
          context: ctx,
          // barrierColor: Colors.transparent,
          barrierDismissible: true,
          builder: (context) => CustomAlertDialog(
            type: CustomAlertType.error,
            description: "Failed to upload image.",
            popButtonText: "OK",
          ),
        );
        // _alertType = CustomAlertType.error;
      }
    } catch (error) {
      print("error3");
      showDialog(
        context: ctx,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.error,
          description: "Failed to upload image.",
          popButtonText: "OK",
        ),
      );
      // Utils.showAlertDialog(context, 'Error', 'Something went wrong');
    }
  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
}
