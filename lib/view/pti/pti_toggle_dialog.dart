import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/driver_vehicle/driver_vehicle_controller.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../components/pti_toggle_switch.dart';

class PTIToggleDialogView extends StatelessWidget {
  final Category categoryName;
  final List<Subcategory> subCategory;
  const PTIToggleDialogView(
      {super.key, required this.categoryName, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    // DriverVehicleController viewController = DriverVehicleController();
    return Consumer<PtiModel>(
      builder: (context, viewModel, child) {
        return Dialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 16.0, bottom: 14, left: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(categoryName.name),
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(
                              Icons.cancel_outlined,
                              size: 30,
                            ))
                      ],
                    ),
                  ),
                  for (Subcategory data in subCategory)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6.0, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 3,
                              child: Text(data.name)),
                          SizedBox(
                            width: 12,
                          ),
                          CustomPTISlider(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 2.2,
                              subCat: data,
                              mainCat: categoryName)
                        ],
                      ),
                    ),
                  SizedBox(
                    height: 12,
                  )
                ]),
          ),
        );
      },
    );
  }

  Future showError(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (context) {
          return AlertDialog(
            icon: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.amber.shade600),
                child: Icon(
                  CupertinoIcons.exclamationmark,
                  color: Colors.white,
                  size: 36,
                )),
            title: Text(
              "Please choose a vehicle to continue",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                    width: 80,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Theme.of(context).primaryColor),
                    child: Text(
                      "OKAY",
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          );
        });
  }

  Future<dynamic> showList(
      BuildContext context,
      DriverVehicleController viewModel,
      DriverVehicleController viewController) {
    return showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Choose your vehicle",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(
                height: 6,
              ),
              for (VehicleModel data in Appcache.vehicleList)
                InkWell(
                  onTap: () {
                    if (Appcache.selectedVehicle?.no != data.no) {
                      // viewController.setStatus(context, VehicleStatus.Poor);
                    }
                    // viewController.setter(context, data);
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.sizeOf(context).width * 0.5,
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                // color: Utils.getColor(context)
                                //     .cardTextIndicator
                                ))),
                    child: Text(
                      "${data.no}",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              const SizedBox(
                height: 6,
              ),
            ],
          ),
        );
      },
    );
  }
}
