import 'package:flutter/cupertino.dart';

abstract class DisposableProvider with ChangeNotifier {
  void disposeValues();
}
