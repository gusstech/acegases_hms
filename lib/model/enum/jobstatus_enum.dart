import 'dart:ui';

import 'package:flutter/material.dart';

enum JobStatus {
  notstarted,
  started,
  exitorigin,
  inqdestination,
  completed,
  // abort
}

extension CatExtension on JobStatus {
  Color get jobColor {
    return [
      Colors.red.shade500,
      Colors.blue.shade600,
      Colors.blue.shade600,
      Colors.green.shade600,
      Colors.yellow.shade800,
      Colors.grey.shade100,
    ][index];
  }

  String get jobValue {
    return [
      "0000",
      "0100",
      "0104",
      "0105",
      "0108",
      "0112",
    ][index];
  }

  int get jobPriority {
    return [
      1,
      2,
      3,
      4,
      7,
      5,
    ][index];
  }

  String get tripDisplayText {
    return [
      "NOT STARTED",
      "STARTED",
      "EXIT ORIGIN",
      "INQ DESTINATION",
      "COMPLETED",
      // "ABORT",
    ][index];
  }
}
