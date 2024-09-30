import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DarkModeProvider with ChangeNotifier {
  bool isDark = false;

  SwitchMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = !isDark;
    prefs.setBool('isDark', isDark);
    notifyListeners();
  }

  getMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDark = prefs.getBool('isDark') ?? false;
    notifyListeners();
  }
}
