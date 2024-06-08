/*
import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/models/requests_model.dart';
import 'package:crafts_men/pages/models/workers_model.dart';
import 'package:crafts_men/pages/worker/add_service.dart';
import 'package:crafts_men/pages/worker/send_replay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import '../models/craftsmen_model.dart';

class WorkerHome extends StatefulWidget {
  static const routeName = '/workerHome';
  const WorkerHome({super.key});

  @override
  State<WorkerHome> createState() => _WorkerHomeState();
}

class _WorkerHomeState extends State<WorkerHome>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late DatabaseReference base, base2,base3;
  late FirebaseDatabase database, database2;
  late FirebaseApp app, app2;
  List<CraftsMenV> menList2 = [];
  List<String> keyslist3 = [];
  List<Workers> workersList = [];
  List<String> keyslist = [];
  List<Requests> requestsList = [];
  List<String> keyslist2 = [];
  String dropdownValue = 'سباكة';
  var NameController = TextEditingController();
  var PhoneController = TextEditingController();
  var OrderController = TextEditingController();
  var descriptionController = TextEditingController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchRequests();
  }


  void GetServices() async {
    try {
      app = await Firebase.initializeApp();
      database = FirebaseDatabase(app: app);
      base3 = database.reference().child('services').child(FirebaseAuth.instance.currentUser!.uid);
      base3.onChildAdded.listen((event) {

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
  void fetchRequests() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base2 = database.reference().child("requests");
    base2.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Requests p = Requests.fromJson(event.snapshot.value);
      requestsList.add(p);
      print(FirebaseAuth.instance.currentUser!.uid);
      keyslist.add(event.snapshot.key.toString());
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
    GetServices();

  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: SingleChildScrollView(
            child: Column(
             children: [
              ClipPath(
                clipper: OvalBottomBorderClipper(),
                child: Container(
                  height: 220.h,
                  color: Colors.deepPurple,
                  padding: EdgeInsets.only(
                    left: 10.w,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: TabBar(
                        controller: tabController,
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        labelPadding: EdgeInsets.only(left: 20.w, right: 20.w),
                        isScrollable: true,
                        tabs: [

                          Tab(
                            child: Text('سابقة الأعمال',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Tab(
                            child: Text('قائمة سابقة الأعمال',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Tab(
                            child: Text('ارسال شكوى',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Tab(
                            child: Text('الطلبات',
                                style: TextStyle(color: Colors.white)),
                          ),
                          Tab(
                            child: Text('تسجيل الخروج',
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

                  Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                          child:ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade200),

                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18.0),
                                        side: BorderSide(color: Colors.green.shade200)))),
                            onPressed: () async{
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return AddService(
                                      keyslist: keyslist3,
                                    );
                                  }));
                            },
                            child: Text("أضافة سابقة الاعمال",style: TextStyle(color: Colors.deepOrange,fontSize: 25.sp),),
                          )


                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          child: Text("مرحبا فى منطقة صاحب الحرفة يستطيع صاحب الحرفة من خلال هذه الشاشة من اضافة سابقة الاعمال الخاصة به من خلال الضغط على الزر اعلاه و اضافة البيانات المطلوبة ثم ارسال البيانات ",style: TextStyle(fontSize: 25),),
                        ),
                      ),

                      SizedBox(
                        height: 10.h,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.bottomLeft,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return AddService(
                                  keyslist: keyslist3,
                                );
                              }));
                            },
                            child: ClipPath(
                              clipper: StarClipper(10),
                              child: Container(
                                color: Colors.deepPurple,
                                height: 80,
                                width: 80,
                                child: Center(
                                    child:
                                        Icon(Icons.add, color: Colors.white)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 15.h,
                      ),
                      Text("قائمة الاعمال السابقة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
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
                                                      padding: EdgeInsets.only(
                                                          right: 10.w),
                                                      child: Text(
                                                          'اسم الخدمة : ${workersList[index].serviceName.toString()}',
                                                          style: TextStyle(
                                                              fontSize: 15)),
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          right: 10.w),
                                                      child: Text(
                                                          'سعر الخدمة : ${workersList[index].servicePrice.toString()}',
                                                          style: TextStyle(
                                                              fontSize: 15)),
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
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor: Colors.deepPurple,
                                                        ),
                                                        child: Text(' حذف الخدمة',style: TextStyle(color: Colors.white),),
                                                        onPressed: () async {
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (BuildContext
                                                                  context) =>
                                                                  super.widget));

                                                          base3.child(workersList[index].id .toString())                                                              .remove();



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
                          }), future: null,
                        ),
                      ),
                    ],
                  ),
                  Padding(
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
                                  title: Text('تم ارسال الشكوى سيقوم مدير النظام بالتواصل معك تلفونيا'),
                                  actionHandler: () {},
                                ).show(context);
                                NameController.text="";
                                PhoneController.text="";
                                OrderController.text="";
                                descriptionController.text="";
                                },
                              child: Text('ارسال الشكوى',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
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
                                            top: 10,
                                            right: 15,
                                            left: 15,
                                            bottom: 10),
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
                                                constraints:
                                                    BoxConstraints.tightFor(
                                                        width: 80.w,
                                                        height: 40.h),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.deepPurple,
                                                  ),
                                                  child: Text('الرد',style: TextStyle(color: Colors.white),),
                                                  onPressed: () async {

                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return SendReplay(
                                                        userUid: '${requestsList[index].userUid.toString()}',
                                                        userRequest: '${requestsList[index].description.toString()}',
                                                      );
                                                    }));

                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 140.w,),
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              super.widget));
                                                  base2
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
                      }), future: null,
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
                            BoxConstraints.tightFor(width: 190.w, height: 40.h),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: Text('تسجيل الخروج',style: TextStyle(color: Colors.white),),
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
                  ),
                ]),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
*/
