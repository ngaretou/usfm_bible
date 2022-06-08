// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:core';

class AddColumn with ChangeNotifier {
  bool readyToAddColumn = false;

  void addColumn() {
    readyToAddColumn = true;
    print('addColumn in provider');
    notifyListeners();
    Timer(const Duration(seconds: 1), () => readyToAddColumn = false);
  }
}
