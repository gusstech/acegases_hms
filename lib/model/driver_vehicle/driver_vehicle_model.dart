import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:flutter/material.dart';

enum VehicleStatus { Poor, Average, Good }

extension CatExtension on VehicleStatus {
  Color get statusColor {
    return [
      Colors.red.shade500,
      Colors.orange.shade500,
      Colors.green.shade500,
    ][index];
  }

  String get statusTodoText {
    return [
      "PLEASE CHECK YOUR VEHICLE",
      "BE CAUTIOUS",
      "GOOD TO GO",
    ][index];
  }
}

class VehicleModel {
  String? id;
  String? no;
  String? status;
  String? mdtuid;

  VehicleModel({
    this.id,
    this.no,
    this.status,
    this.mdtuid,
  });

  factory VehicleModel.fromJson(Map<String, dynamic> json) => VehicleModel(
        id: json["ID"],
        no: json["NO"],
        status: json["Status"],
        mdtuid: json["MDTUID"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "NO": no,
        "Status": status,
        "MDTUID": mdtuid,
      };

  @override
  String toString() => 'id : $id, name:$no';
}
