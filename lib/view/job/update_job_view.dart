import 'package:acegases_hms/Utils/action_completed_dialog.dart';
import 'package:acegases_hms/Utils/app_font.dart';
import 'package:acegases_hms/Utils/custom_animation_fadeIn.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateJobDetailViewDartView extends StatefulWidget {
  const UpdateJobDetailViewDartView({super.key});

  @override
  State<UpdateJobDetailViewDartView> createState() =>
      _UpdateJobDetailViewDartViewState();
}

class _UpdateJobDetailViewDartViewState
    extends State<UpdateJobDetailViewDartView> {
  List<Map<String, Color>> jobType = [
    {"Start Job": Colors.blue.shade500},
    {"Exit Origin": Colors.blue.shade500},
    {"InQ Destination": Colors.green.shade600},
    {"Finish Job": Colors.yellow.shade800}
  ];

  bool showAdditional = false;
  Map<String, Color> selectedJobAct = {"Start Job": Colors.blue.shade500};
  @override
  Widget build(BuildContext context) {
    // ShipmentsJobDetailController viewController = ShipmentsJobDetailController();
    // return ChangeNotifierProvider<ShipmentsJobDetailModel>(
    //   create: (context) => ShipmentsJobDetailModel.instance(),
    //   child: Consumer<ShipmentsJobDetailModel>(
    //     builder: (context, viewModel, child) {
    return GestureDetector(
      // onTap: () => Utils.unfocusContext(context),
      child: Scaffold(
        backgroundColor: Colors.white60,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          // backgroundColor: Utils.getColor(context).color3!.withOpacity(0.8),
          leading: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(Icons.chevron_left,
                size: 36, weight: 100, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            "Update Job Details",
            style: AppFont.robotoSemiBold(18, color: Colors.white),
          ),
          centerTitle: false,
          actions: [
            // Icon(
            //   CupertinoIcons.link,
            //   size: 30,
            // ),
            // Icon(
            //   CupertinoIcons.tag,
            //   size: 30,
            // ),
            // Icon(
            //   CupertinoIcons.captions_bubble,
            //   size: 30,
            // )
          ],
        ),
        body: Container(
          height: MediaQuery.sizeOf(context).height,
          color: Colors.white10,
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
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
                        width: MediaQuery.sizeOf(context).width * 0.3,
                        child: Text(
                          "2402130009-D2",
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
                            enabled: false,
                            style: AppFont.robotoSemiBold(
                              14,
                              //        color: AppColor.wordingColorBlack
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
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
                              hintStyle: AppFont.robotoMedium(
                                14,
                                // color: AppColor.blueboxGray),
                              ),
                            ),
                            controller:
                                TextEditingController(text: "3 files uploaded"),
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
                            color: selectedJobAct.values.first,
                            borderRadius: BorderRadius.circular(5)
                            // border: Border(
                            //   bottom: BorderSide(
                            //       color: Theme.of(context)
                            //           .extension<ExtendColors>()!
                            //           .cardTextIndicator),
                            // ),
                            ),
                        child: Text(
                          selectedJobAct.keys.first,
                          style: AppFont.robotoMedium(16,
                              color: Colors
                                  .white //Theme.of(context).extension<ExtendColors>()!.color2,
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
                      color: Utils.getColor(context).color2!.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12)),
                  padding: EdgeInsets.fromLTRB(16, 18, 16, 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("List of Job Activity"),
                      SizedBox(
                        height: 16,
                      ),
                      for (Map<String, Color> data in jobType)
                        if (data.keys.first != selectedJobAct.keys.first)
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedJobAct = data;
                                showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                    backgroundColor: Colors.transparent,
                                    child: ActionCompleteDialog(
                                      description:
                                          "Job Activity Update Succesful!",
                                    ),
                                  ),
                                );
                              });
                            },
                            child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              margin: EdgeInsets.only(bottom: 12),
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: data.values.first,
                                  borderRadius: BorderRadius.circular(5)
                                  // border: Border(
                                  //   bottom: BorderSide(
                                  //       color: Theme.of(context)
                                  //           .extension<ExtendColors>()!
                                  //           .cardTextIndicator),
                                  // ),
                                  ),
                              child: Text(
                                data.keys.first,
                                style: AppFont.robotoMedium(16,
                                    color: Colors
                                        .white //Theme.of(context).extension<ExtendColors>()!.color2,
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
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 5),
                        decoration: !showAdditional
                            ? BoxDecoration(
                                border: Border.all(
                                  color: Theme.of(context)
                                      .extension<ExtendColors>()!
                                      .cardTextIndicator,
                                ),
                                borderRadius: BorderRadius.circular(6))
                            : BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                  color: Theme.of(context)
                                      .extension<ExtendColors>()!
                                      .cardTextIndicator,
                                )),
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      controller: TextEditingController(),
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
                      // controller: TextEditingController(),
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
                      // controller: TextEditingController(),
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
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.transparent,
                  child: ActionCompleteDialog(
                    description: "Job Details Update Succesful!",
                  ),
                ),
              );
            },
            child: Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width * 0.6,
              decoration: BoxDecoration(
                  //      color: AppColor.ptiCardBgColor,
                  border: Border.all(
                      color: Theme.of(context)
                          .extension<ExtendColors>()!
                          .cardTextIndicator),
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
          SizedBox(
            height: MediaQuery.viewPaddingOf(context).bottom + 12,
          ),
        ],
      ),
    );
  }
}
