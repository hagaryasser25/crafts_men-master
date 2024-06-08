import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Localecontroller extends GetxController{
  void changlang(String codelang){
    Locale locale = Locale(codelang);
    Get.updateLocale(locale);
  }
}