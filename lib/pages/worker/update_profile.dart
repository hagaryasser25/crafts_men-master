import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:crafts_men/pages/auth/login_screen.dart';
import 'package:crafts_men/pages/worker/worker2_home.dart';
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

class UpdateProfile extends StatefulWidget {
  var name;
  var phoneNumber;
  var uid;
  var address;
  var url;
  static const routeName = '/updateProfile';
  UpdateProfile(
      {required this.name,
      required this.phoneNumber,
      required this.uid,
      required this.address,
      required this.url});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  String imageUrl = '';
  File? image;
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var addressController = TextEditingController();

  Future pickImageFromDevice() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    final tempImage = File(xFile.path);
    setState(() {
      image = tempImage;
      print(image!.path);
    });

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference refrenceImageToUpload = referenceDirImages.child(uniqueFileName);
    try {
      await refrenceImageToUpload.putFile(File(xFile.path));

      imageUrl = await refrenceImageToUpload.getDownloadURL();
    } catch (error) {}
    print(imageUrl);
  }

  @override
  Widget build(BuildContext context) {
    nameController.text = '${widget.name}';
    phoneNumberController.text = '${widget.phoneNumber}';
    addressController.text = '${widget.address}';

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.deepPurple,
                title: Text('الملف الشخصى')),
            body: Padding(
              padding: EdgeInsets.only(top: 20.h, right: 10.w, left: 10.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 30),
                            child: CircleAvatar(
                              radius: 65,
                              backgroundColor:
                                  Color.fromARGB(255, 235, 234, 234),
                              backgroundImage:
                                  image == null ? null : FileImage(image!),
                            )),
                        Positioned(
                            top: 120,
                            left: 120,
                            child: SizedBox(
                              width: 50,
                              child: RawMaterialButton(
                                  // constraints: BoxConstraints.tight(const Size(45, 45)),
                                  elevation: 10,
                                  fillColor: Colors.deepPurple,
                                  child: const Align(
                                      // ignore: unnecessary_const
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.white, size: 22)),
                                  padding: const EdgeInsets.all(15),
                                  shape: const CircleBorder(),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Choose option',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.deepPurple)),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        pickImageFromDevice();
                                                      },
                                                      splashColor:
                                                          HexColor('#FA8072'),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                                Icons.image,
                                                                color: Colors
                                                                    .deepPurple),
                                                          ),
                                                          Text('Gallery',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        // pickImageFromCamera();
                                                      },
                                                      splashColor:
                                                          HexColor('#FA8072'),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                                Icons.camera,
                                                                color: Colors
                                                                    .deepPurple),
                                                          ),
                                                          Text('Camera',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                        setState(() {
                                                          Navigator.pop(
                                                              context);
                                                        });
                                                      },
                                                      splashColor:
                                                          HexColor('#FA8072'),
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(8.0),
                                                            child: Icon(
                                                                Icons
                                                                    .remove_circle,
                                                                color: Colors
                                                                    .deepPurple),
                                                          ),
                                                          Text('Remove',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ))
                                                        ],
                                                      ))
                                                ],
                                              ),
                                            ),
                                          );
                                        });
                                  }),
                            )),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Text('الأسم'),
                      SizedBox(
                        width: 65.w,
                      ),
                      SizedBox(
                        height: 75.h,
                        width: 250.w,
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                            fillColor: HexColor('#155564'),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor('#fdd47c'), width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text('رقم الهاتف'),
                      SizedBox(
                        width: 37.w,
                      ),
                      SizedBox(
                        height: 75.h,
                        width: 250.w,
                        child: TextField(
                          controller: phoneNumberController,
                          decoration: InputDecoration(
                            fillColor: HexColor('#155564'),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor('#fdd47c'), width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text('العنوان'),
                      SizedBox(
                        width: 57.w,
                      ),
                      SizedBox(
                        height: 75.h,
                        width: 250.w,
                        child: TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            fillColor: HexColor('#155564'),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor('#fdd47c'), width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 60),
                  ConstrainedBox(
                    constraints:
                        BoxConstraints.tightFor(width: 150.w, height: 50.h),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      onPressed: () async {
                        User? user = await FirebaseAuth.instance.currentUser;
                        
                          if ( 
                              imageUrl.isEmpty) {
                            CherryToast.info(
                              title: Text('برجاء الأنتظار حتى يتم تحميل الصورة'),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }
                        if (user != null) {
                          DatabaseReference userRef = FirebaseDatabase.instance
                              .reference()
                              .child('craftsMen')
                              .child('${widget.uid}');

                          await userRef.update({
                            'name': nameController.text.trim(),
                            'phoneNumber': phoneNumberController.text.trim(),
                            'address': addressController.text.trim(),
                            'imageUrl': imageUrl,
                          });
                        }
                        showAlertDialog(context);
                      },
                      child: Text('حفظ', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            )),
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
      Navigator.pushNamed(context, WorkerHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم التعديل"),
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
