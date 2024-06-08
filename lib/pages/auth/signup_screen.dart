import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/pages/auth/admin_login.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/auth/worker_login.dart';
import 'package:crafts_men/pages/worker/add_craftsmen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

class SignupPage extends StatefulWidget {
  static const routeName = '/signupPage';
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  String dropdownValue = 'مستخدم';
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
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'انشاء حساب',
                            style: TextStyle(
                                fontSize: 22, color: HexColor('#073763')),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 65.h,
                            child: TextField(
                              controller: nameController,
                              style: TextStyle(),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.text_fields,
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
                                  hintText: 'الأسم',
                                  hintStyle: TextStyle()),
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 65.h,
                            child: TextField(
                              controller: phoneNumberController,
                              style: TextStyle(),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.phone,
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
                                  hintText: 'رقم الهاتف',
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
                            height: 25.h,
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
                                'انشاء حساب',
                                style: TextStyle(fontWeight: FontWeight.w600,
                                  color: Colors.white
                                ),
                              ),
                              onPressed: () async {
                                var name = nameController.text.trim();
                                var phoneNumber =
                                    phoneNumberController.text.trim();
                                var email = emailController.text.trim();
                                var password = passwordController.text.trim();
                                String role = "مستخدم";

                                if (name.isEmpty ||
                                    email.isEmpty ||
                                    password.isEmpty ||
                                    phoneNumber.isEmpty) {
                                  CherryToast.info(
                                    title: Text('Please Fill all Fields'),
                                    actionHandler: () {},
                                  ).show(context);
                                  return;
                                }

                                if (password.length < 6) {
                                  // show error toast
                                  CherryToast.info(
                                    title: Text('Weak Password, at least 6 characters are required'),
                                    actionHandler: () {},
                                  ).show(context);

                                  return;
                                }

                                ProgressDialog progressDialog = ProgressDialog(
                                    context,
                                    title: Text('Signing Up'),
                                    message: Text('Please Wait'));
                                progressDialog.show();

                                try {
                                  FirebaseAuth auth = FirebaseAuth.instance;

                                  UserCredential userCredential =
                                      await auth.createUserWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );
                                  User? user = userCredential.user;
                                  user!.updateProfile(displayName: role);

                                  if (userCredential.user != null) {
                                    DatabaseReference userRef = FirebaseDatabase
                                        .instance
                                        .reference()
                                        .child('users');

                                    String uid = userCredential.user!.uid;
                                    int dt =
                                        DateTime.now().millisecondsSinceEpoch;

                                    await userRef.child(uid).set({
                                      'name': name,
                                      'email': email,
                                      'uid': uid,
                                      'dt': dt,
                                      'phoneNumber': phoneNumber,
                                      'role': role,
                                    });

                                    Navigator.canPop(context) ? Navigator.pop(context) : null;
                                  } else {
                                    CherryToast.info(
                                    title: Text('Failed'),
                                    actionHandler: () {},
                                  ).show(context);
                                  }
                                  progressDialog.dismiss();
                                } on FirebaseAuthException catch (e) {
                                  progressDialog.dismiss();
                                  if (e.code == 'email-already-in-use') {
                                    CherryToast.info(
                                    title: Text('Email is already exist'),
                                    actionHandler: () {},
                                  ).show(context);
                                  } else if (e.code == 'weak-password') {
                                    CherryToast.info(
                                    title: Text('Password is weak'),
                                    actionHandler: () {},
                                  ).show(context);
                                  }
                                } catch (e) {
                                  progressDialog.dismiss();
                                  CherryToast.info(
                                    title: Text('Something went wrong'),
                                    actionHandler: () {},
                                  ).show(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                        ],
                      ),
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
