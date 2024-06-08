import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class WorkerComplain extends StatefulWidget {
  static const routeName = '/workerComplain';
  WorkerComplain({super.key});

  @override
  State<WorkerComplain> createState() => _WorkerComplainState();
}

class _WorkerComplainState extends State<WorkerComplain> {
    var NameController = TextEditingController();
  var PhoneController = TextEditingController();
  var OrderController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.deepPurple,
              title: Text("ارسال شكوى")),
          body: Padding(
            padding: EdgeInsets.only(
              right: 10.w,
              left: 10.w,
            ),
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: Align(
                      alignment: Alignment.center,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/logo.jpg'),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                    child: TextField(
                      controller: NameController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'اسمك',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50.h,
                    child: TextField(
                      controller: PhoneController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'هاتفك',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50.h,
                    child: TextField(
                      controller: OrderController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'تفاصيل الاوردر',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 150.h,
                    child: TextField(
                      keyboardType: TextInputType.multiline,
                      minLines: 5,
                      maxLines: 10,
                      controller: descriptionController,
                      decoration: InputDecoration(
                        fillColor: HexColor('#155564'),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.deepPurple, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'الشكوى',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () async {
                        String description = descriptionController.text.trim();

                        if (description.isEmpty) {
                          CherryToast.info(
                            title: Text('ادخل الشكوى'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }

                        User? user = FirebaseAuth.instance.currentUser;

                        if (user != null) {
                          String uid = user.uid;
                          String date =
                              DateTime.now().millisecondsSinceEpoch.toString();

                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('CreftComplains');

                          String? id = companyRef.push().key;

                          await companyRef.child(id!).set({
                            'id': id,
                            'userUid': uid,
                            'description': description,
                            'date': date,
                            'userName': NameController.text.toString(),
                            'UserPhone': PhoneController.text.toString(),
                            'Order': OrderController.text.toString(),
                          });
                        }
                        CherryToast.info(
                          title: Text(
                              'تم ارسال الشكوى سيقوم مدير النظام بالتواصل معك تلفونيا'),
                          actionHandler: () {},
                        ).show(context);
                        NameController.text = "";
                        PhoneController.text = "";
                        OrderController.text = "";
                        descriptionController.text = "";
                      },
                      child: Text(
                        'ارسال الشكوى',
                        style: TextStyle(color: Colors.white),
                      ),
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
