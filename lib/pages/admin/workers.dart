import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/admin/orders.dart';
import 'package:crafts_men/pages/admin/workerapprove.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/user/worker_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/craftsmen_model.dart';

class WorkersPage extends StatefulWidget {
  String type;
   WorkersPage({required this.type});

  @override
  State<WorkersPage> createState() => _WorkersState();
}

class _WorkersState extends State<WorkersPage> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<CraftsMenV> menList2 = [];
  List<String> keyslist2 = [];

  @override
  void fetchTypes() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("craftsMenapproved").child(widget.type);
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      CraftsMenV p = CraftsMenV.fromJson(event.snapshot.value);
      menList2.add(p);
      keyslist2.add(event.snapshot.key.toString());
      print(keyslist2);
      setState(() {});
    });
  }

  @override
  void initState() {

    super.initState();
    fetchTypes();
  }
  @override
  Widget build(BuildContext context) {
    Localecontroller controllerlang = Get.find() ;
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
                      title: Text("admin"),

                    ))
                  ],
                ),
                ListTile(
                  title: Text("طلبات العملاء"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(orders());
                  },
                ),
                ListTile(
                  title: Text("حرفي موافق علية"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(AdminApprove());
                  },
                ),
                ListTile(
                  title: Text("الحرفيين"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(WorkersPage(type: 'departments[index].name.toString()',));
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

          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 800.h,
              child: ListView
                (
                  children: [
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
                          itemCount: menList2.length,
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
                                    radius: 37,
                                    backgroundImage: NetworkImage(
                                        '${menList2[index].imageUrl.toString()}'),
                                  ),
                                ),
                                Text(
                                  '${menList2[index].name.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text(
                                    '${menList2[index].phoneNumber.toString()}'),
                                SizedBox(
                                  height: 5.h,
                                ),

                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 180.w, height: 40.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text('حذف الحرفى',style: TextStyle(color: Colors.white),),
                                    onPressed: () async {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext
                                              context) =>
                                              super.widget));
                                      database.reference().child("craftsMenapproved").child(widget.type).child(menList2[index].id .toString())
                                          .remove();
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

              ]),
            ),
          ),
        ),
      ),
    );  }
}
