import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.dark;
  void changeTheme(ThemeMode newTheme){
    if(newTheme == appTheme){
      return;
    }
    appTheme = newTheme;
    notifyListeners();
  }
  bool isDark(){
    return appTheme == ThemeMode.dark;
  }
}