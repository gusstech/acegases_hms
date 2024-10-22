import 'package:acegases_hms/Utils/action_completed_dialog.dart';
import 'package:acegases_hms/Utils/app_font.dart';
import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/Utils/custom_animation_fadeIn.dart';
import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/controller/image/image_controller.dart';
import 'package:acegases_hms/controller/trip/trip_controller.dart';
import 'package:acegases_hms/dio/api/job_api.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:acegases_hms/model/base_response_model.dart';
import 'package:acegases_hms/model/enum/jobstatus_enum.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class UpdateJobDetailViewDartView extends StatefulWidget {
  final TripJob data;
  const UpdateJobDetailViewDartView({super.key, required this.data});

  @override
  State<UpdateJobDetailViewDartView> createState() =>
      _UpdateJobDetailViewDartViewState();
}

class _UpdateJobDetailViewDartViewState
    extends State<UpdateJobDetailViewDartView> {
  TextEditingController remarksController = TextEditingController();
  TextEditingController dropFM = TextEditingController();
  TextEditingController dropwB = TextEditingController();
  bool showAdditional = false;
  bool isLoading = true;
  JobDetails? details;
  JobStatus? status;
  @override
  void initState() {
    getDetails();
    super.initState();
  }

  getDetails() async {
    details = await getJobDetails(context, widget.data);
    if (details != null) {
      setState(() {
        remarksController.text = details?.remark ?? '';
        dropFM.text = details?.dropFm ?? '';
        dropwB.text = details?.dropWb ?? '';
        status = Constants.jobStatus[details?.jobStatus]!;
        isLoading = false;
      });
    } else {
      Navigator.pop(context);
    }
  }

  Future<JobDetails?> getJobDetails(BuildContext context, TripJob data) async {
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
      return null;
    }).whenComplete(() {
      // EasyLoading.dismiss();
    });

    return result;
  }

  Future<CommonResponse?> updateJobDetails(BuildContext context) async {
    JobApi dioApi = JobApi(context);
    var result;
    // EasyLoading.show(maskType: EasyLoadingMaskType.black);
    await dioApi
        .updateJobDetails(
      jobNo: widget.data.jobNo!,
      dropFM: dropFM.text,
      dropWB: dropwB.text,
      jobRemark: remarksController.text,
      jobActivity: status!.jobValue,
    )
        .then((detail) {
      result = detail;
    }, onError: (e) {
      Utils.printInfo('trip LSIT ERROR: $e');
      return null;
    }).whenComplete(() {
      // EasyLoading.dismiss();
    });

    return result;
  }

  Future<CommonResponse?> updateJobDropQty(BuildContext context) async {
    JobApi dioApi = JobApi(context);
    var result;
    // EasyLoading.show(maskType: EasyLoadingMaskType.black);
    await dioApi
        .updateJobDropQty(
      jobNo: widget.data.jobNo!,
      dropFM: dropFM.text,
      dropWB: dropwB.text,
      jobRemark: remarksController.text,
    )
        .then((detail) {
      result = detail;
    }, onError: (e) {
      Utils.printInfo('trip LSIT ERROR: $e');
      return null;
    }).whenComplete(() {
      // EasyLoading.dismiss();
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onTap: () {
          Utils.unfocusContext(context);
        },
        child: Scaffold(
          body: ChangeNotifierProvider(
            create: (context) => ImageController(),
            child: Consumer<ImageController>(
                builder: (context, controller, child) {
              return Stack(
                children: [
                  Container(
                    // margin: EdgeInsets.only(
                    //     top:
                    //
                    //    kToolbarHeight + MediaQuery.viewPaddingOf(context).top),
                    height: MediaQuery.sizeOf(context).height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.red.shade600,
                            Colors.red.shade400,
                            Colors.red.shade300,
                            Colors.red.shade200,
                            Colors.red.shade100,
                            Colors.red.shade50
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.05, 0.1, 0.2, 0.3, 0.4, 0.45]),
                    ),
                    padding: EdgeInsets.fromLTRB(
                        16,
                        kToolbarHeight + MediaQuery.viewPaddingOf(context).top,
                        16,
                        16),
                    child: !isLoading
                        ? SingleChildScrollView(
                            child: Column(
                              // mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 18, 16, 6),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.3,
                                            child: const Text(
                                              "Job No",
                                              style: TextStyle(
                                                fontSize: 15,
                                                shadows: [
                                                  Shadow(
                                                      blurRadius: 2,
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const Text(
                                            ":",
                                            style: TextStyle(
                                              fontSize: 16,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 2,
                                                    color: Colors.black),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 6),
                                              // color: AppColor.blueboxBlue,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.3,
                                              child: Text(
                                                "${widget.data.jobNo}",
                                                style: const TextStyle(
                                                  fontSize: 15,
                                                  shadows: [
                                                    Shadow(
                                                        blurRadius: 2,
                                                        color: Colors.black),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.3,
                                            child: const Text.rich(
                                                TextSpan(children: [
                                              TextSpan(
                                                text: "Current Activity ",
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  shadows: [
                                                    Shadow(
                                                        blurRadius: 2,
                                                        color: Colors.black),
                                                  ],
                                                ),
                                              ),
                                            ])),
                                          ),
                                          const Text(
                                            ":",
                                            style: TextStyle(
                                              fontSize: 16,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 2,
                                                    color: Colors.black),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  left: 12),
                                              padding: const EdgeInsets.all(5),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: status!.jobColor,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: Text(
                                                status!.tripDisplayText,
                                                style: AppFont.robotoBold(16,
                                                    color: status!.jobValue !=
                                                            "0112"
                                                        ? Colors.white
                                                        : null //Theme.of(context).extension<ExtendColors>()!.color2,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.3,
                                            child: const Text.rich(
                                                TextSpan(children: [
                                              TextSpan(
                                                text: "Upload File",
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  shadows: [
                                                    Shadow(
                                                        blurRadius: 2,
                                                        color: Colors.black),
                                                  ],
                                                ),
                                              ),
                                            ])),
                                          ),
                                          const Text(
                                            ":",
                                            style: TextStyle(
                                              fontSize: 16,
                                              shadows: [
                                                Shadow(
                                                    blurRadius: 2,
                                                    color: Colors.black),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () async {
                                                await showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return CupertinoActionSheet(
                                                        actions: <CupertinoActionSheetAction>[
                                                          CupertinoActionSheetAction(
                                                            child: const Text(
                                                              "Camera",
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await controller
                                                                  .pickImageFromCamera(
                                                                      context);
                                                            },
                                                          ),
                                                          CupertinoActionSheetAction(
                                                            child: const Text(
                                                                "Gallery"),
                                                            onPressed:
                                                                () async {
                                                              await controller
                                                                  .pickImageFromGallery(
                                                                      context);
                                                            },
                                                          ),
                                                        ],
                                                      );
                                                    });
                                              },
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                    left: 6,
                                                  ),
                                                  height: 50,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white60,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              7)),
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.3,
                                                  child: TextFormField(
                                                    textAlignVertical:
                                                        TextAlignVertical
                                                            .center,
                                                    enabled: false,
                                                    style:
                                                        AppFont.robotoSemiBold(
                                                      14,
                                                      //        color: AppColor.wordingColorBlack
                                                    ),
                                                    decoration: InputDecoration(
                                                      border: InputBorder.none,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                        horizontal: 6,
                                                      ),
                                                      // hintText: "2 seals added",
                                                      isCollapsed: true,
                                                      suffixIcon: const Icon(
                                                        Icons.upload,
                                                        size: 20,
                                                        //color: AppColor.wordingColorBlack),
                                                      ),
                                                      focusedBorder:
                                                          InputBorder.none,
                                                      hintText: "Upload File",
                                                      hintStyle:
                                                          AppFont.robotoMedium(
                                                        15,
                                                        color: Colors
                                                            .grey.shade800,
                                                      ),
                                                    ),
                                                    // controller: TextEditingController(
                                                    //     text: "Upload File"),
                                                  )),
                                            ),
                                          ),
                                        ],
                                      ),
                                      controller.getImageList.isEmpty
                                          ? SizedBox.shrink()
                                          : FadeInSlide(
                                              duration: 1,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Container(
                                                    height: 120,
                                                    child: ListView.builder(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      // gridDelegate:
                                                      //     const SliverGridDelegateWithFixedCrossAxisCount(
                                                      //   crossAxisCount: 3,
                                                      //   crossAxisSpacing: 5,
                                                      //   mainAxisSpacing: 5,
                                                      // ),
                                                      itemCount: controller
                                                          .getImageList.length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        return Container(
                                                          height: 120,
                                                          // padding:
                                                          //     EdgeInsets.all(2),
                                                          // color: Colors.white,
                                                          margin:
                                                              EdgeInsets.only(
                                                                  right: 15),
                                                          child: Stack(
                                                            children: [
                                                              GestureDetector(
                                                                // onTap: () => _viewImage(context, _imageFiles[index]),
                                                                child:
                                                                    Container(
                                                                  decoration: BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              2),
                                                                  margin:
                                                                      const EdgeInsets
                                                                          .only(
                                                                          right:
                                                                              13,
                                                                          top:
                                                                              12),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(3),
                                                                    child: Image
                                                                        .file(
                                                                      controller
                                                                              .getImageList[
                                                                          index],
                                                                      fit: BoxFit
                                                                          .fill,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Positioned(
                                                                right: 0,
                                                                top: 0,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () =>
                                                                      controller
                                                                          .removeImage(
                                                                              index),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(1),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      shape: BoxShape
                                                                          .circle,
                                                                    ),
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .cancel,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          12,
                                                                      vertical:
                                                                          4),
                                                              // surfaceTintColor: Colors.transparent,
                                                              // shadowColor: Colors.transparent,
                                                              backgroundColor:
                                                                  Colors.red
                                                                      .shade600,
                                                              // foregroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              6))),
                                                      onPressed: () {
                                                        controller.updateImage(
                                                            context,
                                                            widget.data.jobNo,
                                                            null);
                                                      },
                                                      child: Text(
                                                        "UPDATE",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ))
                                                ],
                                              ),
                                            ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white60,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 18, 16, 6),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "List of Job Activity",
                                        style: TextStyle(
                                          fontSize: 16,
                                          shadows: [
                                            Shadow(
                                                blurRadius: 2,
                                                color: Colors.black),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      for (var data in JobStatus.values)
                                        if (data != status &&
                                            data != JobStatus.notstarted)
                                          Opacity(
                                            opacity: data.jobPriority <
                                                    status!.jobPriority
                                                ? 0.3
                                                : 1,
                                            child: InkWell(
                                              onTap: () {
                                                if (data.jobPriority >
                                                    status!.jobPriority) {
                                                  setState(() {
                                                    status = data;
                                                    updateJobDetails(context)
                                                        .then((v) {
                                                      if (v!.result == true) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CustomAlertDialog(
                                                            type:
                                                                CustomAlertType
                                                                    .success,
                                                            description:
                                                                "${v.error}",
                                                            popButtonText:
                                                                "OKAY",
                                                          ),
                                                        );
                                                      } else {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              CustomAlertDialog(
                                                            type:
                                                                CustomAlertType
                                                                    .error,
                                                            description:
                                                                "${v.error}",
                                                            popButtonText:
                                                                "OKAY",
                                                          ),
                                                        );
                                                      }
                                                    });
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                        .width,
                                                margin: const EdgeInsets.only(
                                                    bottom: 12),
                                                padding:
                                                    const EdgeInsets.all(5),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    color: data.jobColor,
                                                    borderRadius:
                                                        BorderRadius.circular(5)
                                                    // border: Border(
                                                    //   bottom: BorderSide(
                                                    //       color: Theme.of(context)
                                                    //           .extension<ExtendColors>()!
                                                    //           .cardTextIndicator),
                                                    // ),
                                                    ),
                                                child: Text(
                                                  data.tripDisplayText,
                                                  style: AppFont.robotoBold(16,
                                                      color: data.jobValue !=
                                                              "0112"
                                                          ? Colors.white
                                                          : Colors
                                                              .black //Theme.of(context).extension<ExtendColors>()!.color2,
                                                      ),
                                                ),
                                              ),
                                            ),
                                          ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 26,
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () => setState(() {
                                        showAdditional = !showAdditional;
                                      }),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 5),
                                        decoration: !showAdditional
                                            ? BoxDecoration(
                                                // border: Border.all(
                                                //   color: Theme.of(context)
                                                //       .extension<ExtendColors>()!
                                                //       .cardTextIndicator,
                                                // ),
                                                color: Colors.white60,
                                                borderRadius:
                                                    BorderRadius.circular(7))
                                            : BoxDecoration(
                                                border: Border(
                                                    bottom: BorderSide(
                                                  color: Theme.of(context)
                                                      .extension<
                                                          ExtendColors>()!
                                                      .cardTextIndicator,
                                                )),
                                              ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text(
                                              "Additional Info",
                                              style: TextStyle(
                                                fontSize: 16,
                                                shadows: [
                                                  Shadow(
                                                      blurRadius: 2,
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                            Icon(!showAdditional
                                                ? Icons.arrow_drop_down
                                                : Icons.arrow_drop_up)
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 26,
                                    ),
                                    showAdditional
                                        ? additionalOption(context)
                                        : const SizedBox.shrink()
                                  ],
                                ),
                              ],
                            ),
                          )
                        : const Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.viewPaddingOf(context).top),
                    child: Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.chevron_left,
                              size: 36, weight: 100, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context, status);
                          },
                        ),
                        Text(
                          "Update Job Details",
                          style:
                              AppFont.robotoSemiBold(18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );

    //     },
    //   ),
    // );
  }

  additionalOption(BuildContext context) {
    return FadeInSlide(
      duration: 0.6,
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Drop Qty(FM) ",
                    style: AppFont.robotoMedium(
                      15,
                      // color: AppColor.wordingColorBlack,
                    ),
                  ),
                ])),
              ),
              Text(
                ":",
                style: AppFont.robotoExtraBold(
                  16,
                  // color: AppColor.wordingColorBlack,
                ),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 6,
                    ),
                    height: 50,
                    alignment: Alignment.center,
                    // color: AppColor.blueboxBlue,
                    // padding: EdgeInsets.only(left: 6, right: 6, bottom: 6),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .extension<ExtendColors>()!
                                .cardTextIndicator),
                        borderRadius: BorderRadius.circular(4)),
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 6),
                        hintText: "1.10",
                        isCollapsed: true,
                        // suffixIcon: Icon(
                        //   Icons.qr_code_scanner,
                        //   size: 20,
                        // ),
                        focusedBorder: InputBorder.none,
                        hintStyle: AppFont.robotoMedium(
                          14,
                          // color: AppColor.blueboxGray
                        ),
                      ),
                      controller: dropFM,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Drop Qty(WB) ",
                    style: AppFont.robotoMedium(
                      15,
                      // color: AppColor.wordingColorBlack,
                    ),
                  ),
                ])),
              ),
              Text(
                ":",
                style: AppFont.robotoExtraBold(
                  16,
                  // color: AppColor.wordingColorBlack,
                ),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 6,
                    ),
                    height: 50,
                    alignment: Alignment.center,
                    // color: AppColor.blueboxBlue,
                    // padding: EdgeInsets.only(left: 6, right: 6, bottom: 6),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .extension<ExtendColors>()!
                                .cardTextIndicator),
                        borderRadius: BorderRadius.circular(4)),
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      enabled: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        hintText: "Eg. 1",
                        isCollapsed: true,
                        // suffixIcon: Icon(CupertinoIcons.chevron_down,
                        //     size: 20, color: AppColor.wordingColorBlack),
                        focusedBorder: InputBorder.none,
                        hintStyle: AppFont.robotoMedium(
                          14,
                          // color: AppColor.blueboxGray
                        ),
                      ),
                      controller: dropwB,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.3,
                child: Text.rich(TextSpan(children: [
                  TextSpan(
                    text: "Remarks ",
                    style: AppFont.robotoMedium(
                      15,
                      // color: AppColor.wordingColorBlack,
                    ),
                  ),
                ])),
              ),
              Text(
                ":",
                style: AppFont.robotoExtraBold(
                  16,
                  // color: AppColor.wordingColorBlack,
                ),
              ),
              Expanded(
                child: Container(
                    margin: const EdgeInsets.only(
                      left: 6,
                    ),
                    height: 50,
                    alignment: Alignment.center,
                    // color: AppColor.blueboxBlue,
                    // padding: EdgeInsets.only(left: 6, right: 6, bottom: 6),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .extension<ExtendColors>()!
                                .cardTextIndicator),
                        borderRadius: BorderRadius.circular(4)),
                    width: MediaQuery.sizeOf(context).width * 0.3,
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      enabled: true,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 6,
                        ),
                        hintText: "Eg. Handle with care",
                        isCollapsed: true,
                        // suffixIcon: Icon(CupertinoIcons.chevron_down,
                        //     size: 20, color: AppColor.wordingColorBlack),
                        focusedBorder: InputBorder.none,
                        hintStyle: AppFont.robotoMedium(
                          14,
                          // color: AppColor.blueboxGray
                        ),
                      ),
                      controller: remarksController,
                    )),
              ),
            ],
          ),
          const SizedBox(
            height: 12,
          ),
          const SizedBox(
            height: 50,
          ),
          Material(
            borderRadius: BorderRadius.circular(7),
            child: InkWell(
              onTap: () {
                updateJobDropQty(context).then((v) {
                  if (v!.result == true) {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        type: CustomAlertType.success,
                        description: "${v.error}",
                        popButtonText: "OKAY",
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        type: CustomAlertType.error,
                        description: "${v.error}",
                        popButtonText: "OKAY",
                      ),
                    );
                  }
                });
              },
              child: Container(
                height: 40,
                width: MediaQuery.sizeOf(context).width * 0.5,
                decoration: BoxDecoration(
                    color: Colors.red.shade600,
                    // border: Border.all(
                    //     color: Theme.of(context)
                    //         .extension<ExtendColors>()!
                    //         .cardTextIndicator),
                    borderRadius: BorderRadius.circular(6)),
                alignment: Alignment.center,
                child: const Text(
                  "UPDATE JOB",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      Shadow(blurRadius: 2, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.viewPaddingOf(context).bottom + 12,
          ),
        ],
      ),
    );
  }
}
