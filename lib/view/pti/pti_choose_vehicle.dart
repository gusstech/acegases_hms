import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/qr_scanner.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/driver_vehicle/driver_vehicle_controller.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

class PTISelectVehicleView extends StatefulWidget {
  const PTISelectVehicleView({super.key});

  @override
  State<PTISelectVehicleView> createState() => _PTISelectVehicleViewState();
}

class _PTISelectVehicleViewState extends State<PTISelectVehicleView> {
  VehicleModel? temp;
  bool init = true;
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    DriverVehicleController viewModel =
        Provider.of<DriverVehicleController>(context, listen: false);
    print(Appcache.selectedVehicle?.id);
    print(Appcache.selectedVehicle?.id);
    print(Appcache.selectedVehicle?.id);
    print(Appcache.selectedVehicle?.id);
    viewModel.getVehicleList(context).then((v) {
      Appcache.vehicleList.isNotEmpty &&
              Appcache.vehicleList
                  .any((element) => element.id == Appcache.selectedVehicle?.id)
          ? setState(() {
              temp = Appcache.vehicleList.firstWhere(
                  (element) => element.id == Appcache.selectedVehicle?.id);
            })
          : null;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DriverVehicleController>(
      builder: (context, viewModel, child) {
        return Dialog(
          insetPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding:
                    EdgeInsets.only(top: 16.0, bottom: 14, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("PM Mapping Confirmation"),
                    // temp != null
                    //     ? InkWell(
                    //         onTap: () => Navigator.pop(context, false),
                    //         child: Icon(
                    //           Icons.cancel_outlined,
                    //           size: 30,
                    //         ))
                    //     : SizedBox.shrink()
                  ],
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton2<VehicleModel>(
                  items: Appcache.vehicleList
                      .map((e) => DropdownMenuItem<VehicleModel>(
                            value: e,
                            child: Text(
                              e.no ?? "",
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w700),
                            ),
                          ))
                      .toList(),

                  value: temp, //?? viewModel.selectedVehicle ?? VehicleModel(),
                  onChanged: (value) {
                    setState(() {
                      temp = value;
                    });
                  },
                  dropdownSearchData: DropdownSearchData(
                      searchController: controller,
                      searchMatchFn: (item, searchValue) => item.value!.no!
                          .toString()
                          .toLowerCase()
                          .contains(searchValue.toLowerCase()),
                      searchInnerWidgetHeight: 6,
                      searchInnerWidget: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 125, 124, 124),
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        margin:
                            const EdgeInsets.only(left: 12, top: 12, right: 12),
                        // padding:
                        //     EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                        child: TextFormField(
                          controller: controller,
                          style: const TextStyle(color: Colors.white),
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 18,
                              ),
                              contentPadding: EdgeInsets.only(top: 12),
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Search your vehicle"),
                        ),
                      )),
                  customButton: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.red.shade500,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6),
                            child: Text(
                              temp?.no ?? "Please choose your vehicle",
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                        Transform.rotate(
                          angle: math.pi / 2,
                          child: const Icon(
                            Icons.chevron_right,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Container(
                          height: 30,
                          child: const VerticalDivider(
                            color: Colors.white30,
                            width: 2,
                            thickness: 2,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    BarcodeScannerWithOverlay(),
                              ),
                            );

                            if (result != null) {
                              Appcache.vehicleList.isNotEmpty &&
                                      Appcache.vehicleList.any((element) =>
                                          element.id ==
                                          result.toString().split(";").last)
                                  ? setState(() {
                                      VehicleModel scannedDATA = Appcache
                                          .vehicleList
                                          .firstWhere((element) =>
                                              element.id ==
                                              result
                                                  .toString()
                                                  .split(";")
                                                  .last);
                                      temp = scannedDATA;
                                      Appcache.selectedVehicle = scannedDATA;
                                    })
                                  : null;
                            }
                          },
                          child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 6),
                              child: const Icon(
                                CupertinoIcons.qrcode_viewfinder,
                                color: Colors.white,
                                size: 36,
                              )),
                        ),
                      ],
                    ),
                  ),

                  hint: const Text(
                    "Please choose your vehicle",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),

                  buttonStyleData: ButtonStyleData(
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 8),
                      width: 260,
                      elevation: 10,
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(6))),
                  dropdownStyleData: DropdownStyleData(
                    offset: const Offset(16, 0),
                    width: MediaQuery.sizeOf(context).width - 82 - 32,
                    maxHeight: 300,
                    elevation: 10,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 85, 82, 82),
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                  ),

                  iconStyleData:
                      const IconStyleData(iconEnabledColor: Colors.white),
                  // menuItemStyleData: const MenuItemStyleData(
                  //   height: 40,
                  // ),
                  // overlayColor:
                  //     MaterialStatePropertyAll(Colors.blue)),

                  style: const TextStyle(fontSize: 12, color: Colors.white),

                  onMenuStateChange: (isOpen) {
                    if (!isOpen) {
                      // textEditingController.clear();
                    }
                  },
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(18.0),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    Opacity(
                      opacity: Appcache.selectedVehicle != null ? 1 : 0.3,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              surfaceTintColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              backgroundColor: Colors.black,
                              // foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  // side: BorderSide(
                                  //     width: 3, color: Colors.red.shade600),
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () {
                            // Navigator.pop(context);
                            Appcache.selectedVehicle != null
                                ? Navigator.pop(context)
                                : null;
                          },
                          child: Text(
                            'CANCEL',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                          )),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            surfaceTintColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.red.shade600,
                            // foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                // side: BorderSide(
                                //   width: 3,
                                //   color: Colors.black,
                                // ),
                                borderRadius: BorderRadius.circular(8))),
                        onPressed: () {
                          if (temp != null) {
                            viewModel.setVehicle(temp!);
                            Navigator.pop(context, true);
                          } else {
                            showError(context);
                          }
                        },
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                              color: Colors.white),
                        ))
                  ]))
            ],
          ),
        );
      },
    );
  }

  Future showError(BuildContext ctx) {
    return showDialog(
        context: ctx,
        builder: (context) {
          return CustomAlertDialog(
            type: CustomAlertType.alert,
            description: "Please choose a vehicle to continue",
            popButtonText: "OKAY",
            isLogout: false,
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
