import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/user/user_home.dart';
import 'package:crafts_men/pages/user/user_replays.dart';
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

class SendComplain extends StatefulWidget {
  static const routeName = '/sendComplain';
  const SendComplain({
    super.key,
  });

  @override
  State<SendComplain> createState() => _SendComplainState();
}

class _SendComplainState extends State<SendComplain> {
  var NameController = TextEditingController();
  var PhoneController = TextEditingController();
  var OrderController = TextEditingController();
  var descriptionController = TextEditingController();
  String uid = FirebaseAuth.instance.currentUser!.uid;

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
          body: SingleChildScrollView(
            child: Padding(
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
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'اسمك',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50.h,
                      child: TextField(

                        controller: PhoneController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'هاتفك',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 50.h,
                      child: TextField(

                        controller: OrderController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'تفاصيل الاوردر',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
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
                            borderSide: BorderSide(
                                color: Colors.deepPurple, width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'الشكوى',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),

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
                              title: Text('ادخل الشكوى'),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }

                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            String uid = user.uid;
                            String date = DateTime.now().millisecondsSinceEpoch.toString();

                            DatabaseReference companyRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('userComplains');

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
                          showAlertDialog(context);
                        },
                        child: Text('ارسال الشكوى',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
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
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text('تم ارسال الشكوى '),
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
