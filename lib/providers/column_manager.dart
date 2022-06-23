// ignore_for_file: avoid_print

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'user_prefs.dart';

class ColumnManager with ChangeNotifier {
  bool readyToAddColumn = false;
  bool readyToOpenSearch = false;
  bool timeToRebuildColumns = false;
  BibleReference? scrollGroupBibleReference;

  BibleReference? get getScrollGroupRef {
    return scrollGroupBibleReference;
  }

  set setScrollGroupRef(BibleReference ref) {
    scrollGroupBibleReference = ref;
    print('setScrollGroupRef in provider');
    print('${ref.bookID} ${ref.chapter} ${ref.verse}');
  }

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
