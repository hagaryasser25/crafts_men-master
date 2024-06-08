import 'package:crafts_men/locale/locale.dart';
import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/user/user_requests.dart';
import 'package:crafts_men/pages/worker/add_craftsmen.dart';
import 'package:crafts_men/pages/admin/admin_home.dart';
import 'package:crafts_men/pages/auth/admin_login.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/auth/signup_screen.dart';
import 'package:crafts_men/pages/auth/worker_login.dart';
import 'package:crafts_men/pages/user/send_complain.dart';
import 'package:crafts_men/pages/user/user_home.dart';
import 'package:crafts_men/pages/user/user_replays.dart';
import 'package:crafts_men/pages/worker/add_service.dart';
import 'package:crafts_men/pages/worker/send_complain.dart';
import 'package:crafts_men/pages/worker/send_replay.dart';
import 'package:crafts_men/pages/worker/worker2_home.dart';
import 'package:crafts_men/pages/worker/worker_home.dart';
import 'package:crafts_men/pages/worker/worker_request.dart';
import 'package:crafts_men/pages/worker/workers_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(Localecontroller());
    return GetMaterialApp(
      locale: Get.deviceLocale,
      translations: MyLocale(),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : FirebaseAuth.instance.currentUser!.displayName == 'صاحب حرفة'
                  ? const WorkerHome()
                  : UserHome(),
      routes: {
        SignupPage.routeName: (ctx) => SignupPage(),
        LoginPage.routeName: (ctx) => LoginPage(),
        UserHome.routeName: (ctx) => UserHome(),
        AdminHome.routeName: (ctx) => AdminHome(),
        WorkerHome.routeName: (ctx) => WorkerHome(),
        AddCraftsMen.routeName: (ctx) => AddCraftsMen(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        WorkerLogin.routeName: (ctx) => WorkerLogin(),
        SendComplain.routeName: (ctx) => SendComplain(),
        UserReplays.routeName: (ctx) => UserReplays(),
        WorkersRequest.routeName: (ctx) => WorkersRequest(),
        WorkerComplain.routeName: (ctx) => WorkerComplain(),
        WorkersList.routeName: (ctx) => WorkersList(),
        UserRequest.routeName: (ctx) => UserRequest(),
      },
    );
  }
}
