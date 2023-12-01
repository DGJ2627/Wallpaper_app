
import 'dart:io';

import 'package:flutter/cupertino.dart';

import '../Global/Global_variable.dart';

class Plat_form_convertor extends ChangeNotifier {

  File? img;
  bool profile = false;

  void change_img_camera(File n) async {
    imgfile = n;
    notifyListeners();
  }
}