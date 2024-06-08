
import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/user/send_complain.dart';
import 'package:crafts_men/pages/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as ui;

import '../models/replays_model.dart';

class UserReplays extends StatefulWidget {
  static const routeName = '/userReplays';
  const UserReplays({super.key});

  @override
  State<UserReplays> createState() => _UserReplaysState();
}

class _UserReplaysState extends State<UserReplays> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Replays> replaysList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchReplays();
  }

  @override
  void fetchReplays() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("adminReplays");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Replays p = Replays.fromJson(event.snapshot.value);
      replaysList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Localecontroller controllerlang = Get.find() ;
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text("craftsmen"),
          ),
          drawer: Drawer(
            child: Container(
              padding: EdgeInsets.all(15),
              child: ListView(children: [
                Row(
                  children: [
                    Container(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(60),
                          child: Image.asset("assets/images/logo1.jpg",fit: BoxFit.cover,),
                        )

                    ),
                    Expanded(child: ListTile(
                      title: Text("user"),

                    ))
                  ],
                ),
                ListTile(
                  title: Text("عرض الخدمات"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(UserHome());
                  },
                ),
                ListTile(
                  title: Text("ارسال شكوي"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(SendComplain());
                  },
                ),
                ListTile(
                  title: Text("الردود"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(UserReplays());
                  },
                ),

                ListTile(
                  title: Text("خروج"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(LoginPage());
                  },
                ),

                ListTile(
                  title: Text("ar"),
                  leading: Icon(Icons.g_translate),
                  onTap: (){
                    controllerlang.changlang("ar");
                  },

                ),
                ListTile(
                  title: Text("en"),
                  leading: Icon(Icons.g_translate),
                  onTap: (){
                    controllerlang.changlang("en");
                  },

                ),
              ],),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              right: 10.w,
              left: 10.w,
            ),
            child: FutureBuilder(
              builder: ((context, snapshot) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: replaysList.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (FirebaseAuth.instance.currentUser!.uid ==
                              replaysList[index].userUid) {
                            return Column(
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 10,
                                        right: 15,
                                        left: 15,
                                        bottom: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'الشكوى : ${replaysList[index].userComplain.toString()}',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              'الرد : ${replaysList[index].description.toString()}',
                                              style: TextStyle(fontSize: 17),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints.tightFor(
                                              width: 120.w,
                                              height: 35.h,
                                            ),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.deepPurple,
                                              ),
                                              child: Text('مسح الشكوى',style: TextStyle(color: Colors.white),),
                                              onPressed: () async {
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (BuildContext context) =>
                                                    super.widget,
                                                  ),
                                                );
                                                base
                                                    .child(replaysList[index].id.toString())
                                                    .remove();
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            );
                          } else {
                            return Text('');
                          }
                        },
                      ),
                    ],
                  ),
                );
              }),
              future: null,
            ),
          ),
        ),
      ),
    );

  }

  String getDate(int date) {
    DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(date);

    return DateFormat('MMM dd yyyy').format(dateTime);
  }
}
