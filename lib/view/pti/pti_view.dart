import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/components/pti_toggle_switch.dart';
import 'package:acegases_hms/controller/driver_vehicle/driver_vehicle_controller.dart';
import 'package:acegases_hms/controller/pti/pti_controller.dart';
import 'package:acegases_hms/model/driver_vehicle/driver_vehicle_model.dart';
import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:acegases_hms/view/pti/pti_choose_vehicle.dart';
import 'package:acegases_hms/view/pti/pti_toggle_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class PtiView extends StatefulWidget {
  final String destination;
  const PtiView({super.key, required this.destination});

  @override
  State<PtiView> createState() => _PtiViewState();
}

class _PtiViewState extends State<PtiView> {
  bool init = true;
  @override
  void initState() {
    super.initState();
  }

  showSelection(PtiController viewController, DriverVehicleController driver,
      BuildContext context) async {
    final result = await showDialog(
        barrierDismissible: driver.selectedVehicle != null,
        context: context,
        builder: (_) => const PTISelectVehicleView());

    if (result != null && result) {
      viewController.loadChecklistData(context);
    }
  }

  showToggle(Category catName, List<Subcategory> subCat, context) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => PTIToggleDialogView(
              categoryName: catName,
              subCategory: subCat,
            ));
  }

  Future<dynamic> logutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Builder(builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: CustomAlertDialog(
            type: CustomAlertType.alert,
            description: "Are you sure you want to logout?",
            isLogout: true,
            cancelBtn: true,
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    PtiController viewController = PtiController();

    return Consumer2<PtiModel, DriverVehicleController>(
      builder: (context, viewModel, vehicleModel, child) {
        vehicleModel.selectedVehicle != null
            ? null
            : WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted && init) {
                  showSelection(viewController, vehicleModel, context);

                  setState(() {
                    init = false;
                  });
                }
              });

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: false,
            title: Row(children: [
              const Text(
                "PreTrip Inspection",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
              Spacer(
                flex: 1,
              ),
              InkWell(
                onTap: () async {
                  final result = await logutDialog(context);
                  if (result != null && result) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.loginScreenRoute, (route) => false);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      // color: Colors.red,
                      // borderRadius: BorderRadius.circular(6),
                      // border: Border.all(color: Colors.white, width: 2),
                      ),
                  child: Row(
                    children: [
                      // Text(
                      //   "Logout",
                      //   style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 16,
                      //       fontWeight: FontWeight.w800),
                      // ),
                      // SizedBox(
                      //   width: 8,
                      // ),
                      Icon(Icons.exit_to_app)
                    ],
                  ),
                ),
              ),
            ]),
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height,
              // margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Utils.getColor(context).color3,
                border: Border.symmetric(vertical: BorderSide()),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _ptiCheckList(
                      context, vehicleModel, viewController, viewModel),
                  _submitBtn(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _ptiCheckList(
      BuildContext context,
      DriverVehicleController vehicleModel,
      PtiController viewController,
      PtiModel viewModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              "Not driving? ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            InkWell(
              onTap: () => showSelection(viewController, vehicleModel, context),
              child: Container(
                margin: EdgeInsets.only(left: 6),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black54,
                          offset: Offset(3, 2),
                          spreadRadius: 1,
                          blurRadius: 5)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                        color: Theme.of(context).primaryColor, width: 2)),
                child: Text(
                  vehicleModel.selectedVehicle?.no ?? 'Please Select Vehicle',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            vehicleModel.selectedVehicle != null
                ? InkWell(
                    onTap: () =>
                        showSelection(viewController, vehicleModel, context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      // color: Colors.deepPurple.shade600.withOpacity(0.6),
                      decoration: BoxDecoration(
                          color: Colors.deepPurple.shade600.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        children: [
                          Icon(Icons.change_circle_outlined,
                              size: 24, color: Colors.white),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Change PM",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : SizedBox()
          ],
        ),
        SizedBox(height: 12),
        // viewModel.checklistData.isNotEmpty
        // ?
        SizedBox(
          height: MediaQuery.sizeOf(context).height -
              kToolbarHeight -
              32 -
              MediaQuery.viewPaddingOf(context).top -
              20 -
              100,
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (Category data in viewModel.checklistData.sublist(0))
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: Colors.deepPurple.shade50,
                        borderRadius: BorderRadius.circular(24)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 16.0, bottom: 8, left: 16, right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data.name,
                                  style: TextStyle(shadows: [
                                    Shadow(
                                      blurRadius: 2,
                                    ),
                                  ], fontSize: 16, fontWeight: FontWeight.w600),
                                ),
                                // InkWell(
                                //     onTap: () => Navigator.pop(context),
                                //     child: Icon(
                                //       Icons.cancel_outlined,
                                //       size: 30,
                                //     ))
                              ],
                            ),
                          ),
                          for (Subcategory subdata in data.subcategories)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 6.0, horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      child: Text(subdata.name)),
                                  SizedBox(
                                    width: 12,
                                  ),
                                  CustomPTISlider(
                                      height: 30,
                                      width: MediaQuery.of(context).size.width /
                                          2.2,
                                      subCat: subdata,
                                      mainCat: data)
                                ],
                              ),
                            ),
                          SizedBox(
                            height: 12,
                          )
                        ]),
                  ),
                // PTIToggleDialogView(
                //     categoryName: data,
                //     subCategory: data.subcategories,
                //   )
                // InkWell(
                //   onTap: () => showToggle(data, data.subcategories, context),
                //   child: Container(
                //     margin: EdgeInsets.only(bottom: 12),
                //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       boxShadow: [
                //         BoxShadow(
                //             color: Colors.black54,
                //             offset: Offset(2, 2),
                //             spreadRadius: 1,
                //             blurRadius: 3)
                //       ],
                //       border: Border.all(
                //         width: 4,
                //         color: PTISliderStatus
                //             .values[viewModel.cardType(data.subcategories)]
                //             .ptiCardIconColor,
                //       ),
                //       color: PTISliderStatus
                //           .values[viewModel.cardType(data.subcategories)]
                //           .ptiCardColor,
                //     ),
                //     width: MediaQuery.sizeOf(context).width,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         Text(
                //           data.name,
                //           style: TextStyle(
                //               fontSize: 16,
                //               fontWeight: FontWeight.w800,
                //               color: Colors.grey.shade900),
                //         ),
                //         Expanded(
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Text.rich(
                //                   textAlign: TextAlign.center,
                //                   TextSpan(
                //                     children: [
                //                       TextSpan(
                //                         text: PTISliderStatus
                //                             .values[viewModel
                //                                 .cardType(data.subcategories)]
                //                             .ptiCardActionText,
                //                         style: TextStyle(
                //                             fontSize: 12,
                //                             fontWeight: FontWeight.bold,
                //                             color: Colors.black54),
                //                       ),
                //                       viewModel.cardType(data.subcategories) ==
                //                               0
                //                           ? TextSpan(
                //                               text: "*",
                //                               style: TextStyle(
                //                                   fontSize: 16,
                //                                   fontWeight: FontWeight.bold,
                //                                   color: Colors.red.shade800),
                //                             )
                //                           : TextSpan(),
                //                     ],
                //                   )),
                //               SizedBox(
                //                 width: 6,
                //               ),
                //               Icon(
                //                 PTISliderStatus
                //                     .values[
                //                         viewModel.cardType(data.subcategories)]
                //                     .ptiCardIcon,
                //                 size: 20,
                //                 color: PTISliderStatus
                //                     .values[
                //                         viewModel.cardType(data.subcategories)]
                //                     .ptiCardIconColor,
                //               ),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
        // : Container(
        //     padding: EdgeInsets.symmetric(
        //         vertical: MediaQuery.sizeOf(context).height / 3),
        //     child: Text("Please select a vehicle to continue"))
      ],
    );
  }

  Consumer<PtiModel> _submitBtn() {
    return Consumer<PtiModel>(
        builder: (context, value, child) => value.checklistData.isNotEmpty
            ? InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, AppRoutes.homeScreenRoute);
                  if (!value.checklistData.any((e) => e.subcategories
                      .any((g) => g.status == PTISliderStatus.none))) {
                    value.ptiCheckStatus = true;
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.homeScreenRoute);
                  }
                  // if (value.checklistData.any((element) =>
                  //     (element.subcategories.any((element) =>
                  //         element.status ==
                  //         PTISliderStatus.none)))) {
                  //   // value.ptiCheckStatus = true;
                  //   print("object");
                  //   return;
                  // } else {

                  // }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  width: MediaQuery.sizeOf(context).width - 38,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            offset: Offset(2, 2),
                            spreadRadius: 1,
                            blurRadius: 3)
                      ],
                      color: value.checklistData.any((e) => e.subcategories
                              .any((g) => g.status == PTISliderStatus.none))
                          ? Colors.grey.shade600
                          : Colors.green,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: value.checklistData.any((e) => e.subcategories
                                  .any((g) => g.status == PTISliderStatus.none))
                              ? Colors.grey.shade600
                              : Colors.green,
                          width: 2)),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800),
                  ),
                ),
              )
            : SizedBox.shrink());
  }
}
