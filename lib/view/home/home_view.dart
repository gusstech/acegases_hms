// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:acegases_hms/Utils/utils.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:acegases_hms/controller/auth/login_controller.dart';
import 'package:acegases_hms/controller/trip/trip_controller.dart';
import 'package:acegases_hms/model/enum/tripstatus_enum.dart';
import 'package:acegases_hms/model/trip_model/trip_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = true;
  final GlobalKey<ScaffoldState> _homeKey = GlobalKey<ScaffoldState>();

  getTripList(TripController controller) async {
    var result = await controller.getTripList(context);
    // Appcache.tripList = result
    if ((result ?? []).isNotEmpty) {
      result?.forEach((v) {
        controller.getJobList(context, v);
      });
    }
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    TripController controller =
        Provider.of<TripController>(context, listen: false);

    getTripList(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;
    return Consumer<TripController>(
      builder: (context, controller, child) {
        return Scaffold(
          key: _homeKey,
          drawer: Drawer(
            backgroundColor: Colors.deepPurple.shade100,
            child: Column(
              children: <Widget>[
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  trailing: Transform.rotate(
                      angle: math.pi * 0.25,
                      child: const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Icon(
                          CupertinoIcons.plus,
                          color: Colors.black54,
                          size: 36,
                          shadows: [
                            Shadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(3, -3))
                          ],
                        ),
                      )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                const Expanded(child: SizedBox()),
                IntrinsicWidth(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.red),
                    child: Row(
                      children: [
                        const Text(
                          "LOG OUT",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () async {
                            final result = await logutDialog(context);
                            if (result != null && result) {
                              LoginController controller =
                                  Provider.of<LoginController>(context,
                                      listen: false);
                              controller.logOutUser(context);
                              Appcache.removeValues(Appcache.loginDate);
                              Appcache.removeValues(Appcache.userCredential);
                              Appcache.removeValues(Appcache.savedVehicle);
                              Appcache.usrRef = null;
                              Appcache.selectedVehicle = null;
                              Utils.disposeAllDisposableProviders(context);
                              Navigator.pushNamedAndRemoveUntil(context,
                                  AppRoutes.loginScreenRoute, (route) => false);
                            }
                          },
                          child: const Icon(
                            Icons.logout,
                            size: 28,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //            Padding(
                //           padding: const EdgeInsets.all(12.0),
                //           child: Column(
                //             children: [
                //               const Text(
                //                 "v1.0.0 (1)",
                //                 style: TextStyle(
                //                     fontSize: 12, fontWeight: FontWeight.w600),
                //               ),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.center,
                //                 children: [
                //                   const Text(
                //                     "Powered By",
                //                     style: TextStyle(
                //                         fontSize: 12, fontWeight: FontWeight.w600),
                //                   ),
                //                   Image.asset(
                //                     Constants.assetImages + "android12Splash.png",
                //                     width: 30,
                //                     height: 30,
                //                     fit: BoxFit.cover,
                //                   ),
                //                   const Text(
                //                     "Gussmann Integrated Solution",
                //                     style: TextStyle(
                //                         fontSize: 12, fontWeight: FontWeight.w600),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //
              ],
            ),
          ),
          resizeToAvoidBottomInset: false,
          body: Container(
            padding: EdgeInsets.only(
              // bottom: MediaQuery.paddingOf(context).bottom,
              top: MediaQuery.paddingOf(context).top,
            ),
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
                  stops: const [0.05, 0.1, 0.15, 0.2, 0.3]),
            ),
            width: screenWidth,
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 12,
                ),
                Container(
                  padding: const EdgeInsets.only(right: 12),
                  width: screenWidth,
                  alignment: Alignment.centerRight,
                  child:

                      // Stack(
                      //   alignment: Alignment.centerRight,
                      //   children: [
                      // Positioned(
                      //   left: 16,
                      //   child: InkWell(
                      //     onTap: () {
                      //       // Appcache.tripList.clear();
                      //       // setState(() {
                      //       //   isLoading = true;
                      //       // });
                      //       // getTripList(controller);
                      //       if (_homeKey.currentState!.isDrawerOpen) {
                      //         // If drawer is open, close it
                      //         Navigator.of(context).pop();
                      //       } else {
                      //         // If drawer is closed, open it
                      //         _homeKey.currentState!.openDrawer();
                      //       }
                      //     },
                      //     child: Icon(
                      //       Icons.menu_sharp,
                      //       size: 28,
                      //       color: Colors.white,
                      //     ),
                      //   ),
                      // ),
                      // Text(
                      //   "Home",
                      //   style: TextStyle(
                      //       fontSize: 18,
                      //       fontWeight: FontWeight.w700,
                      //       color: Colors.white),
                      // ),
                      InkWell(
                    onTap: () async {
                      final result = await logutDialog(context);
                      if (result != null && result) {
                        Appcache.removeValues(Appcache.loginDate);
                        Appcache.removeValues(Appcache.userCredential);
                        Appcache.usrRef = null;
                        Appcache.selectedVehicle = null;

                        Navigator.pushNamedAndRemoveUntil(context,
                            AppRoutes.loginScreenRoute, (route) => false);
                      }
                    },
                    child: const Icon(
                      Icons.logout,
                      size: 28,
                      color: Colors.white,
                    ),
                    //  ),
                    //   ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  width: screenWidth,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white70),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Material(
                        surfaceTintColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              controller.startDriving(context, null);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.black26,
                                  //     blurRadius: 3,
                                  //     spreadRadius: 1,
                                  //     offset: Offset(2, 2),
                                  //   )
                                  // ],
                                  // color: Colors.blue.shade500,
                                  borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      color: Colors.green.shade500,
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.truck,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    "START DRIVING",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black38,
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Material(
                        surfaceTintColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              controller.stopDriving(context, null);
                            },
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              // decoration: BoxDecoration(
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Colors.black26,
                              //         blurRadius: 3,
                              //         spreadRadius: 1,
                              //         offset: Offset(2, 2),
                              //       )
                              //     ],
                              //     color: Colors.red.shade500,
                              //     borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      // shape: BoxShape.circle,
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      color: Colors.red.shade500,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.ban,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    "STOP DRIVING",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black38,
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                      Material(
                        surfaceTintColor: Colors.transparent,
                        color: Colors.transparent,
                        child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.ptiPmSelectionScreenRoute,
                                  arguments: true);
                            },
                            splashFactory: InkRipple.splashFactory,
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 10),
                              // decoration: BoxDecoration(
                              //     boxShadow: [
                              //       BoxShadow(
                              //         color: Colors.black26,
                              //         blurRadius: 3,
                              //         spreadRadius: 1,
                              //         offset: Offset(2, 2),
                              //       )
                              //     ],
                              //     color: Colors.red.shade500,
                              //     borderRadius: BorderRadius.circular(6)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 3,
                                          spreadRadius: 1,
                                          offset: Offset(2, 2),
                                        )
                                      ],
                                      color: Colors.purple.shade500,
                                    ),
                                    child: const Icon(
                                      FontAwesomeIcons.listCheck,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    "REDO - PDC",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black54,
                                      shadows: [
                                        Shadow(
                                          color: Colors.black38,
                                          blurRadius: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Text(
                              "Trip List",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(
                              width: 12,
                            ),
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Appcache.tripList.clear();
                                  setState(() {
                                    isLoading = true;
                                  });
                                  getTripList(controller);
                                  // if (_homeKey.currentState!.isDrawerOpen) {
                                  //   // If drawer is open, close it
                                  //   Navigator.of(context).pop();
                                  // } else {
                                  //   // If drawer is closed, open it
                                  //   _homeKey.currentState!.openDrawer();
                                  // }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    // shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 3,
                                        spreadRadius: 1,
                                        offset: Offset(2, 2),
                                      )
                                    ],
                                    color: Colors.deepPurple.shade300,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Row(
                                    children: [
                                      Text(
                                        "Refresh",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.refresh,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: () {
                            Appcache.tripList.clear();
                            setState(() {
                              isLoading = true;
                            });
                            return getTripList(controller);
                          },
                          child: !isLoading
                              ? ListView.builder(
                                  itemCount: Appcache.tripList.isEmpty
                                      ? 1
                                      : Appcache.tripList.length,
                                  padding: EdgeInsets.zero,
                                  itemBuilder: (context, index) {
                                    return Appcache.tripList.isEmpty
                                        ? Padding(
                                            padding: EdgeInsets.only(
                                                top: MediaQuery.sizeOf(context)
                                                        .height *
                                                    0.3),
                                            child: const Center(
                                                child: Text(
                                                    "No Planned Trips Currently")),
                                          )
                                        : TripListCard(
                                            data: Appcache.tripList[index],
                                            index: index);
                                  },
                                )
                              : const Center(
                                  child: CircularProgressIndicator(),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> logutDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => const CustomAlertDialog(
        type: CustomAlertType.alert,
        description: "Are you sure you want to logout?",
        isLogout: true,
        cancelBtn: true,
      ),
    );
  }
}

class TripListCard extends StatefulWidget {
  const TripListCard({
    super.key,
    required this.index,
    required this.data,
  });
  final int index;
  final TripDataDTO data;

  @override
  State<TripListCard> createState() => _TripListCardState();
}

class _TripListCardState extends State<TripListCard> {
  bool showMore = false;

  late TripStatus status;

  @override
  void initState() {
    status = Constants.tripStatus["${widget.data.tripStatus}"]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            ListTile(
              isThreeLine: true,
              onTap: () async {
                await Navigator.pushNamed(
                        context, AppRoutes.jobDetailScreenRoute,
                        arguments: widget.data)
                    .then((va) {
                  status = Constants.tripStatus["$va"]!;
                  setState(() {});
                });
              },
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              horizontalTitleGap: 2,
              leading: Container(
                padding: const EdgeInsets.all(8),
                // decoration: BoxDecoration(
                //   shape: BoxShape.circle,
                //   color: Color.fromRGBO(
                //       (255 * 0.3 * widget.index).toInt(),
                //       (255 * 0.6 * widget.index).toInt(),
                //       (255 * 0.9 * widget.index).toInt(),
                //       1),
                // ),
                child: Text(
                  "${widget.index + 1}",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.data.tripNo}  (${widget.data.jobList?.length ?? 0})",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Visibility(
                    visible: false,
                    child: Text(
                      "Job Delivery Location",
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.data.showAllDate &&
                        DateTime.tryParse(
                                widget.data.jobList?.first.deliveryDate ??
                                    "") !=
                            null,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "DELIVERY REQUIRED DATE: ",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            DateFormat("EEE, MMM d,yyyy")
                                .format(DateTime.parse(
                                    widget.data.jobList!.first.deliveryDate!))
                                .toUpperCase(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  (widget.data.jobList?.length ?? 0) > 1 && showMore
                      ? Column(children: [
                          for (var x = 0; x < widget.data.jobList!.length; x++)
                            Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "RECEIVER ${x + 1}: ",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "${widget.data.jobList?[x].endPoint} ",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: !widget.data.showAllDate &&
                                      DateTime.tryParse(widget.data.jobList
                                                  ?.first.deliveryDate ??
                                              "") !=
                                          null,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "DELIVERY DATE ${x + 1}: ",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          DateFormat("EEE, MMM d,yyyy")
                                              .format(DateTime.parse(widget
                                                      .data
                                                      .jobList![x]
                                                      .deliveryDate!)
                                                  //     .add(
                                                  //   Duration(days: x + 1),
                                                  // ),
                                                  )
                                              .toUpperCase(),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: !widget.data.showAllDate &&
                                        (x + 1 < widget.data.jobList!.length),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 32.0),
                                      child: Divider(
                                        color: Colors.black26,
                                      ),
                                    ))
                              ],
                            ),
                        ])
                      : Row(
                          children: [
                            Text(
                              "RECEIVER ${(widget.data.jobList?.length ?? 0) > 1 ? "1" : ''}: ",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              "${widget.data.jobList?.first.endPoint}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                  (widget.data.jobList?.length ?? 0) > 1
                      ? InkWell(
                          onTap: () {
                            setState(() {
                              showMore = !showMore;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                                color: Colors.deepPurple.shade500,
                                borderRadius: BorderRadius.circular(5)),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    !showMore ? "SHOW MORE" : "SHOW LESS",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  showMore
                                      ? Transform.rotate(
                                          angle: 3.14 / 2,
                                          child: const Icon(
                                            Icons.chevron_left,
                                            color: Colors.white,
                                          ))
                                      : Transform.rotate(
                                          angle: 3.14 / 2,
                                          child: const Icon(
                                            Icons.chevron_right,
                                            color: Colors.white,
                                          ))
                                ]),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              style: ListTileStyle.list,
            ),
            Positioned(
              right: 20,
              top: 14,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: status.tripColor),
                child: Text(
                  status.tripDisplayText,
                  style: const TextStyle(
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
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
