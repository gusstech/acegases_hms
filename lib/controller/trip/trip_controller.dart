import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/auth/login_controller.dart';
import 'package:acegases_hms/controller/driver_vehicle/driver_vehicle_controller.dart';
import 'package:acegases_hms/dio/api/trip_api.dart';
import 'package:acegases_hms/dio/api/vehicle_list_api.dart';
import 'package:acegases_hms/model/base_response_model.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
// import model

class TripController extends DisposableProvider {
  TripController();
  TextEditingController tripLoad = TextEditingController();
  Future getTripList(BuildContext context) async {
    TripApi dioApi = TripApi(context);

    // EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var result = await dioApi
        .getTripList(
            pmId: Appcache.selectedVehicle!.id!,
            driverId: Appcache.usrRef!.driverId!)
        .then((value) async {
      if (value.isNotEmpty) {
        Appcache.tripList.clear();
        return value.toList();
      } else {
        Utils.printInfo('VEHICLE LSIT ERROR: ${value}');
        return [];
      }
    }, onError: (e) {
      Utils.printInfo('VEHICLE LSIT ERROR: $e');
      return [];
    }).whenComplete(() {
      // EasyLoading.dismiss();
    });

    return result;
  }

  // void setVehicleStatus(VehicleStatus t) {
  //   vehicleStatus = t;
  //   notifyListeners();
  // }
  Future<bool> getJobList(BuildContext context, TripDataDTO data) async {
    TripApi dioApi = TripApi(context);

    // EasyLoading.show(maskType: EasyLoadingMaskType.black);
    return await dioApi
        .getTripJobList(
            tripNo: data.tripNo!, driverId: Appcache.usrRef!.driverId!)
        .then((detail) async {
      if (detail.isNotEmpty) {
        List<String>? attendance = [];
        if (detail.isNotEmpty) {
          detail.first.attendant1 != null && detail.first.attendant1 != "0"
              ? attendance.add(detail.first.attendant1!)
              : null;
          detail.first.attendant2 != null && detail.first.attendant2 != "0"
              ? attendance.add(detail.first.attendant2!)
              : null;
          detail.first.attendant3 != null && detail.first.attendant3 != "0"
              ? attendance.add(detail.first.attendant3!)
              : null;
        }

        // de.first.deliveryDate = "211123";
        Appcache.tripList.add(TripDataDTO(
            showAllDate: detail.any(
              (element) => element.deliveryDate != detail.first.deliveryDate,
            )
                ? false
                : true,
            customer: data.customer,
            tripNo: data.tripNo,
            sNo: data.sNo,
            tripStatus: data.tripStatus,
            jobList: detail,
            attendance: attendance.toList()));

        notifyListeners();
        return true;
      } else {
        Appcache.tripList.add(TripDataDTO(
            showAllDate: false,
            customer: data.customer,
            tripNo: data.tripNo,
            sNo: data.sNo,
            tripStatus: data.tripStatus,
            jobList: [],
            attendance: []));

        Utils.printInfo('trip LSIT ERROR: ${"adasdasd"}');
        return false;
      }
    }, onError: (e) {
      Utils.printInfo('trip LSIT ERROR: $e');
      return true;
    }).whenComplete(() {
      // EasyLoading.dismiss();
    });
  }

  Future startDriving(BuildContext context, TripDataDTO? data) async {
    TripApi dioApi = TripApi(context);
    // Appcache.tripList.clear();
    // if (Appcache.tripList.isEmpty ||
    //     !Appcache.tripList
    //         .any((e) => e.drivingStatus == "0" || e.drivingStatus == "2")) {
    //   return showDialog(
    //     context: context,
    //     // barrierColor: Colors.transparent,
    //     barrierDismissible: true,
    //     builder: (context) => CustomAlertDialog(
    //       type: CustomAlertType.error,
    //       description: Appcache.tripList.isEmpty
    //           ? "No trip to start driving"
    //           : "All trip is in driving mode",
    //       popButtonText: "OKAY",
    //     ),
    //   );
    // }
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var result = await dioApi
        .startDriving(
            tripNo: data?.tripNo ?? "0",
            driverId: Appcache.usrRef!.driverId!,
            pmId: Appcache.selectedVehicle!.id!)
        .then((detail) async {
      return detail;
    }, onError: (e) {
      Utils.printInfo('trip LSIT ERROR: $e');
      return CommonResponse(result: false, error: "Something went wrong!!");
    }).whenComplete(() {
      EasyLoading.dismiss();
    });

    if (result.result != null && result.result!) {
      return showDialog(
        context: context,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.success,
          description: result.error ?? "Succesfully update driving status",
          popButtonText: "OKAY",
        ),
      );
    } else {
      return showDialog(
        context: context,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.error,
          description: result.error ?? "Something went wrong!!",
          popButtonText: "OKAY",
        ),
      );
    }
  }

  Future stopDriving(BuildContext context, TripDataDTO? data) async {
    TripApi dioApi = TripApi(context);
    EasyLoading.show(maskType: EasyLoadingMaskType.black);
    var result = await dioApi
        .stopDriving(
            tripNo: data?.tripNo ?? "0",
            driverId: Appcache.usrRef!.driverId!,
            pmId: Appcache.selectedVehicle!.id!)
        .then((detail) async {
      return detail;
    }, onError: (e) {
      Utils.printInfo('trip LSIT ERROR: $e');
      return CommonResponse(result: false, error: "Something went wrong!!");
    }).whenComplete(() {
      EasyLoading.dismiss();
    });

    if (result.result != null && result.result!) {
      return showDialog(
        context: context,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.success,
          description: result.error ?? "Succesfully update driving status",
          popButtonText: "OKAY",
        ),
      );
    } else {
      return showDialog(
        context: context,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.error,
          description: result.error ?? "Something went wrong!!",
          popButtonText: "OKAY",
        ),
      );
    }
  }

  Future tripStart(BuildContext context, TripDataDTO data) async {
    TripApi dioApi = TripApi(context);

    List<CommonResponse> resultList = [];
    if (data.jobList!.isNotEmpty &&
        data.jobList!.any((v) => v.isChecked == true)) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      for (var v in data.jobList!) {
        if (v.isChecked) {
          var result = await dioApi
              .tripStart(
                  tripNo: data.tripNo!,
                  driverId: Appcache.usrRef!.driverId!,
                  tripLoad: v.tripLoad!,
                  jobNo: v.jobNo!)
              .then((detail) async {
            if (detail.result == true) {
              v.jobStatus = "IN-PROGRESS";
            }

            return detail;
          }, onError: (e) {
            Utils.printInfo('trip LSIT ERROR: $e');
            return CommonResponse(
                result: false, error: "Something went wrong!!");
          }).whenComplete(() {});
          resultList.add(result);
        }
      }
      EasyLoading.dismiss();
      if (resultList.any((v) => v.result == false)) {
        return showDialog(
          context: context,
          // barrierColor: Colors.transparent,
          barrierDismissible: true,
          builder: (context) => CustomAlertDialog(
            type: CustomAlertType.error,
            description:
                resultList.firstOrNull?.error ?? "Something went wrong!!",
            popButtonText: "OKAY",
          ),
        );
      } else {
        return showDialog(
          context: context,
          // barrierColor: Colors.transparent,
          barrierDismissible: true,
          builder: (context) => CustomAlertDialog(
              type: CustomAlertType.success,
              description: resultList.firstOrNull?.error ??
                  "Succesfully update trip status",
              popButtonText: "OK"),
        );
      }
    } else {
      return showDialog(
        context: context,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.alert,
          description: "Please select a job to proceed",
          popButtonText: "OKAY",
        ),
      );
    }
  }

  Future tripFinish(BuildContext context, TripDataDTO data) async {
    TripApi dioApi = TripApi(context);

    List<CommonResponse> resultList = [];
    if (data.jobList!.isNotEmpty &&
        data.jobList!.any((v) => v.isChecked == true)) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      for (var v in data.jobList!) {
        if (v.isChecked) {
          var result = await dioApi
              .tripStop(
                  tripNo: data.tripNo!,
                  driverId: Appcache.usrRef!.driverId!,
                  tripLoad: v.tripLoad!,
                  jobNo: v.jobNo!)
              .then((detail) async {
            return detail;
          }, onError: (e) {
            Utils.printInfo('trip LSIT ERROR: $e');
            return CommonResponse(
                result: false, error: "Something went wrong!!");
          }).whenComplete(() {});
          resultList.add(result);
        }
      }
      EasyLoading.dismiss();
      if (resultList.any((v) => v.result == false)) {
        return showDialog(
          context: context,
          // barrierColor: Colors.transparent,
          barrierDismissible: true,
          builder: (context) => CustomAlertDialog(
            type: CustomAlertType.error,
            description:
                resultList.firstOrNull?.error ?? "Something went wrong!!",
            popButtonText: "OKAY",
          ),
        );
      } else {
        return showDialog(
          context: context,
          // barrierColor: Colors.transparent,
          barrierDismissible: true,
          builder: (context) => CustomAlertDialog(
            type: CustomAlertType.success,
            description: resultList.firstOrNull?.error ??
                "Succesfully update trip status",
            popButtonText: "OKAY",
          ),
        );
      }
    } else {
      return showDialog(
        context: context,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: CustomAlertType.alert,
          description: "Please select a job to proceed",
          popButtonText: "OKAY",
        ),
      );
    }
  }

  Future updateTripLoad(BuildContext context, TripDataDTO data) async {
    TripApi dioApi = TripApi(context);
    await dioApi
        .updateTripLoad(
      tripNo: data.tripNo!,
      tripLoad: tripLoad.text,
    )
        .then((detail) async {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
      data.jobList?.first.tripLoad = tripLoad.text;
      notifyListeners();
      return showDialog(
        context: context,
        // barrierColor: Colors.transparent,
        barrierDismissible: true,
        builder: (context) => CustomAlertDialog(
          type: detail.result == true
              ? CustomAlertType.success
              : CustomAlertType.error,
          description: detail.error ?? "Something went wrong!!",
          popButtonText: "OKAY",
        ),
      );
      // return detail;
    }, onError: (e) {
      Utils.printInfo('trip LSIT ERROR: $e');
      return CommonResponse(result: false, error: "Something went wrong!!");
    }).whenComplete(() {
      EasyLoading.dismiss();
    });
  }

  @override
  void disposeValues() {
    // TODO: implement disposeValues
  }
}
