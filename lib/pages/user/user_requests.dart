import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/admin/workerapprove.dart';
import 'package:crafts_men/pages/admin/workers.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:crafts_men/pages/models/requests_model.dart';
import 'package:crafts_men/pages/models/requests_model.dart';
import 'package:crafts_men/pages/models/requests_model.dart';
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
import '../models/requests_model.dart';
import '../models/requests_model.dart';

class UserRequest extends StatefulWidget {
  static const routeName = '/userRequests';

  @override
  State<UserRequest> createState() => _UserRequestState();
}

class _UserRequestState extends State<UserRequest> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Requests> Request = [];
  List<String> keyslist2 = [];
  void fetchTypes() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("requests");
    base
        .orderByChild("userUid")
        .equalTo(FirebaseAuth.instance.currentUser!.uid)
        .onChildAdded
        .listen((event) {
      print(event.snapshot.value);
      Requests p = Requests.fromJson(event.snapshot.value);
      Request.add(p);
      keyslist2.add(event.snapshot.key.toString());
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
    var descriptionController = TextEditingController();
    Localecontroller controllerlang = Get.find();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text("الطلبات"),
          ),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 800.h,
              child: ListView(children: [
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
                          itemCount: Request.length,
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
                                        '${Request[index].imageUrl.toString()}'),
                                  ),
                                ),
                                Text(
                                  '${Request[index].description.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                Text('${Request[index].date.toString()}'),
                                SizedBox(height: 10.h),
                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 120.w, height: 40.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text(
                                      'تعديل الطلب',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () async {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text("تعديل وصف الطلب"),
                                              content: SizedBox(
                                                height: 65.h,
                                                child: TextField(
                                                  style: TextStyle(),
                                                  controller:
                                                      descriptionController,
                                                  decoration:
                                                      InputDecoration(
                                                    hintText: 'وصف الطلب',
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  15.0),
                                                      borderSide:
                                                          BorderSide(
                                                              width: 1.0,
                                                              color: Colors
                                                                  .grey),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                                  15.0),
                                                      borderSide:
                                                          BorderSide(
                                                              width: 1.0,
                                                              color: Colors
                                                                  .grey),
                                                    ),
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintStyle: TextStyle(),
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () async {
                                                    if (descriptionController
                                                            .text ==
                                                        '') {
                                                      CherryToast.info(
                                                        title: Text(
                                                            'برجاء ادخال الوصف'),
                                                        actionHandler: () {},
                                                      ).show(context);
                                                      return;
                                                    }
                                                    DatabaseReference userRef =
                                                        FirebaseDatabase
                                                            .instance
                                                            .reference()
                                                            .child('requests')
                                                            .child(Request[
                                                                    index]
                                                                .id
                                                                .toString());

                                                    await userRef.update({
                                                      "description":
                                                          descriptionController
                                                              .text
                                                              .trim(),
                                                    });
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext
                                                                    context) =>
                                                                super.widget));
                                                  },
                                                  child: Text("تعديل"),
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
                              ]),
                            );
                          },
                          staggeredTileBuilder: (int index) =>
                              new StaggeredTile.count(3, index.isEven ? 3 : 3),
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
    );
  }
}
