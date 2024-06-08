import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/user/send_complain.dart';
import 'package:crafts_men/pages/user/user_home.dart';
import 'package:crafts_men/pages/user/user_replays.dart';
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
  String filterGovernorate = ''; // Initialize filterGovernorate

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
    Localecontroller controllerlang = Get.find();
    List<CraftsMenV> filteredCraftsmen = menList2.where((craftsman) {
      return craftsman.Governorate != null &&
          craftsman.Governorate!.contains(filterGovernorate);
    }).toList();

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
            child: Container(
              width: double.infinity,
              height: 1000,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      right: 5,
                      left: 5,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onChanged: (value) {
                              setState(() {
                                filterGovernorate = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'ابحث بالمحافظة',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          width: double.infinity,
                          height: 500,
                          child: StaggeredGridView.countBuilder(
                            padding: EdgeInsets.only(
                              top: 20,
                              left: 15,
                              right: 15,
                              bottom: 15,
                            ),
                            crossAxisCount: 3,
                            itemCount: filteredCraftsmen.length,
                            itemBuilder: (context, index) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                      ),
                                      child: CircleAvatar(
                                        radius: 60,
                                        backgroundImage: NetworkImage(
                                          '${filteredCraftsmen[index].imageUrl}',
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${filteredCraftsmen[index].name}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '${filteredCraftsmen[index].Governorate}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${filteredCraftsmen[index].phoneNumber}',
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    RatingBar.builder(
                                      initialRating:
                                          menList2[index].rating!.toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20,
                                      itemPadding:
                                          EdgeInsets.symmetric(horizontal: 2.0),
                                      itemBuilder: (context, _) => Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (double rating2) async {
                                        rating2.toDouble();

                                        DatabaseReference companyRef =
                                            FirebaseDatabase.instance
                                                .reference()
                                                .child('craftsMenapproved')
                                                .child(filteredCraftsmen[index]
                                                    .type
                                                    .toString())
                                                .child(menList2[index]
                                                    .uid
                                                    .toString());
                                        if (rating2 == 0.5) {
                                          rating2 = 1;
                                        } else if (rating2 == 1.5) {
                                          rating2 = 2;
                                        } else if (rating2 == 2.5) {
                                          rating2 = 3;
                                        } else if (rating2 == 3.5) {
                                          rating2 = 4;
                                        } else if (rating2 == 4.5) {
                                          rating2 = 5;
                                        }
                                        await companyRef.update({
                                          'rating': rating2,
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      height: 5.h,
                                    ),
                                    ConstrainedBox(
                                      constraints: BoxConstraints.tightFor(
                                          width: 120.w, height: 40.h),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.deepPurple,
                                        ),
                                        child: Text(
                                          'سابق الأعمال',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        onPressed: () async {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return WorkerDetails(
                                              workerUid: menList2[index]
                                                  .uid
                                                  .toString(),
                                              type: menList2[index]
                                                  .type
                                                  .toString(),
                                            );
                                          }));
                                        },
                                      ),
                                    ),
                                    // RatingBar and ElevatedButton widgets...
                                  ],
                                ),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
