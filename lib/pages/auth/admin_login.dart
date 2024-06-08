import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/pages/admin/admin_home.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/auth/signup_screen.dart';
import 'package:crafts_men/pages/auth/worker_login.dart';
import 'package:crafts_men/pages/worker/add_craftsmen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

import '../user/user_home.dart';

class AdminLogin extends StatefulWidget {
  static const routeName = '/adminLogin';
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                      title: Text("craftsmen"),
                      subtitle: Text("email@email.email"),
                    ))
                  ],
                ),
                ListTile(
                  title: Text("دخول للمسئول"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(AdminLogin());
                  },
                ),
                ListTile(
                  title: Text("دخول للحرفي"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(WorkerLogin());
                  },
                ),
                ListTile(
                  title: Text("انشاء حساب"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(SignupPage());
                  },
                ),
                ListTile(
                  title: Text("حرفي جديد"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(AddCraftsMen());
                  },
                ),
                ListTile(
                  title: Text("دخول للعميل"),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(LoginPage());
                  },
                ),
              ],),
            ),
          ),
          body: Container(
            color: Colors.white,
            child: Column(children: [
              ClipPath(
                clipper: WaveClipperOne(),
                child: Container(
                  height: 180.h,
                  color: Colors.deepPurple,
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'تسجيل دخول',
                          style: TextStyle(
                              fontSize: 22, color: HexColor('#073763')),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(),
                            controller: emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.deepPurple,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'البريد الألكترونى',
                                hintStyle: TextStyle()),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(),
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Colors.deepPurple,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Colors.grey),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'كلمة المرور',
                                hintStyle: TextStyle()),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: double.infinity, height: 50.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                            ),
                            child: Text(
                              'سجل دخول',
                              style: TextStyle(fontWeight: FontWeight.w600,
                                color: Colors.white
                              ),
                            ),
                            onPressed: () async {
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                CherryToast.info(
                                    title: Text('Please fill all fields'),
                                    actionHandler: () {},
                                  ).show(context);
                                return;
                              }

                              if (email != 'admin@gmail.com') {
                                CherryToast.info(
                                    title: Text('Wrong email or password'),
                                    actionHandler: () {},
                                  ).show(context);

                                return;
                              }

                              if (password != '123456789') {
                                CherryToast.info(
                                    title: Text('Wrong email or password'),
                                    actionHandler: () {},
                                  ).show(context);

                                return;
                              }

                              ProgressDialog progressDialog = ProgressDialog(
                                  context,
                                  title: Text('Logging In'),
                                  message: Text('Please Wait'));
                              progressDialog.show();

                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential userCredential =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                if (userCredential.user != null) {
                                  progressDialog.dismiss();
                                  Navigator.pushNamed(
                                      context, AdminHome.routeName);
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'user-not-found') {
                                  CherryToast.info(
                                    title: Text('User not found'),
                                    actionHandler: () {},
                                  ).show(context);
                                } else if (e.code == 'wrong-password') {
                                  CherryToast.info(
                                    title: Text('Wrong email or password'),
                                    actionHandler: () {},
                                  ).show(context);
                                }
                              } catch (e) {
                                CherryToast.info(
                                    title: Text('Something went wrong'),
                                    actionHandler: () {},
                                  ).show(context);
                                progressDialog.dismiss();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
