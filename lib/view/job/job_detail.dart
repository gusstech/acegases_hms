import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/single_child_widget.dart';

class JobDetailView extends StatefulWidget {
  JobDetailView({super.key});

  @override
  State<JobDetailView> createState() => _JobDetailViewState();
}

class _JobDetailViewState extends State<JobDetailView> {
  List<String> data = ["TRIP 12313", "TRIP 1231230asd0a"];

  List<String> attendance = ["1"];
  bool isCheckAll = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(
          // bottom: MediaQuery.paddingOf(context).bottom,
          top: MediaQuery.paddingOf(context).top,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.deepPurple.shade700, Colors.red.shade300],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        width: screenWidth,
        height: screenHeight,
        child: Stack(
          children: [
            Positioned(
              top: 12,
              child: InkWell(
                onTap: () => Navigator.pop(context),
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
                bottom: kBottomNavigationBarHeight +
                    MediaQuery.paddingOf(context).bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    tripDetails(screenWidth),
                    _attendance(screenWidth),
                    _driver(screenWidth),
                    _jobList(),
                    SizedBox(
                      height: kToolbarHeight +
                          MediaQuery.paddingOf(context).bottom +
                          12,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 16,
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
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: CustomAlertDialog(
                                      type: CustomAlertType.alert,
                                      popButtonText: "OKAY",
                                      description:
                                          "Please select a job to proceed"),
                                ),
                              );
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
                                          blurRadius: 2, color: Colors.white),
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
                            onTap: () {},
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
                                          blurRadius: 2, color: Colors.white),
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
          ],
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
                            setState(() {
                              isCheckAll = !isCheckAll;
                            });
                          },
                          icon: Icon(isCheckAll
                              ? Icons.check_box_outlined
                              : Icons.check_box_outline_blank)),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // const Divider(),
                ListTile(
                  onTap: () => Navigator.pushNamed(
                      context, AppRoutes.updateJobDetailScreenRoute),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  leading: IconButton(
                      onPressed: () {
                        setState(() {
                          isCheckAll = !isCheckAll;
                        });
                      },
                      icon: Icon(isCheckAll
                          ? Icons.check_box_outlined
                          : Icons.check_box_outline_blank)),
                  horizontalTitleGap: 2,
                  isThreeLine: true,
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Receiver : Yap",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "SO No. : L-2406-0094-1-D1",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "DO No. : 112-123-123",
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
                            "25/07/2024",
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
                            "25/07/2024",
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
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Colors.yellow.shade700),
                    child: Text(
                      "Completed",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
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
                ),
              ],
            ),
          ],
        ));
  }

  Container _driver(double screenWidth) {
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
            //                 color: Colors.deepPurple.shade500,
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
                      onTap: () {},
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
                      onTap: () {},
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
        ));
  }

  Widget _attendance(double screenWidth) {
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
                  "Attendance",
                  style: TextStyle(shadows: [
                    Shadow(
                      blurRadius: 2,
                    ),
                  ], fontSize: 16, fontWeight: FontWeight.w600),
                ),
                attendance.length < 3
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            attendance.add((attendance.length + 1).toString());
                          });
                        },
                        child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 12),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.shade500,
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
                            )))
                    : SizedBox()
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Column(
              children: attendance
                  .map(
                    (e) => _scanAttendance(e),
                  )
                  .toList(),
            ),
          ],
        ));
  }

  Row _scanAttendance(String e) {
    return Row(
      children: [
        Text("$e. "),
        InkWell(
            onTap: () {},
            child: Container(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
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
                )))
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
            const Text(
              "TRIP ID :1231231",
              style: TextStyle(shadows: [
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
                      child: const Text("")),
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
                      child: const Text("0.00")),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 7),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple.shade500,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: Colors.deepPurple.shade500, width: 2)),
                  child: Text(
                    "Update",
                    style: TextStyle(
                        color: Colors.white,
                        // shadows: [
                        //   Shadow(blurRadius: 2, color: Colors.white),
                        // ],
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withOpacity(0.8)),
                        child: const Text("SAMASTAR_BKH")),
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
                        margin: const EdgeInsets.all(6),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white.withOpacity(0.8)),
                        child: const Text("SAMASTAR_BKH")),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
