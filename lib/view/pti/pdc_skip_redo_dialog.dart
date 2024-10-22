import 'package:acegases_hms/Utils/custom_animation_fadeIn.dart';
import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PdcSkipRedoDialog extends StatelessWidget {
  const PdcSkipRedoDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.22 + 40,
            child: Container(
              width: 280,
              padding: const EdgeInsets.fromLTRB(16, 50, 16, 20),
              decoration: BoxDecoration(
                  color: Theme.of(context).extension<ExtendColors>()!.color3,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    "Would you like to submit PDC?",
                    style: TextStyle(
                      color:
                          Theme.of(context).extension<ExtendColors>()!.color2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () => Navigator.of(context).pop(false),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                                // color: Colors.red.shade400,
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              "CANCEL",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        InkWell(
                          onTap: () => Navigator.of(context).pop(true),
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: 6, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Colors.red.shade500,
                                borderRadius: BorderRadius.circular(6)),
                            child: Text(
                              "CONFIRM",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.sizeOf(context).height * 0.22,
            child: FadeInSlide(
              duration: 0.6,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).extension<ExtendColors>()!.color3,
                    shape: BoxShape.circle),
                child: Icon(
                  CustomAlertType.alert.iconData,
                  color: Colors.red.shade400,
                  size: 80,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
