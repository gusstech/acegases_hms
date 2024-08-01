// ignore_for_file: unnecessary_new

import 'package:acegases_hms/Utils/contants.dart';
import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/model/app_theme/app_theme_model.dart';
import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utils {
  static List<DisposableProvider> getDisposableProviders(BuildContext context) {
    return [
      Provider.of<PtiModel>(context, listen: false),
      // Provider.of<AppBaseController>(context, listen: false),
      // Provider.of<DriverVehicleModel>(context, listen: false),
      //...other disposable providers
    ];
  }

  static ExtendColors getColor(BuildContext ctx) {
    return Theme.of(ctx).extension<ExtendColors>()!;
  }

  static void disposeAllDisposableProviders(BuildContext context) {
    getDisposableProviders(context).forEach((disposableProvider) {
      disposableProvider.disposeValues();
    });
  }

  static printInfo(Object object) {
    print(object);
  }

  static printWrapped(String text) {
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  static bool isNotEmpty(String? text) {
    return text != null && text.isNotEmpty;
  }

  static String capitalize(String string) {
    if (string.isEmpty) {
      return string;
    }

    return string[0].toUpperCase() + string.substring(1).toLowerCase();
  }

  static String capitalizeEveryWord(String input) {
    return input.split(' ').map((word) {
      if (word.isNotEmpty) {
        return '${word[0].toUpperCase()}${word.substring(1)}';
      } else {
        return word;
      }
    }).join(' ');
  }

  // static confirmationDialog(BuildContext context, String title, String message,
  //     double width, bool isWarning, String buttonText) {
  //   return showDialog(
  //       context: context,
  //       builder: (BuildContext dialogContext) => AlertDialog(
  //             shape: RoundedRectangleBorder(
  //               borderRadius: BorderRadius.circular(16),
  //             ),
  //             actions: [
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 16.0),
  //                 child: Center(
  //                   child: Text(
  //                     title,
  //                     style: AppFont.helvBold(18,
  //                         color: AppColors.appBlack(),
  //                         decoration: TextDecoration.none),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.symmetric(
  //                     vertical: 15.0, horizontal: 12),
  //                 child: Center(
  //                   child: Text(
  //                     message,
  //                     textAlign: TextAlign.center,
  //                     style: AppFont.helvMed(14,
  //                         color: AppColors.appSecondaryBlue(),
  //                         decoration: TextDecoration.none),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 margin: const EdgeInsets.all(9),
  //                 child: Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
  //                   children: [
  //                     GestureDetector(
  //                       onTap: () => Navigator.of(dialogContext).pop(false),
  //                       child: Container(
  //                         height: 50,
  //                         padding: const EdgeInsets.symmetric(vertical: 15),
  //                         width: width * 0.32,
  //                         decoration: BoxDecoration(
  //                             color: AppColors.appWhite(),
  //                             border: Border.all(
  //                               color: AppColors.appPrimaryBlue(),
  //                             ),
  //                             borderRadius: BorderRadius.circular(25)),
  //                         child: Text(
  //                           Utils.getTranslated(
  //                               context, 'alert_dialog_cancel_text'),
  //                           style: AppFont.helvBold(16,
  //                               color: AppColors.appPrimaryBlue(),
  //                               decoration: TextDecoration.none),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     ),
  //                     GestureDetector(
  //                       onTap: () => Navigator.pop(dialogContext, true),
  //                       child: Container(
  //                         height: 50,
  //                         padding: const EdgeInsets.symmetric(vertical: 15),
  //                         width: width * 0.32,
  //                         decoration: BoxDecoration(
  //                             gradient: LinearGradient(
  //                                 begin: Alignment.topCenter,
  //                                 end: Alignment.bottomCenter,
  //                                 stops: const [
  //                                   0,
  //                                   1
  //                                 ],
  //                                 colors: [
  //                                   isWarning
  //                                       ? AppColors.gradientRed1()
  //                                       : AppColors.gradientBlue1(),
  //                                   isWarning
  //                                       ? AppColors.gradientRed2()
  //                                       : AppColors.gradientBlue2(),
  //                                 ]),
  //                             color: AppColors.appRed(),
  //                             borderRadius: BorderRadius.circular(25)),
  //                         child: Text(
  //                           buttonText,
  //                           style: AppFont.helvBold(16,
  //                               color: AppColors.appWhite(),
  //                               decoration: TextDecoration.none),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //                     )
  //                   ],
  //                 ),
  //               )
  //             ],
  //           ));
  // }

  // static void showAlertDialog(
  //     BuildContext context, String title, String message) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) => new CupertinoAlertDialog(
  //       title: new Text(title),
  //       content: new Text(message),
  //       actions: <Widget>[
  //         CupertinoDialogAction(
  //           child: const Text("OK"),
  //           onPressed: () {
  //             Navigator.pop(dialogContext);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static void showSubCatAlertDialog(
  //     BuildContext context, String title, String message) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext dialogContext) => new CupertinoAlertDialog(
  //       title: new Text(title),
  //       content: new Text(message),
  //       actions: <Widget>[
  //         CupertinoDialogAction(
  //           child: const Text("OK"),
  //           onPressed: () {
  //             Navigator.pop(dialogContext);
  //             Navigator.pop(dialogContext);
  //           },
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // static String getTranslated(
  //     BuildContext context, String pageKey, String textKey) {
  //   return MyLocalization.of(context).translate(pageKey, textKey);
  // }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
