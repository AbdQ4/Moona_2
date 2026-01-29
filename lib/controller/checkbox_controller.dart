import 'package:flutter/material.dart';

class CheckboxController extends ChangeNotifier{
  bool? _isChecked = false;
  bool? get isChecked => _isChecked;

  void check(bool? value){
    _isChecked = value;
    notifyListeners();
  }
}