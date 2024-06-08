import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/models/workerreplay_model.dart';
import 'package:crafts_men/pages/models/workers_model.dart';
import 'package:crafts_men/pages/user/make-request.dart';
import 'package:crafts_men/pages/user/send_complain.dart';
import 'package:crafts_men/pages/user/user_replays.dart';
import 'package:crafts_men/pages/user/user_requests.dart';
import 'package:crafts_men/pages/user/worker_details.dart';
import 'package:crafts_men/pages/user/workers.dart';
import 'package:crafts_men/pages/worker/add_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/craftsmen_model.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<WorkerReplays> replaysList = [];
  List<String> keyslist = [];
  List<String> keyslist2 = [];
  List<String> keyslist3 = [];
  final List<Department> departments = [
    Department(name: 'سباكة', imageUrl: 'assets/images/spak.jpg'),
    Department(name: 'ارضيات', imageUrl: 'assets/images/ngar.jpg'),
    Department(name: 'بركية', imageUrl: 'assets/images/heata.jpg'),
    Department(name: 'الموتال', imageUrl: 'assets/images/tbah.jpg'),
    Department(name: ' صيانة اجهزة', imageUrl: 'assets/images/naash.jpg'),
    Department(name: 'صيانة تكييف', imageUrl: 'assets/images/htat.jpg'),
    Department(name: 'ديكورات', imageUrl: 'assets/images/nht.png'),
    Department(name: 'زجاج', imageUrl: 'assets/images/htat.jpg'),
    Department(name: 'ونش رفع', imageUrl: 'assets/images/san.png'),
    Department(name: 'مكافحة حشرات', imageUrl: 'assets/images/san.png'),
    Department(name: 'رخام وجرانيت', imageUrl: 'assets/images/san.png'),
    Department(name: 'رخام وجرانيت', imageUrl: 'assets/images/san.png'),
    Department(name: 'ستورجي', imageUrl: 'assets/images/san.png'),
    Department(name: 'صيانة حمام السباحة', imageUrl: 'assets/images/san.png'),
    Department(name: 'محارة', imageUrl: 'assets/images/san.png'),
  ];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchReplays();
  }

  void fetchReplays() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("workerReplays");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      WorkerReplays p = WorkerReplays.fromJson(event.snapshot.value);
      replaysList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  @override
  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Localecontroller controllerlang = Get.find();
    return Directionality(
      textDirection: TextDirection.rtl,
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
              child: ListView(
                children: [
                  Row(
                    children: [
                      Container(
                          width: 60,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.asset(
                              "assets/images/logo1.jpg",
                              fit: BoxFit.cover,
                            ),
                          )),
                      Expanded(
                          child: ListTile(
                        title: Text("user"),
                      ))
                    ],
                  ),
                  ListTile(
                    title: Text("عرض الخدمات"),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Get.offAll(UserHome());
                    },
                  ),
                  ListTile(
                    title: Text("الطلبات"),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Navigator.pushNamed(context, UserRequest.routeName);
                    },
                  ),
                  ListTile(
                    title: Text("ارسال شكوي"),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Get.offAll(SendComplain());
                    },
                  ),
                  ListTile(
                    title: Text("الردود"),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Get.offAll(UserReplays());
                    },
                  ),
                  ListTile(
                    title: Text("خروج"),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Get.offAll(LoginPage());
                    },
                  ),
                  ListTile(
                    title: Text("ar"),
                    leading: Icon(Icons.g_translate),
                    onTap: () {
                      controllerlang.changlang("ar");
                    },
                  ),
                  ListTile(
                    title: Text("en"),
                    leading: Icon(Icons.g_translate),
                    onTap: () {
                      controllerlang.changlang("en");
                    },
                  ),
                ],
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: 220.h,
                  color: Colors.deepPurple,
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TabBar(
                        controller: tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                        isScrollable: true,
                        tabs: [
                          Tab(
                            child: Text('الشكاوى',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Tab(
                            child: Text('الردود على الطلبات',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ]),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 800.h,
                child: TabBarView(controller: tabController, children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5.w,
                      left: 5.w,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          width: double.infinity,
                          height: 500,
                          child: StaggeredGridView.countBuilder(
                            padding: EdgeInsets.only(
                              top: 20.h,
                              left: 15.w,
                              right: 15.w,
                              bottom: 15.h,
                            ),
                            crossAxisCount: 6,
                            itemCount: departments.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 10.h,
                                    ),
                                    child: CircleAvatar(
                                      radius: 60,
                                      backgroundImage: AssetImage(
                                          departments[index].imageUrl),
                                    ),
                                  ),
                                  Text(
                                    '${departments[index].name.toString()}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  ConstrainedBox(
                                    constraints: BoxConstraints.tightFor(
                                        width: 200.w, height: 40.h),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.deepPurple,
                                      ),
                                      child: Text(
                                        'اصحاب الحرف',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () async {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return WorkersPage(
                                            type: departments[index]
                                                .name
                                                .toString(),
                                          );
                                        }));
                                      },
                                    ),
                                  ),
                                ]),
                              );
                            },
                            staggeredTileBuilder: (int index) =>
                                new StaggeredTile.count(
                                    3, index.isEven ? 3 : 3),
                            mainAxisSpacing: 35.0,
                            crossAxisSpacing: 5.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          'الشكاوى',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, right: 10.w, left: 10.w),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, SendComplain.routeName);
                                    },
                                    child: card(
                                      'ارسال شكوى',
                                    )),
                                SizedBox(
                                  width: 10.w,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, UserReplays.routeName);
                                    },
                                    child: card(
                                      'الردود على الشكاوى',
                                    )),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 15.h,
                      right: 10.w,
                      left: 10.w,
                    ),
                    child: FutureBuilder(
                      builder: ((context, snapshot) {
                        return ListView.builder(
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
                                            bottom: 10),
                                        child: Column(children: [
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                'الطلب : ${replaysList[index].userRequest.toString()}',
                                                style: TextStyle(fontSize: 17),
                                              )),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                'اجمالى السعر : ${replaysList[index].price.toString()}',
                                                style: TextStyle(fontSize: 17),
                                              )),
                                          Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                'الوقت المتاح : ${replaysList[index].adminReplay.toString()}',
                                                style: TextStyle(fontSize: 17),
                                              )),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          ConstrainedBox(
                                            constraints:
                                                BoxConstraints.tightFor(
                                                    width: 120.w, height: 35.h),
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    Colors.deepPurple,
                                              ),
                                              child: Text(
                                                'مسح الرد',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () async {
                                                Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (BuildContext
                                                                context) =>
                                                            super.widget));
                                                base
                                                    .child(replaysList[index]
                                                        .id
                                                        .toString())
                                                    .remove();
                                              },
                                            ),
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  )
                                ],
                              );
                            } else {
                              return Text('');
                            }
                          },
                        );
                      }),
                      future: null,
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset('assets/images/logout.jfif',
                          height: 400.h, width: double.infinity),
                      SizedBox(
                        height: 50.h,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 200.w, height: 40.h),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: Text(
                            'تسجيل الخروج',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('تأكيد'),
                                    content:
                                        Text('هل انت متأكد من تسجيل الخروج'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          FirebaseAuth.instance.signOut();
                                          Navigator.pushNamed(
                                              context, LoginPage.routeName);
                                        },
                                        child: Text('نعم'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('لا'),
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class Department {
  final String name;
  final String imageUrl;

  Department({required this.name, required this.imageUrl});
}

Widget card(String text) {
  return Container(
    child: Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: SizedBox(
        width: 150.w,
        height: 250.h,
        child: Center(
            child: Text(text,
                style: TextStyle(fontSize: 18, color: Colors.deepPurple))),
      ),
    ),
  );
}
