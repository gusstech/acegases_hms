import 'package:flutter/material.dart';

enum TripStatus { notstarted, inprogress, completed }

extension CatExtension on TripStatus {
  Color get tripColor {
    return [
      Colors.red.shade500,
      Colors.green.shade500,
      Colors.yellow.shade700,
    ][index];
  }

  String get tripValue {
    return [
      "0000",
      "0100",
      "0108",
    ][index];
  }

  String get tripDisplayText {
    return [
      "NOT STARTED",
      "IN PROGRESS",
      "COMPLETED",
    ][index];
  }
}
