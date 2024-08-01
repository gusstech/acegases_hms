// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/routes/app_routes.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<dynamic> data = [
    {
      "id": "TRIP 12313",
      "jobNo": "1",
      "jobList": ["GIS"]
    },
    {
      "id": "TRIP 12313",
      "jobNo": "3",
      "jobList": ["GIS", "KLCC", "TRX"]
    }
  ];

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 12,
            ),
            SizedBox(
              width: screenWidth,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    "Trip List",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                  Positioned(
                      right: 16,
                      child: InkWell(
                        onTap: () async {
                          final result = await logutDialog(context);
                          if (result != null && result) {
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppRoutes.loginScreenRoute, (route) => false);
                          }
                        },
                        child: Icon(
                          Icons.logout,
                          size: 28,
                          color: Colors.white,
                        ),
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: Container(
                    // width: screenWidth,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(30)),
                        color: Colors.white60),
                    child: ListView.builder(
                      itemCount: data.length,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        return TripListCard(data: data[index], index: index);
                      },
                    ))),
          ],
        ),
      ),
    );
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
}

class TripListCard extends StatefulWidget {
  const TripListCard({
    Key? key,
    required this.index,
    required this.data,
  }) : super(key: key);
  final int index;
  final dynamic data;

  @override
  State<TripListCard> createState() => _TripListCardState();
}

class _TripListCardState extends State<TripListCard> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          isThreeLine: true,
          onTap: () =>
              Navigator.pushNamed(context, AppRoutes.jobDetailScreenRoute),
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
          horizontalTitleGap: 2,
          leading: Text(
            "${widget.index + 1}",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${widget.data["id"]}  (${widget.data["jobNo"]})",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "Job Delivery Location",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              widget.data["jobList"].length > 2 && showMore
                  ? Column(children: [
                      for (var x = 0; x < widget.data["jobList"].length; x++)
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Deliver Point ${x + 1}: ",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "${widget.data["jobList"][x]} ",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ])
                  : Row(
                      children: [
                        Text(
                          "Deliver Point ${widget.data["jobList"].length > 2 ? "1" : ''}: ",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          "${widget.data["jobList"].first}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
              widget.data["jobList"].length > 2
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          showMore = !showMore;
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        margin: EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple.shade500,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                !showMore ? "SHOW MORE" : "SHOW LESS",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              showMore
                                  ? Transform.rotate(
                                      angle: 3.14 / 2,
                                      child: Icon(
                                        Icons.chevron_left,
                                        color: Colors.white,
                                      ))
                                  : Transform.rotate(
                                      angle: 3.14 / 2,
                                      child: Icon(
                                        Icons.chevron_right,
                                        color: Colors.white,
                                      ))
                            ]),
                      ),
                    )
                  : SizedBox()
            ],
          ),
          trailing: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.red.shade700),
            child: Text(
              "Not Started",
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
        Divider(),
      ],
    );
  }

  Text deliveryPoint() {
    return Text(
      "Delivery To : Gussmann Integrated Solution",
      style: TextStyle(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
