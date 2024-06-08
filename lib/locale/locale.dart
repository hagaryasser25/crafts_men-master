import 'package:get/get_navigation/get_navigation.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "ar": {"1": "الصفحة الرئيسية",
          "2": "التحويل الى الانجليزي",
          "3": "التحويل الى العربية",
          "4" : "طلبات العملاء",
          "5" : "حرفي غير موافق علية",
          "6" : "خروج",
          "7" : "موافقة",
          "8" : "رفض",
          "9" : "كلمة السر",
          "10" : "الهاتف",
          "11" : "اصحاب الحرف",


        },
        "en": {"1": "Home Page","2": "Change To English","3": "Change To Arbic"},
      };
}
