import 'package:crafts_men/locale/locale_controller.dart';
import 'package:crafts_men/pages/admin/orders.dart';
import 'package:crafts_men/pages/admin/userc.dart';
import 'package:crafts_men/pages/admin/workerapprove.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/user/user_replays.dart';
import 'package:crafts_men/pages/worker/send_replay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/complains_model.dart';
import '../models/craftsmen_model.dart';
import '../user/user_home.dart';
import '../admin/workers.dart';
import '../worker/add_craftsmen.dart';
import 'admin_replay.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late DatabaseReference base,base2,base3;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<CraftsMenV> menList = [];
  List<String> keyslist = [];
  List<CraftsMenV> menList2 = [];
  List<String> keyslist3 = [];
  List<String> keyslist2 = [];

  List<Complains> complainsList = [];
  List<Complains> complainsList1 = [];

  String dropdownValue = 'سباكة';
  final List<Department> departments = [
    Department(name: 'دش', imageUrl: 'assets/images/spak.jpg'),
    Department(name: 'ارضيات', imageUrl: 'assets/images/ngar.jpg'),
    Department(name: 'بركية', imageUrl: 'assets/images/heata.jpg'),
    Department(name: 'الموتال', imageUrl: 'assets/images/tbah.jpg'),
    Department(name: ' صيانة اجهزة', imageUrl: 'assets/images/naash.jpg'),
    Department(name: 'صيانة تكييف', imageUrl: 'assets/images/htat.jpg'),
    Department(name: 'ديكورات', imageUrl: 'assets/images/nht.png'),
    Department(name: 'زجاج', imageUrl: 'assets/images/htat.jpg'),
    Department(name: 'ونش رفع', imageUrl: 'assets/images/san.png'),
    Department(name: 'مكافحة حشرات', imageUrl: 'assets/images/san.png'),
    Department(name: 'رخام وجرانيت', imageUrl: 'assets/images/san.png'),
    Department(name: 'ستورجي', imageUrl: 'assets/images/san.png'),
    Department(name: 'صيانة حمام السباحة', imageUrl: 'assets/images/san.png'),
    Department(name: 'محارة', imageUrl: 'assets/images/san.png'),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchTypes();
    fetchComplains();
    CreftsComplains();
  }

  @override
  void fetchComplains() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("userComplains");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Complains p = Complains.fromJson(event.snapshot.value);
      complainsList.add(p);
      keyslist2.add(event.snapshot.key.toString());
      setState(() {});
    });
  }
  void CreftsComplains() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base3 = database.reference().child("CreftComplains");
    base3.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Complains p = Complains.fromJson(event.snapshot.value);
      complainsList1.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  void fetchTypes() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base2 = database.reference().child("craftsMen");
    base2.onChildAdded.listen((event) {
      print(event.snapshot.value);
      CraftsMenV p = CraftsMenV.fromJson(event.snapshot.value);
      menList2.add(p);
      keyslist3.add(event.snapshot.key.toString());
      print(keyslist2);
      setState(() {});
    });
  }




  @override
  void initState() {
    tabController = TabController(
      length: 5,
      vsync: this,
      initialIndex: 0,
    );
    super.initState();
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
                  title: Text("4".tr),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(orders());
                  },
                ),
                ListTile(
                  title: Text("5".tr),
                  leading: Icon(Icons.login),
                  onTap: (){
                    Get.offAll(AdminApprove());
                  },
                ),

                ListTile(
                  title: Text("6".tr),
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
          body: ListView(children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                height: 220.h,
                color: Colors.deepPurple,
                padding: EdgeInsets.only(
                  left: 10.w,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                      controller: tabController,
                      labelColor: Colors.black,
                      unselectedLabelColor: Colors.grey,
                      labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                      isScrollable: true,
                      tabs: const [


                        Tab(
                          child: Text('شكاوى العملاء',
                              style: TextStyle(color: Colors.white)),
                        ),
                        Tab(
                          child: Text('شكاوى الحرافيين',
                              style: TextStyle(color: Colors.white)),
                        ),


                      ]),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: 580.h,
              child: TabBarView(controller: tabController, children: [

                ListView(
                  children: [

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      child: Container(
                        width: double.infinity,
                        height: 800.h,
                        child: Padding(
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
                                  crossAxisCount: 3,
                                  itemCount: menList2.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15.0),
                                      ),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                              top: 10.h,
                                            ),
                                            child: CircleAvatar(
                                              radius: 50,
                                              backgroundImage: NetworkImage(
                                                '${menList2[index].imageUrl
                                                    .toString()}',
                                              ),
                                            ),
                                          ),

                                          Text(
                                            '${menList2[index].name.toString()}',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            '${menList2[index].phoneNumber
                                                .toString()}',
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            '${menList2[index].type.toString()}',
                                          ),
                                          SizedBox(
                                            height: 5.h,
                                          ),
                                          Text(
                                            '${menList2[index].email.toString()}',
                                          ),
                                          ConstrainedBox(
                                            constraints: BoxConstraints.tightFor(
                                              width: 200.w,
                                              height: 40.h,
                                            ),
                                            child: Row(

                                              children: [
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.deepPurple,
                                                    ),
                                                    child: Text("7".tr,style: TextStyle(color: Colors.white),),
                                                    onPressed: () async {
                                                      showDialog<void>(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (BuildContext dialogContext) {
                                                          return AlertDialog(
                                                            title: Text('Loading Data'),
                                                            content: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                CircularProgressIndicator(),
                                                              ],
                                                            ),

                                                          );
                                                        },
                                                      );
                                                      base3 = FirebaseDatabase
                                                          .instance
                                                          .reference()
                                                          .child('craftsMenapproved')
                                                          .child(menList2[index].type.toString()).child(menList2[index].uid.toString());

                                                      int dt = DateTime.now().millisecondsSinceEpoch;

                                                      CraftsMenV m=CraftsMenV(
                                                        name: menList2[index].name.toString(),
                                                        imageUrl: menList2[index].imageUrl.toString(),
                                                        email: menList2[index].email.toString(),
                                                        password: menList2[index].password.toString(),
                                                        address: menList2[index].address.toString(),
                                                        uid: menList2[index].uid.toString(),
                                                        phoneNumber: menList2[index].phoneNumber.toString(),
                                                        type:menList2[index].type.toString() ,
                                                        rating: menList2[index].rating,
                                                        id: menList2[index].id.toString(),
                                                        Governorate: menList2[index].Governorate.toString(),

                                                      );


                                                      base3.set(m.toJson()).whenComplete(() {
                                                        Navigator.pop(context);

                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                context) =>
                                                                super.widget));
                                                        database.reference().child("craftsMen").child(menList2[index].id .toString())
                                                            .remove();

                                                      });

                                                    },
                                                  ),
                                                ),
                                                Expanded(
                                                  child: ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.deepPurple,
                                                    ),
                                                    child: Text("8".tr,style: TextStyle(color: Colors.white)),
                                                    onPressed: () async {
                                                      Navigator.pushReplacement(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (BuildContext
                                                              context) =>
                                                              super.widget));
                                                      database.reference().child("craftsMen").child(menList2[index].id .toString())
                                                          .remove();



                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  staggeredTileBuilder: (int index) =>
                                      StaggeredTile.count(
                                        3,
                                        index.isEven ? 3 : 3,
                                      ),
                                  mainAxisSpacing: 35.0,
                                  crossAxisSpacing: 5.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


                    ),
                    Container(
                      width:500,
                      height: 500,
                      child: StaggeredGridView.countBuilder(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          left: 15.w,
                          right: 15.w,
                          bottom: 15.h,
                        ),
                        crossAxisCount: 3,
                        itemCount: menList.length,
                        itemBuilder: (context, index) {
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 5.h,
                                    ),
                                    child: CircleAvatar(
                                      radius: 37,
                                      backgroundImage: NetworkImage(
                                          '${menList2[index].imageUrl.toString()}'),
                                    ),
                                  ),
                                  Center(
                                    child: Text(
                                      '${menList2[index].name.toString()}',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Center(child: Text('${menList2[index].email.toString()}')),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text('9${menList2[index].password.toString()}'.tr),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Text(
                                      '10${menList2[index].phoneNumber.toString()}'.tr),
                                  InkWell(
                                    onTap: () async {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                              super.widget));
                                      FirebaseDatabase.instance
                                          .reference()
                                          .child('craftsMen')
                                          .child('$dropdownValue')
                                          .child('${menList[index].id}')
                                          .remove();
                                    },
                                    child: Icon(Icons.delete,
                                        color:
                                        Color.fromARGB(255, 122, 122, 122)),
                                  )
                                ]),
                          );
                        },
                        staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(3, index.isEven ? 3 : 3),
                        mainAxisSpacing: 30.0,
                        crossAxisSpacing: 5.0,
                      ),
                    ),

                  ],
                ),
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
                          itemCount: departments.length,
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
                                    radius: 60,
                                    backgroundImage: AssetImage(departments[index].imageUrl),
                                  ),

                                ),
                                Text(
                                  '${departments[index].name.toString()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),

                                SizedBox(
                                  height: 5.h,
                                ),

                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 200.w, height: 40.h),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.deepPurple,
                                    ),
                                    child: Text('11'.tr,style: TextStyle(color: Colors.white),),
                                    onPressed: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) {
                                                return WorkersPage(
                                                  type:
                                                  departments[index].name.toString(),
                                                );
                                              }));
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
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    right: 10.w,
                    left: 10.w,
                  ),
                  child: ListView.builder(
                    itemCount: complainsList.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                        'اسم العميل : ${complainsList[index].userName.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'هاتف العميل : ${complainsList[index].UserPhone.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        ' الاوردر : ${complainsList[index].Order.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'الشكوى : ${complainsList[index].description.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),

                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Row(
                                    children: [
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 120.w, height: 35.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                          ),
                                          child: Text('الرد ',style: TextStyle(color: Colors.white),),
                                          onPressed: () async {
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) {
                                              return AdminReplay(
                                                complain:
                                                    '${complainsList[index].description.toString()}',
                                                uid:
                                                    '${complainsList[index].userUid.toString()}',
                                              );
                                            }));
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50.w,
                                      ),
                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 120.w, height: 35.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                          ),
                                          child: Text('مسح الشكوى',style: TextStyle(color: Colors.white),),
                                          onPressed: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        super.widget));
                                            base
                                                .child(complainsList[index]
                                                    .id
                                                    .toString())
                                                .remove();
                                          },
                                        ),
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
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.h,
                    right: 10.w,
                    left: 10.w,
                  ),
                  child: ListView.builder(
                    itemCount: complainsList1.length,
                    itemBuilder: (BuildContext context, int index) {
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
                                        'اسم الحرفى : ${complainsList1[index].userName.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'هاتف الحرفى : ${complainsList1[index].UserPhone.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        ' الاوردر : ${complainsList1[index].Order.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),
                                  Align(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        'الشكوى : ${complainsList1[index].description.toString()}',
                                        style: TextStyle(fontSize: 17),
                                      )),

                                  SizedBox(
                                    height: 10.h,
                                  ),


                                      ConstrainedBox(
                                        constraints: BoxConstraints.tightFor(
                                            width: 120.w, height: 35.h),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple,
                                          ),
                                          child: Text('مسح الشكوى',style: TextStyle(color: Colors.white),),
                                          onPressed: () async {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                    super.widget));
                                            base3
                                                .child(complainsList1[index]
                                                .id
                                                .toString())
                                                .remove();
                                          },
                                        ),
                                      ),


                                ]),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          )
                        ],
                      );
                    },
                  ),
                ),
                Column(
                  children: [
                    Image.asset('assets/images/logout.jfif',
                        height: 400.h, width: double.infinity),
                    SizedBox(
                      height: 50.h,
                    ),
                    ConstrainedBox(
                      constraints:
                          BoxConstraints.tightFor(width: 120.w, height: 40.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                        ),
                        child: Text(' خروج',style: TextStyle(color: Colors.white),),
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('تأكيد'),
                                  content:
                                      Text('هل انت متأكد من تسجيل الخروج'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        FirebaseAuth.instance.signOut();
                                        Navigator.pushNamed(
                                            context, LoginPage.routeName);
                                      },
                                      child: Text('نعم'),
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
                  ],
                )
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
