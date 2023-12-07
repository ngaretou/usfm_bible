import 'dart:async';
import 'package:flutter/foundation.dart';
import 'user_prefs.dart';

class ColumnManager with ChangeNotifier {
  bool readyToAddColumn = false;
  bool readyToToggleSearch = false;
  bool timeToRebuildColumns = false;

  void addColumn() {
    readyToAddColumn = true;
    // // print('addColumn in provider');
    notifyListeners();
    Timer(const Duration(seconds: 1), () => readyToAddColumn = false);
  }

  void toggleSearch() {
    readyToToggleSearch = true;
    // // print('openSearch in provider');
    notifyListeners();
    Timer(const Duration(seconds: 1), () => readyToToggleSearch = false);
  }

  void deleteColumnRebuildCall() {
    timeToRebuildColumns = true;
    // // print('timeToRebuildColumns in provider');
    notifyListeners();
    Timer(const Duration(seconds: 1), () => timeToRebuildColumns = false);
  }
}

// –––––––––––––––––––––––––––––––––––––––
class ScrollGroup with ChangeNotifier {
  BibleReference? scrollGroupBibleReference;
  Key? activeColumnKey;

  BibleReference? get getScrollGroupRef {
    return scrollGroupBibleReference;
  }

  set setScrollGroupRef(BibleReference ref) {
    void setScrollGroup() {
      scrollGroupBibleReference = ref;
      // // print('setScrollGroupRef in provider');
      // // print('${ref.bookID} ${ref.chapter} ${ref.verse}');
      notifyListeners();
    }

    if (scrollGroupBibleReference == null) {
      setScrollGroup();
    } else {
      bool same = (scrollGroupBibleReference!.bookID == ref.bookID &&
          scrollGroupBibleReference!.chapter == ref.chapter &&
          scrollGroupBibleReference!.verse == ref.verse);

      if (!same) {
        setScrollGroup();
      }
    }
  }

  Key? get getActiveColumnKey {
    return activeColumnKey;
  }

  set setActiveColumnKey(Key? key) {
    // // print('set active col key to $key');
    activeColumnKey = key;
    Timer(const Duration(milliseconds: 1500), () {
      // // print('returning active key to null');
      activeColumnKey = null;
    });
  }
}
