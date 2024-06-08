import 'dart:io';

import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/models/requests_model.dart';
import 'package:crafts_men/pages/worker/send_replay.dart';
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

class WorkersRequest extends StatefulWidget {
  static const routeName = '/workersRequest';
  WorkersRequest({super.key});

  @override
  State<WorkersRequest> createState() => _WorkersRequestState();
}

class _WorkersRequestState extends State<WorkersRequest> {
  @override
  Widget build(BuildContext context) {
    late DatabaseReference base;
    late FirebaseDatabase database;
    late FirebaseApp app;
    List<Requests> requestsList = [];
    List<String> keyslist = [];

    void fetchRequests() async {
      app = await Firebase.initializeApp();
      database = FirebaseDatabase(app: app);
      base = database.reference().child("requests");
      base.onChildAdded.listen((event) {
        print(event.snapshot.value);
        Requests p = Requests.fromJson(event.snapshot.value);
        requestsList.add(p);
        print(FirebaseAuth.instance.currentUser!.uid);
        keyslist.add(event.snapshot.key.toString());
        setState(() {});
      });
    }

    void didChangeDependencies() {
      super.didChangeDependencies();
      fetchRequests();
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.deepPurple, title: Text("الطلبات")),
          body: Padding(
            padding: EdgeInsets.only(
              right: 10.w,
              left: 10.w,
            ),
            child: FutureBuilder(
              builder: ((context, snapshot) {
                return ListView.builder(
                  itemCount: requestsList.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (FirebaseAuth.instance.currentUser!.uid ==
                        requestsList[index].workerUid) {
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
                                    top: 10, right: 15, left: 15, bottom: 10),
                                child: Column(children: [
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'اسم صاحب الطلب: ${requestsList[index].userName.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'رقم الهاتف: ${requestsList[index].userPhone.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'تفاصيل الخدمة : ${requestsList[index].description.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'تاريخ التنفيذ : ${requestsList[index].date.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 80.w, height: 40.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                          ),
                                          child: Text(
                                            'الرد',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return SendReplay(
                                                userUid:
                                                    '${requestsList[index].userUid.toString()}',
                                                userRequest:
                                                    '${requestsList[index].description.toString()}',
                                              );
                                            }));
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 140.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          super.widget));
                                          base
                                              .child(requestsList[index]
                                                  .id
                                                  .toString())
                                              .remove();
                                        },
                                        child: Icon(Icons.delete,
                                            color: Color.fromARGB(
                                                255, 122, 122, 122)),
                                      ),
                                    ],
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
        ),
      ),
    );
  }
}
