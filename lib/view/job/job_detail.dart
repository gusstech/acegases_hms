import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/trip/trip_controller.dart';
import 'package:acegases_hms/model/enum/jobstatus_enum.dart';
import 'package:acegases_hms/model/enum/tripstatus_enum.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/single_child_widget.dart';
import 'package:intl/intl.dart';

class JobDetailView extends StatefulWidget {
  final TripDataDTO data;
  const JobDetailView({super.key, required this.data});

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  bool isCheckAll = false;
  TripController _controller = TripController();
  @override
  void initState() {
    // TODO: implement initState
    _controller.tripLoad.text = widget.data.jobList?.first.tripLoad ?? "0.00";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return GestureDetector(
      onTap: () => Utils.unfocusContext(context),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: EdgeInsets.only(
            // bottom: MediaQuery.paddingOf(context).bottom,
            top: MediaQuery.paddingOf(context).top,
          ),
          decoration: BoxDecoration(
            color: Colors.red.shade600,
            gradient: LinearGradient(
                colors: [
                  Colors.red.shade600,
                  Colors.red.shade400,
                  Colors.red.shade300,
                  Colors.red.shade200,
                  Colors.red.shade100
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: const [0.05, 0.1, 0.3, 0.5, 0.7]),
          ),
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              Positioned(
                top: 12,
                child: InkWell(
                  onTap: () => Navigator.pop(context, widget.data.tripStatus),
                  child: const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.chevron_left,
                          size: 32,
                          color: Colors.white,
                        ),
                        Text(
                          "BACK",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: kToolbarHeight,
                  // bottom: kBottomNavigationBarHeight +
                  //     MediaQuery.paddingOf(context).bottom,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      tripDetails(screenWidth),
                      _tankerId(screenWidth),
                      _attendance(screenWidth),
                      _driver(screenWidth),
                      _jobList(),
                      SizedBox(
                        height: MediaQuery.paddingOf(context).bottom + 20,
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 16,
                child: Visibility(
                  visible: false,
                  child: SizedBox(
                      width: screenWidth,
                      height: kBottomNavigationBarHeight +
                          MediaQuery.paddingOf(context).bottom,
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () async {
                                  await _controller
                                      .tripStart(context, widget.data)
                                      .then((v) {
                                    setState(() {});
                                  });

                                  // // _controller.stopDriving(context, widget.data);
                                  // showDialog(
                                  //   context: context,
                                  //   builder: (context) => CustomAlertDialog(
                                  //       type: CustomAlertType.alert,
                                  //       popButtonText: "OKAY",
                                  //       description:
                                  //           "Please select a job to proceed"),
                                  // );
                                },
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      color: Color.fromARGB(255, 48, 132, 201),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    "START",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              blurRadius: 2,
                                              color: Colors.white),
                                        ],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: InkWell(
                                onTap: () async {
                                  await _controller
                                      .tripFinish(context, widget.data)
                                      .then((v) {
                                    setState(() {});
                                  });
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  height: 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      color: Color.fromARGB(255, 212, 171, 66),
                                      borderRadius: BorderRadius.circular(6)),
                                  child: Text(
                                    "FINISH",
                                    style: TextStyle(
                                        shadows: [
                                          Shadow(
                                              blurRadius: 2,
                                              color: Colors.white),
                                        ],
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white),
                                  ),
                                )),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _jobList() {
    return Container(
        margin: const EdgeInsets.fromLTRB(16, 10, 16, 0),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Text(
                    "Job List",
                    style: TextStyle(shadows: [
                      Shadow(
                        blurRadius: 2,
                      ),
                    ], fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Expanded(child: SizedBox()),
                  Row(
                    children: [
                      const Text(
                        "Select All",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54),
                      ),
                      IconButton(
                          onPressed: () {
                            if (widget.data.jobList!
                                .any((v) => v.isChecked == false)) {
                              for (var element in widget.data.jobList!) {
                                element.isChecked = true;
                              }
                            } else {
                              for (var element in widget.data.jobList!) {
                                element.isChecked = false;
                              }
                            }
                            setState(() {});
                          },
                          icon: Icon(widget.data.jobList!
                                  .any((v) => v.isChecked == false)
                              ? Icons.check_box_outline_blank
                              : Icons.check_box_outlined)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [for (var x in widget.data.jobList!) jobCard(x)],
            ),
          ],
        ));
  }

  Widget jobCard(TripJob v) {
    return Builder(builder: (context) {
      TripStatus status = Constants.tripJob["${v.jobStatus}"]!;

      return ListTile(
        onTap: () async {
          var result = await Navigator.pushNamed(
              context, AppRoutes.updateJobDetailScreenRoute,
              arguments: v);

          if (result != null && result == JobStatus.completed) {
            v.jobStatus = JobStatus.completed.jobValue;
            if (!widget.data.jobList!.any((e) {
              return e.jobStatus != JobStatus.completed.jobValue;
            })) {
              widget.data.tripStatus = TripStatus.completed.tripValue;
            } else if (widget.data.jobList!.any((e) {
              return e.jobStatus == JobStatus.started.jobValue;
            })) {
              widget.data.tripStatus = TripStatus.inprogress.tripValue;
            } else {
              widget.data.tripStatus = TripStatus.notstarted.tripValue;
            }
            setState(() {});
          } else if (result != null && result == JobStatus.started) {
            v.jobStatus = JobStatus.started.jobValue;
            widget.data.tripStatus = TripStatus.inprogress.tripValue;
            setState(() {});
          }
        },
        contentPadding: EdgeInsets.symmetric(horizontal: 12),
        leading: IconButton(
            onPressed: () {
              setState(() {
                v.isChecked = !v.isChecked;
              });
            },
            icon: Icon(v.isChecked
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank)),
        horizontalTitleGap: 2,
        isThreeLine: true,
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Receiver : ${v.customer}",
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            Text(
              "SO No. : ${v.jobNo}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            Text(
              "DO No. : ${v.doNo}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              children: [
                Text(
                  "ETA Date : ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy').format(DateTime.parse(v.lastDate!)),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Delivery Date: ",
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
                Text(
                  DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(v.deliveryDate!)),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
        trailing: Container(
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3), color: status.tripColor),
          child: Text(
            status.tripDisplayText,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 10,
                color: Colors.white70,
                shadows: [
                  Shadow(
                    color: Colors.white70,
                    blurRadius: 2,
                  ),
                ]),
          ),
        ),
        style: ListTileStyle.list,
      );
    });
  }

  Widget _driver(double screenWidth) {
    return Visibility(
      visible: false,
      child: Container(
          width: screenWidth,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Driver",
                style: TextStyle(shadows: [
                  Shadow(
                    blurRadius: 2,
                  ),
                ], fontSize: 16, fontWeight: FontWeight.w600),
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //           margin: const EdgeInsets.symmetric(vertical: 8),
              //           padding: const EdgeInsets.symmetric(
              //               horizontal: 10, vertical: 6),
              //           decoration: BoxDecoration(
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black26,
              //                   blurRadius: 3,
              //                   spreadRadius: 1,
              //                   offset: Offset(2, 2),
              //                 )
              //               ],
              //               borderRadius: BorderRadius.circular(4),
              //               color: Colors.white.withOpacity(0.8)),
              //           child: const Text("Andrew")),
              //     ),
              //     InkWell(
              //         onTap: () {},
              //         child: Container(
              //             margin: EdgeInsets.only(left: 8),
              //             padding: const EdgeInsets.symmetric(
              //                 horizontal: 6, vertical: 6),
              //             decoration: BoxDecoration(
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black26,
              //                     blurRadius: 3,
              //                     spreadRadius: 1,
              //                     offset: Offset(2, 2),
              //                   )
              //                 ],
              //                 color: Colors.red.shade500,
              //                 borderRadius: BorderRadius.circular(6)),
              //             child: const Row(
              //               children: [
              //                 Text(
              //                   "Change Driver",
              //                   style: TextStyle(
              //                       color: Colors.white,
              //                       fontSize: 10,
              //                       fontWeight: FontWeight.w800),
              //                 ),
              //                 SizedBox(
              //                   width: 5,
              //                 ),
              //                 Icon(
              //                   Icons.change_circle_outlined,
              //                   color: Colors.white,
              //                   size: 20,
              //                 )
              //               ],
              //             ))),
              //   ],
              // ),

              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          _controller.startDriving(context, widget.data);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(2, 2),
                                )
                              ],
                              color: Colors.blue.shade500,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            "START DRIVING",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: InkWell(
                        onTap: () {
                          _controller.stopDriving(context, widget.data);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3,
                                  spreadRadius: 1,
                                  offset: Offset(2, 2),
                                )
                              ],
                              color: Colors.red.shade500,
                              borderRadius: BorderRadius.circular(6)),
                          child: Text(
                            "STOP",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.white,
                                  blurRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        )),
                  )
                ],
              ),
            ],
          )),
    );
  }

  Widget _tankerId(double screenWidth) {
    return Container(
        width: screenWidth,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text(
                  "Tanker ID",
                  style: TextStyle(shadows: [
                    Shadow(
                      blurRadius: 2,
                    ),
                  ], fontSize: 16, fontWeight: FontWeight.w600),
                ),
                // (widget.data.attendance?.length ?? 0) < 3
                //     ? Visibility(
                //         visible: false,
                //         child: InkWell(
                //             onTap: () {
                //               setState(() {
                //                 Appcache.tripList
                //                     .firstWhere((e) {
                //                       return e.tripNo == widget.data.tripNo;
                //                     })
                //                     .attendance!
                //                     .add("");
                //                 // attendance.add((attendance.length + 1).toString());
                //               });
                //             },
                //             child: Container(
                //                 margin: const EdgeInsets.symmetric(
                //                     vertical: 4, horizontal: 12),
                //                 padding: const EdgeInsets.symmetric(
                //                     horizontal: 8, vertical: 6),
                //                 decoration: BoxDecoration(
                //                     color: Colors.red.shade500,
                //                     boxShadow: [
                //                       BoxShadow(
                //                         color: Colors.black26,
                //                         blurRadius: 3,
                //                         spreadRadius: 1,
                //                         offset: Offset(2, 2),
                //                       )
                //                     ],
                //                     borderRadius: BorderRadius.circular(6)),
                //                 child: const Row(
                //                   children: [
                //                     Text(
                //                       "Add New",
                //                       style: TextStyle(color: Colors.white),
                //                     ),
                //                     SizedBox(
                //                       width: 5,
                //                     ),
                //                     Icon(
                //                       Icons.person,
                //                       color: Colors.white,
                //                     )
                //                   ],
                //                 ))),
                //       )
                //     : SizedBox()
              ],
            ),
            Visibility(
              visible: widget.data.jobList?.first.tanker != null &&
                  widget.data.jobList!.first.tanker!.isNotEmpty,
              child: Text(
                widget.data.jobList?.first.tanker ?? "",
                style: TextStyle(shadows: [
                  Shadow(
                    blurRadius: 2,
                  ),
                ], fontSize: 12, fontWeight: FontWeight.w600),
              ),
            ),
            // widget.data.attendance != null && widget.data.attendance!.isNotEmpty
            //     ? Column(children: [
            //         for (var x = 0; x < widget.data.attendance!.length; x++)
            //           _scanAttendance(x, widget.data.attendance![x])
            //       ])
            //     : SizedBox.shrink(),
          ],
        ));
  }

  Widget _attendance(double screenWidth) {
    return Visibility(
      visible: false,
      child: Container(
          width: screenWidth,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white60),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Attendance",
                    style: TextStyle(shadows: [
                      Shadow(
                        blurRadius: 2,
                      ),
                    ], fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  (widget.data.attendance?.length ?? 0) < 3
                      ? Visibility(
                          visible: false,
                          child: InkWell(
                              onTap: () {
                                setState(() {
                                  Appcache.tripList
                                      .firstWhere((e) {
                                        return e.tripNo == widget.data.tripNo;
                                      })
                                      .attendance!
                                      .add("");
                                  // attendance.add((attendance.length + 1).toString());
                                });
                              },
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 12),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 6),
                                  decoration: BoxDecoration(
                                      color: Colors.red.shade500,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(6)),
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Add New",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      )
                                    ],
                                  ))),
                        )
                      : SizedBox()
                ],
              ),
              SizedBox(
                height: 8,
              ),
              widget.data.attendance != null &&
                      widget.data.attendance!.isNotEmpty
                  ? Column(children: [
                      for (var x = 0; x < widget.data.attendance!.length; x++)
                        _scanAttendance(x, widget.data.attendance![x])
                    ])
                  : SizedBox.shrink(),
            ],
          )),
    );
  }

  Row _scanAttendance(int x, String e) {
    return Row(
      children: [
        Text("${x + 1}. $e"),
        Visibility(
          visible: false,
          child: InkWell(
              onTap: () {},
              child: Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 3,
                          spreadRadius: 1,
                          offset: Offset(2, 2),
                        )
                      ],
                      color: Colors.green.shade500,
                      borderRadius: BorderRadius.circular(8)),
                  child: const Row(
                    children: [
                      Text(
                        "SCAN",
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.qr_code,
                        color: Colors.white,
                      )
                    ],
                  ))),
        )
      ],
    );
  }

  Container tripDetails(double screenWidth) {
    return Container(
        width: screenWidth,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "TRIP ID :${widget.data.tripNo}",
              style: const TextStyle(shadows: [
                Shadow(
                  blurRadius: 2,
                ),
              ], fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    "Source :",
                    style: TextStyle(shadows: [
                      Shadow(
                        blurRadius: 2,
                      ),
                    ], fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                      margin: const EdgeInsets.all(6),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.white.withOpacity(0.8)),
                      child: Text(widget.data.jobList?.first.source ?? "")),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(
                  width: 120,
                  child: Text(
                    "Trip Load(kg) :",
                    style: TextStyle(shadows: [
                      Shadow(
                        blurRadius: 2,
                      ),
                    ], fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(6),
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.white.withOpacity(0.8)),
                    child: TextFormField(
                      decoration: InputDecoration(
                          hintText: "",
                          border: InputBorder.none,
                          isCollapsed: true,
                          contentPadding: EdgeInsets.all(1),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                      controller: _controller.tripLoad,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    _controller.updateTripLoad(context, widget.data);
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 8, top: 4),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade500,
                      borderRadius: BorderRadius.circular(5),
                      // border:
                      //     Border.all(color: Colors.red.shade500, width: 2),
                    ),
                    child: Text(
                      "UPDATE",
                      style: TextStyle(
                          color: Colors.white,
                          // shadows: [
                          //   Shadow(blurRadius: 2, color: Colors.white),
                          // ],
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    const Text(
                      "Start Point",
                      style: TextStyle(shadows: [
                        Shadow(
                          blurRadius: 2,
                        ),
                      ], fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Container(
                        width: MediaQuery.sizeOf(context).width * 0.38,
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withOpacity(0.8)),
                        child: Text(
                          widget.data.jobList!.firstWhereOrNull((v) {
                                return v.jobStatus != "COMPLETED";
                              })?.startPoint ??
                              "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      "End Point",
                      style: TextStyle(shadows: [
                        Shadow(
                          blurRadius: 2,
                        ),
                      ], fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    Container(
                        width: MediaQuery.sizeOf(context).width * 0.38,
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withOpacity(0.8)),
                        child: Text(
                          widget.data.jobList!.firstWhereOrNull((v) {
                                return v.jobStatus != "COMPLETED";
                              })?.endPoint ??
                              "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
