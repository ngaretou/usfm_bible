// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:core';

class ColumnManager with ChangeNotifier {
  bool readyToAddColumn = false;
  bool readyToOpenSearch = false;
  bool timeToRebuildColumns = false;

  void addColumn() {
    readyToAddColumn = true;
    print('addColumn in provider');
    notifyListeners();
    Timer(const Duration(seconds: 1), () => readyToAddColumn = false);
  }

  void openSearch() {
    readyToOpenSearch = true;
    print('openSearch in provider');
    notifyListeners();
    Timer(const Duration(seconds: 1), () => readyToOpenSearch = false);
  }

  void deleteColumnRebuildCall() {
    timeToRebuildColumns = true;
    print('timeToRebuildColumns in provider');
    notifyListeners();
    Timer(const Duration(seconds: 1), () => timeToRebuildColumns = false);
  }
}
