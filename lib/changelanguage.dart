import 'package:flutter/material.dart';

class ChangeLaanguage with ChangeNotifier {
  Locale _currentlocale = new Locale("en");
  Locale get currentlocale => _currentlocale;
  changelocale(String _locale) {
    this.._currentlocale = new Locale(_locale);
    notifyListeners();
  }
}
