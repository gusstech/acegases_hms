import 'package:acegases_hms/Utils/action_completed_dialog.dart';
import 'package:acegases_hms/Utils/app_font.dart';
import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/Utils/custom_animation_fadeIn.dart';
import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/controller/job/job_controller.dart';
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
  JobController controller = JobController();
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
          // backgroundColor: Colors.white60,
          // appBar: AppBar(
          //   surfaceTintColor: Colors.transparent,
          //   leading: IconButton(
          //     padding: EdgeInsets.zero,
          //     icon: Icon(Icons.chevron_left,
          //         size: 36, weight: 100, color: Colors.white),
          //     onPressed: () {
          //       Navigator.pop(context, status);
          //     },
          //   ),
          //   title: Text(
          //     "Update Job Details",
          //     style: AppFont.robotoSemiBold(18, color: Colors.white),
          //   ),
          //   centerTitle: false,
          //   actions: [
          //     // Icon(
          //     //   CupertinoIcons.link,
          //     //   size: 30,
          //     // ),
          //     // Icon(
          //     //   CupertinoIcons.tag,
          //     //   size: 30,
          //     // ),
          //     // Icon(
          //     //   CupertinoIcons.captions_bubble,
          //     //   size: 30,
          //     // )
          //   ],
          // ),
          body: Stack(
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
                        Colors.deepPurple.shade700,
                        Colors.deepPurple.shade500,
                        Colors.deepPurple.shade400,
                        Colors.deepPurple.shade200,
                        Colors.deepPurple.shade100
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.02, 0.03, 0.07, 0.095, 0.3]),
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
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  child: Text(
                                    "Job No",
                                    style: AppFont.robotoMedium(
                                      15,
                                      //      color: AppColor.wordingColorBlack,
                                    ),
                                  ),
                                ),
                                Text(
                                  ":",
                                  style: AppFont.robotoExtraBold(
                                    16,
                                    //   color: AppColor.wordingColorBlack,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 6),
                                    // color: AppColor.blueboxBlue,
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    child: Text(
                                      "${widget.data.jobNo}",
                                      style: AppFont.robotoSemiBold(
                                        15,
                                        //       color: AppColor.wordingColorBlack,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: "Upload File",
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
                                  child: InkWell(
                                    onTap: () async {
                                      await showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return CupertinoActionSheet(
                                              actions: <CupertinoActionSheetAction>[
                                                CupertinoActionSheetAction(
                                                  child: Text(
                                                    "Camera",
                                                    // style: AppFont.helvBold(16,
                                                    //     color: AppColors.appBlack()),
                                                  ),
                                                  onPressed: () async {
                                                    // Navigator.pop(context);

                                                    await controller.getImage(
                                                        context,
                                                        ImageSource.camera,
                                                        widget.data.jobNo!);
                                                  },
                                                ),
                                                CupertinoActionSheetAction(
                                                  child: Text("Gallery"
                                                      // Utils.getTranslated(
                                                      //     context, "report_gallery"),
                                                      // style: AppFont.helvBold(16,
                                                      //     color: AppColors.appBlack()),
                                                      ),
                                                  onPressed: () async {
                                                    await controller.getImage(
                                                        context,
                                                        ImageSource.gallery,
                                                        widget.data.jobNo!);
                                                  },
                                                ),
                                              ],
                                            );
                                          });

                                      // if (result != null && result is bool) {
                                      //   print(result);
                                      //   print(result);
                                      //   print(result);
                                      //   print(result);

                                      //   showDialog(
                                      //     context: context,
                                      //     // barrierColor: Colors.transparent,
                                      //     barrierDismissible: true,
                                      //     builder: (context) => CustomAlertDialog(
                                      //       type: result!
                                      //           ? CustomAlertType.success
                                      //           : CustomAlertType.error,
                                      //       description: result!
                                      //           ? "Succesfully upload image"
                                      //           : "Failed to upload image.",
                                      //       popButtonText: "OK",
                                      //     ),
                                      //   );
                                      // }
                                      // Navigator.pop(context);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          left: 6,
                                        ),
                                        height: 50,
                                        alignment: Alignment.center,
                                        // color: AppColor.blueboxBlue,
                                        // padding: EdgeInsets.only(left: 6, right: 6, bottom: 6),
                                        decoration: BoxDecoration(
                                            color: Colors.white60,
                                            // border: Border.all(
                                            //     color: Theme.of(context)
                                            //         .extension<ExtendColors>()!
                                            //         .cardTextIndicator),
                                            borderRadius:
                                                BorderRadius.circular(7)),
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.3,
                                        child: TextFormField(
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          enabled: false,
                                          style: AppFont.robotoSemiBold(
                                            14,
                                            //        color: AppColor.wordingColorBlack
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                              horizontal: 6,
                                            ),
                                            // hintText: "2 seals added",
                                            isCollapsed: true,
                                            suffixIcon: Icon(
                                              Icons.upload,
                                              size: 20,
                                              //color: AppColor.wordingColorBlack),
                                            ),
                                            focusedBorder: InputBorder.none,
                                            // prefixIcon: Container(
                                            //   constraints:
                                            //       BoxConstraints(maxWidth: 10, minWidth: 10),
                                            //   color: Colors.green,
                                            // ),
                                            // prefixIconConstraints: BoxConstraints(
                                            //     minHeight: 48, maxWidth: 20, minWidth: 20),
                                            hintText: "Upload File",
                                            hintStyle: AppFont.robotoMedium(
                                              15,
                                              color: Colors.grey.shade800,
                                            ),
                                          ),
                                          // controller: TextEditingController(
                                          //     text: "Upload File"),
                                        )),
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
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  child: Text.rich(TextSpan(children: [
                                    TextSpan(
                                      text: "Current Activity ",
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
                                    margin: EdgeInsets.only(left: 12),
                                    padding: EdgeInsets.all(5),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: status!.jobColor,
                                        borderRadius: BorderRadius.circular(5)
                                        // border: Border(
                                        //   bottom: BorderSide(
                                        //       color: Theme.of(context)
                                        //           .extension<ExtendColors>()!
                                        //           .cardTextIndicator),
                                        // ),
                                        ),
                                    child: Text(
                                      status!.tripDisplayText,
                                      style: AppFont.robotoBold(16,
                                          color: status!.jobValue != "0112"
                                              ? Colors.white
                                              : null //Theme.of(context).extension<ExtendColors>()!.color2,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(12)),
                              padding: EdgeInsets.fromLTRB(16, 18, 16, 6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "List of Job Activity",
                                    style: AppFont.robotoBold(
                                      16,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
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
                                                        type: CustomAlertType
                                                            .success,
                                                        description:
                                                            "${v.error}",
                                                        popButtonText: "OK",
                                                      ),
                                                    );
                                                  } else {
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          CustomAlertDialog(
                                                        type: CustomAlertType
                                                            .error,
                                                        description:
                                                            "${v.error}",
                                                        popButtonText: "OK",
                                                      ),
                                                    );
                                                  }
                                                });
                                              });
                                            }
                                          },
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                .width,
                                            margin: EdgeInsets.only(bottom: 12),
                                            padding: EdgeInsets.all(5),
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
                                                  color: data.jobValue != "0112"
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
                            SizedBox(
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
                                    padding: EdgeInsets.symmetric(
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
                                                  .extension<ExtendColors>()!
                                                  .cardTextIndicator,
                                            )),
                                          ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Additional Info",
                                          style: AppFont.robotoMedium(
                                            16,
                                            color: Theme.of(context)
                                                .extension<ExtendColors>()!
                                                .color2,
                                          ),
                                        ),
                                        Icon(!showAdditional
                                            ? Icons.arrow_drop_down
                                            : Icons.arrow_drop_up)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 26,
                                ),
                                showAdditional
                                    ? additionalOption(context)
                                    : SizedBox.shrink()
                              ],
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(),
                      ),
              ),
              Container(
                padding:
                    EdgeInsets.only(top: MediaQuery.viewPaddingOf(context).top),
                child: Row(
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.chevron_left,
                          size: 36, weight: 100, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context, status);
                      },
                    ),
                    Text(
                      "Update Job Details",
                      style: AppFont.robotoSemiBold(18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
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
                    margin: EdgeInsets.only(
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
                        contentPadding: EdgeInsets.symmetric(horizontal: 6),
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
          SizedBox(
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
                    margin: EdgeInsets.only(
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
                        contentPadding: EdgeInsets.symmetric(
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
          SizedBox(
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
                    margin: EdgeInsets.only(
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
                        contentPadding: EdgeInsets.symmetric(
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
          SizedBox(
            height: 12,
          ),
          SizedBox(
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
                        popButtonText: "OK",
                      ),
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => CustomAlertDialog(
                        type: CustomAlertType.error,
                        description: "${v.error}",
                        popButtonText: "OK",
                      ),
                    );
                  }
                });
              },
              child: Container(
                height: 50,
                width: MediaQuery.sizeOf(context).width * 0.6,
                decoration: BoxDecoration(
                    color: Colors.white60,
                    // border: Border.all(
                    //     color: Theme.of(context)
                    //         .extension<ExtendColors>()!
                    //         .cardTextIndicator),
                    borderRadius: BorderRadius.circular(12)),
                alignment: Alignment.center,
                child: Text(
                  "Update Job",
                  style: AppFont.robotoSemiBold(
                    15,
                    //           color: AppColor.blueboxGray,
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
