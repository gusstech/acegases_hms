// import model

import 'package:acegases_hms/Utils/custom_dialog.dart';
import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:acegases_hms/appcache.dart/appcache.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin AppRemoteConfig {
  checkConfig(BuildContext context) {
    bool update = _compareVersions(
        "${Appcache.packageInfo.version}.${Appcache.packageInfo.buildNumber}",
        Appcache.liveVersion);
    Appcache.liveVersion = "";
    if (update) {
      {
        return showDialog(
            context: context,
            // barrierColor: Colors.transparent,
            barrierDismissible: false,
            builder: (context) => CustomAlertDialog(
                  type: CustomAlertType.alert,
                  description:
                      "There is a new update.\nPlease update before proceed",
                  popButtonText: "Update Now",
                  function: () => _launchAppStore(context),
                ));
      }
    }
  }

  void _launchAppStore(BuildContext context) async {
    String appStoreUrl = "";
    if (Theme.of(context).platform == TargetPlatform.android) {
      appStoreUrl =
          "https://play.google.com/store/apps/details?id=com.gis.acegaseshms";
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      appStoreUrl = "https://apps.apple.com/app/ace-gases-hms/id6673918327";
    }

    if (await canLaunch(appStoreUrl)) {
      await launch(appStoreUrl);
    } else {
      showDialog(
          context: context,
          // barrierColor: Colors.transparent,
          barrierDismissible: false,
          builder: (context) => CustomAlertDialog(
                type: CustomAlertType.error,
                description: "\nStore not found",
                popButtonText: "CANCEL",
              ));
      throw "Could not launch $appStoreUrl";
    }
  }

  bool _compareVersions(String currentVersion, String remoteVersion) {
    if (remoteVersion.isEmpty) {
      return false; // No update available if remote version is empty
    }
    // Split the versions into parts (major, minor, patch, build)
    List<String> currentParts = currentVersion.split('.');
    List<String> remoteParts = remoteVersion.split('.');

    // Determine the number of parts to compare (handle different version formats)
    int length = currentParts.length > remoteParts.length
        ? currentParts.length
        : remoteParts.length;

    for (int i = 0; i < length; i++) {
      // Use 0 if one of the versions has fewer parts (to handle cases like 1.0 vs 1.0.1)
      int currentPart =
          i < currentParts.length ? int.parse(currentParts[i]) : 0;
      int remotePart = i < remoteParts.length ? int.parse(remoteParts[i]) : 0;

      if (currentPart < remotePart) {
        return true; // Update is available
      } else if (currentPart > remotePart) {
        return false; // No update needed
      }
    }

    return false; // Versions are the same
  }
}
