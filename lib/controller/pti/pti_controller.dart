import 'dart:convert';
import 'dart:io';

import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/auth/login_controller.dart';
import 'package:acegases_hms/controller/driver_vehicle/driver_vehicle_controller.dart';
import 'package:acegases_hms/dio/api/pti_api.dart';
import 'package:acegases_hms/model/auth_model/auth_model.dart';
import 'package:acegases_hms/model/base_response_model.dart';
import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class PtiController {
  PtiController();
  final picker = ImagePicker();
  File? imgFile;
  var imageFiles;
  TextEditingController ptiRemark = TextEditingController();
  Future<void> loadChecklistData(BuildContext context) async {
    PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);
    String data = await rootBundle.loadString('assets/images/d.json');
    Map<String, dynamic> jsonData = json.decode(data);
    viewModel.checklistData = ChecklistData.fromJson(jsonData).categories;
    print(viewModel.checklistData);
    // Notify listeners after data is loaded
  }

  Future<bool> getPTICheckList(
    BuildContext context,
  ) async {
    PTIApi dioApi = PTIApi(context);
    PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);

    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    await dioApi
        .getPTIChecklist(
            Appcache.selectedVehicle?.id, Appcache.usrRef?.driverId)
        .then((value) async {
      if (value != null) {
        Map<String, dynamic> jsonData = value;
        viewModel.checklistData = ChecklistData.fromJson(jsonData).categories;
        Utils.printInfo("CHECKLIST", type: PrintType.success);
        Utils.printInfo(viewModel.checklistData, type: PrintType.success);
      } else {
        Utils.printInfo('PTI LSIT ERROR: ${value}', type: PrintType.error);
      }
    }, onError: (e) {
      Utils.printInfo('PTI LSIT ERROR: $e', type: PrintType.error);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
    return viewModel.checklistData.isNotEmpty;
  }

  Future<bool> savePTICheckList(
    BuildContext context,
  ) async {
    PTIApi dioApi = PTIApi(context);
    PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);

    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    CommonResponse? result = await dioApi
        .savePTIChecklist(
            Appcache.selectedVehicle?.id,
            Appcache.usrRef?.driverId,
            viewModel.toSaveDataFormat(),
            ptiRemark.text)
        .then((value) async {
      if (value.result == true) {
        Appcache.usrRef!.ptIstatus = true;
        Appcache.setString(
            Appcache.userCredential, jsonEncode(Appcache.usrRef));
      }
      return value;
    }, onError: (e) {
      Utils.printInfo('PTI LSIT ERROR: $e', type: PrintType.error);
    }).whenComplete(() {
      EasyLoading.dismiss();
    });

    return result?.result ?? false;
  }

  Future getImage(
    BuildContext ctx,
    source,
  ) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        imageFiles = await pickedFile.readAsBytes();
        imgFile = File(pickedFile.path);

        print("Image selected successfully: ${pickedFile.path}");
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
                  filename:
                      "${Appcache.usrRef?.driverId}_${Appcache.selectedVehicle?.id}" +
                          DateTime.now().toString())
            ],
          });

          var dio = Dio();

          var response = await dio.request(
            'https://acegasestms.x1.com.my/ReceiveFilePdc.ashx?Driverid=${Appcache.usrRef?.driverId}&PMid=${Appcache.selectedVehicle?.id}',
            options: Options(
              method: 'POST',
            ),
            data: data,
          );
          print(response.headers);
          print(response.realUri);
          if (response.statusCode == 200) {
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
      }
    } on PlatformException catch (e) {
      print("PlatformException: ${e.message}");
    } catch (error) {
      print("error3");
      print(error);
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
}
