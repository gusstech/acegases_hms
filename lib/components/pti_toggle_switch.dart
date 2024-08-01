import 'package:acegases_hms/controller/pti/pti_controller.dart';
import 'package:acegases_hms/model/pti/pti_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomPTISlider extends StatefulWidget {
  final double height;
  final double width;
  final Category mainCat;
  final Subcategory subCat;
  const CustomPTISlider(
      {super.key,
      required this.height,
      required this.width,
      required this.mainCat,
      required this.subCat});
  @override
  _CustomPTISliderState createState() => _CustomPTISliderState();
}

class _CustomPTISliderState extends State<CustomPTISlider>
    with TickerProviderStateMixin {
  double? _value; // Initially set to average
  late int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = widget.subCat.status.index;
    if (_selectedIndex != 0) {
      _value = _getValue(_selectedIndex);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PtiController viewController = PtiController();
    return Consumer<PtiModel>(builder: (context, viewModel, child) {
      return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 3,
                spreadRadius: 2,
                offset: Offset(2, 2),
              )
            ]),
        width: widget.width,
        height: widget.height,
        child: Stack(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      _value = .0;
                      // widget.data.setStatus = PTISliderStatus.poor;

                      viewModel.setStatus(
                          widget.mainCat, widget.subCat, PTISliderStatus.poor);
                      _selectedIndex = _getSelectedIndex(_value)!;
                    });
                  },
                  child: Container(
                    width: widget.width / 3,
                    height: widget.height,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(20)),
                    ),
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    child: FittedBox(
                      child: Text(
                        _getTextForValue(0) ?? '',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      _value = .5;
                      viewModel.setStatus(widget.mainCat, widget.subCat,
                          PTISliderStatus.average);
                      _selectedIndex = _getSelectedIndex(_value)!;
                    });
                  },
                  child: Container(
                    width: widget.width / 3,
                    height: widget.height,
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.symmetric(
                          vertical: BorderSide(color: Colors.grey.shade200)),
                    ),
                    child: FittedBox(
                      child: Text(
                        _getTextForValue(.5) ?? '',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTapDown: (details) {
                    setState(() {
                      _value = 1;

                      _selectedIndex = _getSelectedIndex(_value)!;
                      viewModel.setStatus(
                          widget.mainCat, widget.subCat, PTISliderStatus.good);
                    });
                  },
                  child: Container(
                    width: widget.width / 3,
                    height: widget.height,
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.horizontal(right: Radius.circular(20)),
                      color: Colors.white,
                    ),
                    child: FittedBox(
                      child: Text(
                        _getTextForValue(1) ?? '',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            _value != null
                ? AnimatedBuilder(
                    animation: AnimationController(
                      vsync: this,
                      value: _value,
                      duration: Duration(milliseconds: 300),
                    ),
                    builder: (BuildContext context, Widget? child) {
                      return AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        left: _value! * (widget.width * 2 / 3),
                        child: Container(
                          width: widget.width / 3,
                          height: widget.height,
                          padding: EdgeInsets.all(6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: _getRadiusType(_value ?? 0),
                            color: _getColorForValue(_value),
                          ),
                          child: FittedBox(
                            child: Text(
                              _getTextForValue(_value) ?? '',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : SizedBox.shrink(),
            //   AnimatedPositioned(
            //     duration: Duration(milliseconds: 300),
            //     curve: Curves.easeInOut,
            //     left: _value * 140,
            //     child: Container(
            //       width: 70,
            //       height: 30,
            //       decoration: BoxDecoration(
            //         borderRadius: _getRadiusType(_value),
            //         color: Colors.blue,
            //       ),
            //       child: Center(
            //         child: Text(
            //           _getTextForValue(_value),
            //           style: TextStyle(color: Colors.white),
            //         ),
            //       ),
            //     ),
            //   ),
            //
          ],
        ),
      );
    });
  }
}

BorderRadius? _getRadiusType(double? value) {
  if (value == null) return null;
  if (value < 0.333) {
    return BorderRadius.horizontal(left: Radius.circular(20));
  } else if (value < 0.666) {
    return null;
  } else {
    return BorderRadius.horizontal(right: Radius.circular(20));
  }
}

int? _getSelectedIndex(double? value) {
  if (value == null) return null;
  if (value < 0.333) {
    return 0;
  } else if (value < 0.666) {
    return 1;
  } else {
    return 2;
  }
}

double? _getValue(int? value) {
  if (value == 1) {
    return 0;
  } else if (value == 2) {
    return 0.5;
  } else if (value == 3) {
    return 1;
  }
  return null;
}

Color? _getColorForValue(double? value) {
  if (value == null) return null;
  if (value < 0.333) {
    return Colors.red; // Change color based on value range
  } else if (value < 0.666) {
    return Colors.orange; // Change color based on value range
  } else {
    return Colors.green; // Change color based on value range
  }
}

String? _getTextForValue(double? value) {
  if (value == null) return null;
  if (value < 0.333) {
    return 'Poor';
  } else if (value < 0.666) {
    return 'Average';
  } else {
    return 'Good';
  }
}
