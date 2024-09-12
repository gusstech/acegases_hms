import 'package:acegases_hms/Utils/custom_animation_fadeIn.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:acegases_hms/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum CustomAlertType { success, alert, error }

extension CatExtension on CustomAlertType {
  IconData get iconData {
    return [
      Icons.check_circle,
      CupertinoIcons.exclamationmark_circle_fill,
      Icons.cancel
    ][index];
  }

  Color get dialogColor {
    return [
      Colors.lightGreen.shade500,
      Colors.yellow.shade700,
      Colors.red.shade600
    ][index];
  }

  String get dialogTitle {
    return [
      "Success",
      "Alert",
      "Error",
    ][index];
  }
}

class CustomAlertDialog extends StatelessWidget {
  final CustomAlertType type;
  final String description;
  final bool? cancelBtn;
  final bool? isLogout;
  final String? popButtonText;
  final Function()? function;
  const CustomAlertDialog(
      {super.key,
      required this.type,
      required this.description,
      this.popButtonText,
      this.cancelBtn,
      this.function,
      this.isLogout});

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
                  color: Theme.of(context).extension<ExtendColors>()?.color3,
                  borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    type.dialogTitle,
                    style: TextStyle(
                      color:
                          Theme.of(context).extension<ExtendColors>()!.color2,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color:
                          Theme.of(context).extension<ExtendColors>()!.color2,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () =>
                              Navigator.pop(context, isLogout ?? false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  width: 3,
                                  color: isLogout == true
                                      ? Colors.red.shade500
                                      : type.dialogColor,
                                ),
                                borderRadius: BorderRadius.circular(8)),
                            child: Text(
                              popButtonText ?? "Logout",
                              style: TextStyle(
                                  color: isLogout == true
                                      ? Colors.red.shade500
                                      : type.dialogColor,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                        SizedBox(width: cancelBtn == true ? 12 : 0),
                        cancelBtn ?? false
                            ? InkWell(
                                onTap: () => Navigator.pop(context, false),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 3,
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              )
                            : const SizedBox(),
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
                  type.iconData,
                  color: type.dialogColor,
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
