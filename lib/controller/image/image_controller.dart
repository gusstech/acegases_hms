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

class ImageController extends DisposableProvider {
  ImageController();
  final picker = ImagePicker();
  File? imgFile;
  var imageFiles;
  List<File> _listImageFiles = [];

  List<File> get getImageList => _listImageFiles;

  Future<void> pickImageFromGallery(ctx) async {
    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      _listImageFiles
          .addAll(pickedFiles.map((pickedFile) => File(pickedFile.path)));

      notifyListeners();
      Navigator.pop(ctx);
    }
  }

  // Function to pick images from the camera
  Future<void> pickImageFromCamera(ctx) async {
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      _listImageFiles.add(File(image.path));
      notifyListeners();
      Navigator.pop(ctx);
    }
  }

  // Function to remove an image from the list
  void removeImage(int index) {
    _listImageFiles.removeAt(index);
    notifyListeners();
  }

  // Function to view image in full screen
  // void _viewImage(BuildContext context, File image) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => FullScreenImage(image: image),
  //     ),
  //   );
  // }
  Future<bool> updateImage(BuildContext ctx, String? id, bool? fromPDC) async {
    try {
      List<bool> allResponse = [];
      for (var img in _listImageFiles) {
        print(img.path);
        //   var data = FormData.fromMap({
        //   'files': [
        //     await MultipartFile.fromFile(pickedFile!.path,
        //         filename:
        //             "${Appcache.usrRef?.driverId}_${Appcache.selectedVehicle?.id}" +
        //                 DateTime.now().toString())
        //   ],
        // });

        // var dio = Dio();

        // var response = await dio.request(
        //   'https://acegasestms.x1.com.my/ReceiveFilePdc.ashx?Driverid=${Appcache.usrRef?.driverId}&PMid=${Appcache.selectedVehicle?.id}',
        //   options: Options(
        //     method: 'POST',
        //   ),
        //   data: data,
        // );

        var data = FormData.fromMap({
          'files': [
            await MultipartFile.fromFile(
              img.path,
              filename: fromPDC == true
                  ? "${Appcache.usrRef?.driverId}_${Appcache.selectedVehicle?.id}" +
                      DateTime.now().toString()
                  : "$id" + DateTime.now().toString(),
            )
          ],
        });

        var dio = Dio();
        var response = await dio.request(
          fromPDC == true
              ? 'https://acegasestms.x1.com.my/ReceiveFilePdc.ashx?Driverid=${Appcache.usrRef?.driverId}&PMid=${Appcache.selectedVehicle?.id}'
              : 'https://acegasestms.x1.com.my/ReceiveFile.ashx?id=$id',
          options: Options(
            method: 'POST',
          ),
          data: data,
        );
        print(response);
        print("response");
        print("response");
        print(response.data);
        if (response.data["files"].isNotEmpty) {
          allResponse.add(true);
        } else {
          allResponse.add(false);
        }
      }

      if (allResponse.any((e) => e == false)) {
        showDialog(
          context: ctx,
          // barrierColor: Colors.transparent,
          barrierDismissible: true,
          builder: (context) => CustomAlertDialog(
            type: CustomAlertType.error,
            description: "Failed to one of the image. Please try again",
            popButtonText: "OKAY",
          ),
        );
        return false;
      } else {
        fromPDC == true
            ? null
            : showDialog(
                context: ctx,
                // barrierColor: Colors.transparent,
                barrierDismissible: true,
                builder: (context) => CustomAlertDialog(
                  type: CustomAlertType.success,
                  description: "Succesfully upload image (s)",
                  popButtonText: "OKAY",
                ),
              );
        _listImageFiles.clear();
        notifyListeners();
        return true;
      }
    } catch (error) {
      showDialog(
        context: ctx,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.error,
          description: "Failed to upload image.\nPlease contact admin.",
          popButtonText: "OKAY",
        ),
      );
      return false;
      // _alertType = CustomAlertType.error;
    }
  }

  Future getImage(BuildContext ctx, source, String id) async {
    try {
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {}
    } catch (error) {
      rethrow;
    }
  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
}
