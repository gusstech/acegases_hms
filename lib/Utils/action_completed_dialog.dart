import 'package:acegases_hms/Utils/custom_animation_fadeIn.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActionCompleteDialog extends StatefulWidget {
  final String description;

  const ActionCompleteDialog({
    super.key,
    required this.description,
  });

  @override
  State<ActionCompleteDialog> createState() => _ActionCompleteDialogState();
}

class _ActionCompleteDialogState extends State<ActionCompleteDialog> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1250), (() {
      if (mounted) {
        Navigator.pop(context);
      }
    }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.3 + 40,
          child: Container(
            width: 280,
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
            decoration: BoxDecoration(
                color: Theme.of(context).extension<ExtendColors>()!.color3,
                borderRadius: BorderRadius.circular(12)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Success",
                  style: TextStyle(
                    color: Theme.of(context).extension<ExtendColors>()!.color2,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.description,
                  style: TextStyle(
                    color: Theme.of(context).extension<ExtendColors>()!.color2,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       InkWell(
                //         onTap: () => Navigator.pop(context),
                //         child: Container(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal: 8, vertical: 4),
                //           decoration: BoxDecoration(
                //               border: Border.all(
                //                   width: 3, color: Colors.lightGreen.shade500),
                //               borderRadius: BorderRadius.circular(8)),
                //           child: Text(
                //             "OKAY",
                //             style: TextStyle(
                //                 color: Colors.lightGreen.shade500,
                //                 fontWeight: FontWeight.w800),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // )
              ],
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.sizeOf(context).height * 0.3,
          child: FadeInSlide(
            duration: 0.6,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).extension<ExtendColors>()!.color3,
                  shape: BoxShape.circle),
              child: Icon(
                Icons.check_circle,
                color: Colors.lightGreen.shade500,
                size: 80,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
