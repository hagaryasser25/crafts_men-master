import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/admin/orders.dart';
import 'package:crafts_men/pages/admin/workerapprove.dart';
import 'package:crafts_men/pages/admin/workers.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import 'admin_home.dart';

class AdminReplay extends StatefulWidget {
  String uid;
  String complain;
  static const routeName = '/adminReplay';
  AdminReplay({
    required this.uid,
    required this.complain,
  });

  @override
  State<AdminReplay> createState() => _AdminReplayState();
}

class _AdminReplayState extends State<AdminReplay> {

  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Localecontroller controllerlang = Get.find() ;
    var maxLines = 5;
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
            child: Padding(
              padding: EdgeInsets.only(
                top: 10.h,
              ),
              child: Padding(
                padding: EdgeInsets.only(right: 10.w, left: 10.w),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                      padding: EdgeInsets.only(top: 70.h),
                      child: Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/images/logo.jpg'),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
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
                            hintText: 'الرد',
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      ConstrainedBox(
                        constraints: BoxConstraints.tightFor(
                            width: double.infinity, height: 65.h),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: () async {
                            String description =
                                descriptionController.text.trim();
            
                            if (description.isEmpty) {
                              CherryToast.info(
                                      title: Text('ادخل الرد'),
                                      actionHandler: () {},
                                    ).show(context);
                              return;
                            }
            
                            User? user = FirebaseAuth.instance.currentUser;
            
                            if (user != null) {
                              String uid = user.uid;
                              int date = DateTime.now().millisecondsSinceEpoch;
            
                              DatabaseReference companyRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('adminReplays');
            
                              String? id = companyRef.push().key;
            
                              await companyRef.child(id!).set({
                                'id': id,
                                'userUid': widget.uid,
                                'description': description,
                                'userComplain': widget.complain,
                              });
                            }
                            showAlertDialog(context);
                          },
                          child: Text('ارسال الرد',style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      foregroundColor: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم ارسال الرد'),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}