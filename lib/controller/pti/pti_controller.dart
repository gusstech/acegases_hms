import 'dart:convert';

import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PtiController {
  PtiController();

  Future<void> loadChecklistData(BuildContext context) async {
    PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);
    String data = await rootBundle.loadString('assets/images/d.json');
    Map<String, dynamic> jsonData = json.decode(data);
    viewModel.checklistData = ChecklistData.fromJson(jsonData).categories;
    print(viewModel.checklistData);
    // Notify listeners after data is loaded
  }
  // void getter(BuildContext context) {
  //   PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);
  //   //TODO Add code here for getter
  //   viewModel.getter();
  // }

  // void setter(BuildContext context) {
  //   PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);
  //   //TODO Add code here for setter
  //   viewModel.setter();
  // }

  // void update(BuildContext context) {
  //   PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);
  //   //TODO Add code here for update
  //   viewModel.update();
  // }

  // void remove(BuildContext context) {
  //   PtiModel viewModel = Provider.of<PtiModel>(context, listen: false);
  //   //TODO Add code here for remove
  //   viewModel.remove();
  // }
}
