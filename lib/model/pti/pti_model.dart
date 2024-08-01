import 'dart:convert';
import 'package:acegases_hms/Utils/disposable_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:collection/collection.dart';

enum PTISliderStatus { none, poor, average, good }

extension CatExtension on PTISliderStatus {
  Color get ptiStatusColor {
    return [
      Colors.blueAccent.shade400,
      Colors.blueAccent.shade400,
      Colors.redAccent.shade200,
      Colors.blueAccent.shade400,
    ][index];
  }

  String get ptiStatusDisplayName {
    return ["N/A", "Poor", "Average", "Good"][index];
  }

  String get ptiCardActionText {
    return [
      "Action Required",
      "Done",
      "Done",
      // "Beaware of your vehicle",
      // "Please check of your vehicle",
      'Done'
    ][index];
  }

  IconData get ptiCardIcon {
    return [
      CupertinoIcons.exclamationmark_triangle_fill,
      // CupertinoIcons.exclamationmark_triangle_fill,
      // Icons.cancel_outlined,
      Icons.check_circle_outline_outlined, Icons.check_circle_outline_outlined,
      Icons.check_circle_outline_outlined,
    ][index];
  }

  Color get ptiCardIconColor {
    return [
      Colors.yellow.shade700,
      // Colors.yellow.shade700,
      // Colors.red.shade500,
      Colors.green.shade700, Colors.green.shade700, Colors.green.shade700,
    ][index];
  }

  Color get ptiCardColor {
    return [
      Colors.yellowAccent.shade100,
      // Colors.yellowAccent.shade100,
      // Colors.red.shade100,
      Colors.lightGreen.shade300, Colors.lightGreen.shade300,
      Colors.lightGreen.shade300,
    ][index];
  }
}

class PtiModel extends DisposableProvider {
  List<Category>? _checklistData;
  bool _ptiCheckStatus = false;

  PtiModel() {
    // Load initial data from asset
    // _loadChecklistData();
  }

  // Factory constructor for creating an instance and loading data
  factory PtiModel.instance() {
    return PtiModel();
  }

  bool get ptiCheckStatus => _ptiCheckStatus;

  set ptiCheckStatus(bool t) => _ptiCheckStatus = t;
  // Getter for checklist data
  List<Category> get checklistData => _checklistData ?? [];

  // Setter for checklist data
  set checklistData(List<Category> newData) {
    _checklistData = newData;
    notifyListeners(); // Notify listeners when data changes
  }

  void setStatus(
      Category mainCat, Subcategory data, PTISliderStatus newStatus) {
    int cdata = _checklistData!.indexOf(mainCat);
    int sdata = _checklistData![cdata].subcategories.indexOf(data);

    _checklistData![cdata].subcategories[sdata].status = newStatus;

    notifyListeners();
  }

  int cardType(List<Subcategory> data) {
    if (data.any((element) => element.status == PTISliderStatus.none)) {
      return 0;
    } else {
      if (!data.any((element) => element.status == PTISliderStatus.none) &&
          data.any((element) => element.status == PTISliderStatus.poor)) {
        return 2;
      } else if (!data
              .any((element) => element.status == PTISliderStatus.none) &&
          data.any((element) => element.status == PTISliderStatus.average)) {
        return 1;
      } else {
        return 3;
      }
    }
  }

  String actionText(List<Subcategory> data) {
    if (data.any((element) => element.status == PTISliderStatus.none)) {
      return "Action Required";
    } else {
      if (!data.any((element) => element.status == PTISliderStatus.none) &&
          data.any((element) => element.status == PTISliderStatus.average)) {
        return "Beaware of your vehicle";
      } else if (!data
              .any((element) => element.status == PTISliderStatus.none) &&
          data.any((element) => element.status == PTISliderStatus.poor)) {
        return "Please check of your vehicle";
      } else {
        return "";
      }
    }
  }

  Icon statusIcon(List<Subcategory> data) {
    if (data.any((element) => element.status == PTISliderStatus.none)) {
      return Icon(
        CupertinoIcons.exclamationmark,
        color: Colors.yellow.shade700.withOpacity(0.5),
      );
    } else {
      if (!data.any((element) => element.status == PTISliderStatus.none) &&
          data.any((element) => element.status == PTISliderStatus.average)) {
        return Icon(
          CupertinoIcons.exclamationmark,
          color: Colors.yellow.shade700.withOpacity(0.5),
        );
      } else if (!data
              .any((element) => element.status == PTISliderStatus.none) &&
          data.any((element) => element.status == PTISliderStatus.poor)) {
        return Icon(
          Icons.cancel_outlined,
          color: Colors.red.shade700.withOpacity(0.5),
        );
      } else {
        return Icon(
          Icons.check_circle_outline_outlined,
          color: Colors.green.shade700.withOpacity(0.5),
        );
      }
    }
  }

  @override
  void disposeValues() {
    _checklistData = null;
    _ptiCheckStatus = false;
    notifyListeners();
  }
}

// model.dart
class BasePTIElement {
  String category;
  String subCategory;
  int type;

  BasePTIElement({
    required this.category,
    required this.subCategory,
    required this.type,
  });

  factory BasePTIElement.fromJson(Map<String, dynamic> json) => BasePTIElement(
        category: json["Category"],
        subCategory: json["SubCategory"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Category": category,
        "SubCategory": subCategory,
        "Type": type,
      };
}

class ChecklistData {
  final List<Category> categories;

  ChecklistData({required this.categories});

  factory ChecklistData.fromJson(Map<String, dynamic> json) {
    // print((json['d']['d'] as List));

    Map data = groupBy(json['d']['d'] as List, (e) {
      return e["Category"]!;
    });

    List<Category> categories = [];
    data.forEach((categoryName, subcategories) {
      List<Subcategory> parsedSubcategories = [];
      for (var subcategory in subcategories) {
        parsedSubcategories.add(Subcategory.fromJson(subcategory));
      }
      categories.add(
          Category(name: categoryName, subcategories: parsedSubcategories));
    });

    // data.map((categoryJson) => Category.fromJson(categoryJson)).toList();
    return ChecklistData(categories: categories);
  }
}

class Category {
  final String name;
  final List<Subcategory> subcategories;

  Category({required this.name, required this.subcategories});
}

class Subcategory {
  final String name;
  PTISliderStatus status;

  Subcategory({required this.name, required this.status});

  factory Subcategory.fromJson(Map<String, dynamic> json) {
    String name = json['SubCategory'];
    return Subcategory(
        name: name, status: PTISliderStatus.none); // Default status to 'Poor'
  }

  // Getter and Setter for status
  PTISliderStatus get getStatus => status;

  set setStatus(PTISliderStatus newStatus) {
    status = newStatus;
  }
}
