import 'dart:io';

import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/models/workers_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class WorkersList extends StatefulWidget {
  static const routeName = '/workersList';
  WorkersList({super.key});

  @override
  State<WorkersList> createState() => _WorkersListState();
}

class _WorkersListState extends State<WorkersList> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Workers> workersList = [];
  List<String> keyslist = [];

  void didChangeDependencies() {
    super.didChangeDependencies();
    getServices();
  }

  void getServices() async {
    try {
      app = await Firebase.initializeApp();
      database = FirebaseDatabase(app: app);
      base = database
          .reference()
          .child('services')
          .child(FirebaseAuth.instance.currentUser!.uid);
      base.onChildAdded.listen((event) {
        print(event.snapshot.value);
        print("kkkkkkkkkkkkkkkkkkkkkkk");
        Workers p = Workers.fromJson(event.snapshot.value);
        workersList.add(p);
        keyslist.add(event.snapshot.key.toString());
        print(keyslist);
        setState(() {});
      });
    } catch (e) {
      print("Error fetching data: $e");
    }
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
              title: Text("قائمة سابقة الأعمال")),
          body: Column(
            children: [
              SizedBox(
                height: 15.h,
              ),
              Expanded(
                flex: 8,
                child: FutureBuilder(
                  builder: ((context, snapshot) {
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: workersList.length,
                        itemBuilder: ((context, index) {
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
                                        top: 10, bottom: 10),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 170.w,
                                          height: 170.h,
                                          child: Image.network(
                                              '${workersList[index].serviceImage.toString()}'),
                                        ),
                                        Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.w),
                                              child: Text(
                                                  'اسم الخدمة : ${workersList[index].serviceName.toString()}',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10.w),
                                              child: Text(
                                                  'سعر الخدمة : ${workersList[index].servicePrice.toString()}',
                                                  style:
                                                      TextStyle(fontSize: 15)),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            ConstrainedBox(
                                              constraints:
                                                  BoxConstraints.tightFor(
                                                      width: 150.w,
                                                      height: 40.h),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.deepPurple,
                                                ),
                                                child: Text(
                                                  ' حذف الخدمة',
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
                                                      .child(workersList[index]
                                                          .id
                                                          .toString())
                                                      .remove();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }));
                  }),
                  future: null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
