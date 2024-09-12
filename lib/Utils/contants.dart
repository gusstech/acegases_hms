import 'package:acegases_hms/model/enum/jobstatus_enum.dart';
import 'package:acegases_hms/model/enum/tripstatus_enum.dart';

class Constants {
  static const bool isDebug = false;
  static const String assetImages = "assets/images/";

  static Map<String, JobStatus> jobStatus = {
    "0000": JobStatus.notstarted,
    "0100": JobStatus.started,
    "0104": JobStatus.exitorigin,
    "0105": JobStatus.inqdestination,
    "0108": JobStatus.completed,
    // "0112": JobStatus.abort,
  };
  static Map<String, TripStatus> tripJob = {
    "0000": TripStatus.notstarted,
    "0100": TripStatus.inprogress,

    "0108": TripStatus.completed,
    // "ABORT": JobStatus.abort,
  };
  static Map<String, TripStatus> tripStatus = {
    "0000": TripStatus.notstarted,
    "0100": TripStatus.inprogress,
    "0108": TripStatus.completed,
  };
}
