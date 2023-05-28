import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {

  final _key="isDarkMode";
  GetStorage _box=GetStorage();

  bool loadthemfromBox()=>_box.read<bool>(_key)??false;
  _savethemetoBox(bool isDark)=> _box.write(_key, isDark);

  ThemeMode get theme=>loadthemfromBox()?ThemeMode.dark:ThemeMode.light;

   switchTheme(){

    Get.changeThemeMode(loadthemfromBox()?ThemeMode.light:ThemeMode.dark);
    _savethemetoBox(!loadthemfromBox());
  }
}
