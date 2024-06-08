import 'package:crafts_men/pages/admin/admin_replay.dart';
import 'package:crafts_men/pages/models/complains_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class complains extends StatefulWidget {
  const complains({super.key});

  @override
  State<complains> createState() => _complainsState();
}

class _complainsState extends State<complains> {
  List<Complains> complainsList = [];
  late DatabaseReference base,base2,base3;
  @override
  Widget build(BuildContext context) {
    return   Padding(
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
    );
  }
}
