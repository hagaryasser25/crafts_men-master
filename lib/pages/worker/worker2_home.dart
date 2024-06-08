import 'package:cherry_toast/cherry_toast.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/models/mens_model.dart';
import 'package:crafts_men/pages/models/requests_model.dart';
import 'package:crafts_men/pages/models/workers_model.dart';
import 'package:crafts_men/pages/worker/add_service.dart';
import 'package:crafts_men/pages/worker/send_complain.dart';
import 'package:crafts_men/pages/worker/send_replay.dart';
import 'package:crafts_men/pages/worker/update_profile.dart';
import 'package:crafts_men/pages/worker/worker_request.dart';
import 'package:crafts_men/pages/worker/workers_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../models/craftsmen_model.dart';

class WorkerHome extends StatefulWidget {
  static const routeName = '/workerHome';
  const WorkerHome({super.key});

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome>
    with SingleTickerProviderStateMixin {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<String> keyslist3 = [];

  Mens? currentUser;

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  getData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("craftsMen")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Mens.fromSnapshot(snapshot);
      print(currentUser?.email);
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Center(
                  child: Text('الصفحة الرئيسية',
                      style: TextStyle(
                        color: Colors.white,
                      )))),
          drawer: Container(
              width: 270.w,
              child: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      height: 200.h,
                      child: DrawerHeader(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: [.01, .25],
                            colors: [
                              Color.fromARGB(255, 151, 111, 220),
                              Colors.deepPurple,
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/logo.jpg'),
                              ),
                            ),
                            SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Theme.of(context).splashColor,
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, WorkersList.routeName);
                              },
                              title: Text('سابقة الاعمال'),
                              leading: Icon(Icons.list),
                            ))),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Theme.of(context).splashColor,
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, WorkersRequest.routeName);
                              },
                              title: Text("الطلبات"),
                              leading: Icon(Icons.request_page),
                            ))),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Theme.of(context).splashColor,
                            child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, WorkerComplain.routeName);
                              },
                              title: Text('ارسال شكوى'),
                              leading: Icon(Icons.ads_click),
                            ))),
                    Divider(
                      thickness: 0.8,
                      color: Colors.grey,
                    ),
                    Material(
                        color: Colors.transparent,
                        child: InkWell(
                            splashColor: Theme.of(context).splashColor,
                            child: ListTile(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('تأكيد'),
                                        content: Text(
                                            'هل انت متأكد من تسجيل الخروج'),
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
                              title: Text('تسجيل الخروج'),
                              leading: Icon(Icons.exit_to_app_rounded),
                            )))
                  ],
                ),
              )),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 30.h,
                ),
                ConditionalBuilder(
                  condition: currentUser != null,
                  builder: (context) => Container(
                      child: Center(
                    child: Column(children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage:
                            NetworkImage('${currentUser?.imageUrl}'),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'الأسم : ${currentUser?.fullName}',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'العنوان: ${currentUser?.address}',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        'رقم الهاتف: ${currentUser?.phoneNumber}',
                        style: TextStyle(fontSize: 17),
                      ),
                      RatingBar.builder(
                        initialRating: currentUser!.rating!.toDouble(),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 20,
                        itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (double value) {},
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints.tightFor(width: 190.w, height: 40.h),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: Text(
                            'تعديل الملف',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return UpdateProfile(
                                name: '${currentUser?.fullName}',
                                address: '${currentUser?.address}',
                                phoneNumber: '${currentUser?.phoneNumber}',
                                url: '${currentUser?.imageUrl}',
                                uid: FirebaseAuth.instance.currentUser!.uid,
                              );
                            }));
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: 200.h,
                          left: 10.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return AddService(
                                    keyslist: keyslist3,
                                  );
                                }));
                              },
                              child: ClipPath(
                                clipper: StarClipper(10),
                                child: Container(
                                  color: Colors.deepPurple,
                                  height: 80,
                                  width: 80,
                                  child: Center(
                                      child:
                                          Icon(Icons.add, color: Colors.white)),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, WorkersList.routeName);
                              },
                              child: ClipPath(
                                clipper: StarClipper(10),
                                child: Container(
                                  color: Colors.deepPurple,
                                  height: 80,
                                  width: 80,
                                  child: Center(
                                      child: Icon(Icons.delete,
                                          color: Colors.white)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  )),
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
