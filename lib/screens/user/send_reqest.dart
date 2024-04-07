import 'dart:io';

import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled10/screens/user/user_school.dart';

import '../model/user_model.dart';
import 'UserHome.dart';
class SendReqest extends StatefulWidget {
  final String schoolName;
  const SendReqest({super.key, required this.schoolName});

  @override
  State<SendReqest> createState() => _SendReqestState();
}

class _SendReqestState extends State<SendReqest> {
  var dateController = TextEditingController();
  var nameController = TextEditingController();
  var ageController = TextEditingController();
  var addressController = TextEditingController();
  var disController = TextEditingController();
  var birthdayController = TextEditingController();
  var phoneController = TextEditingController();
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late Users currentUser;

  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserData();
  }

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = Users.fromSnapshot(snapshot);
    });
  }

  String imageUrl = '';
  File? image;

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

  Future pickImageFromcamera() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.camera);
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
    return
      Directionality(
        textDirection: TextDirection.rtl,child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[400],

          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 1,
                  ),
                  Text('صورة شهاده الميلاد'),
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
                                  fillColor: Colors.redAccent,
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
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    color: Colors.red)),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        pickImageFromDevice();
                                                      },
            
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(
                                                                Icons.image,
                                                                color: Colors
                                                                    .red),
                                                          ),
                                                          Text('Gallery',
                                                              style:
                                                              TextStyle(
                                                                fontSize: 18,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                              ))
                                                        ],
                                                      )),
                                                  InkWell(
                                                      onTap: () {
                                                         pickImageFromcamera();
                                                      },
            
                                                      child: Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                            child: Icon(
                                                                Icons.camera,
                                                                color: Colors
                                                                    .red),
                                                          ),
                                                          Text('Camera',
                                                              style:
                                                              TextStyle(
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
                                                                    .red),
                                                          ),
                                                          Text('Remove',
                                                              style:
                                                              TextStyle(
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
            
                  SizedBox(height: 20),
                  SizedBox(
                    height: 65,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: nameController,
                      decoration: InputDecoration(

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'اسم الطالب ثلاثي',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 65,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: ageController,
                      decoration: InputDecoration(

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'السن',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 65,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: addressController,
                      decoration: InputDecoration(

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'العنوان',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 65,
                    child: TextField(
                      keyboardType: TextInputType.datetime,

                      controller: birthdayController,
                      decoration: InputDecoration(
            
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.red, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'تاريخ ميلاده',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 65,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: phoneController,
                      decoration: InputDecoration(

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'رقم تلفون ولي الامر',
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 65,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      minLines: 5,
                      maxLines: 5,
                      controller: disController,
                      decoration: InputDecoration(

                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.redAccent, width: 2.0),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'تحويل من مدرسه اخري ام اول تقديم ',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints.tightFor(
                        width: double.infinity, height: 65),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[400],
                      ),
                      onPressed: () async {
                        String date = dateController.text.trim();
                        String birthday = birthdayController.text.trim();

                        String phone =
                        phoneController.text.trim();
                        String age =
                        ageController.text.trim();
                        String address =
                        addressController.text.trim();

                        String discrption =
                        disController.text.trim();

                        String name = nameController.text.trim();
            
                        if (
                        birthday.isEmpty ||
                            phone.isEmpty ||
                            address.isEmpty ||
                            age.isEmpty ||
                            discrption.isEmpty ||
                            name.isEmpty ||
                            imageUrl.isEmpty) {
                          CherryToast.info(
                            title: Text('ادخل جميع الحقول'),
                            actionHandler: () {},
                          ).show(context);
                          return;
                        }
            
                        User? user = FirebaseAuth.instance.currentUser;
            
                        if (user != null) {
                          String uid = user!.uid;
            
                          DatabaseReference companyRef = FirebaseDatabase
                              .instance
                              .reference()
                              .child('requests')
                              .child('${widget.schoolName}');
            
                          String? id = companyRef.push().key;
            
                          await companyRef.child(id!).set({
                            'id': id,
                             'age':age,
                            'birthday': birthday,
                            'name': name,
                              'phone':phone,
                            'userName': currentUser.fullName,
                                'discrption':discrption,
                            'address':address,
                            'imageUrl': imageUrl,
                          });
                        }
                        Widget remindButton = TextButton(
                          style: TextButton.styleFrom(
            
                          ),
                          child: Text("Ok"),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return UserSchool();
                            }));;
                          },
                        );
            
                        // set up the AlertDialog
                        AlertDialog alert = AlertDialog(
                          title: Text("Notice"),
                          content: Container(
                            height: 100,
                            child: Column(
                              children: [
                                Text("تم ارسال الطلب"),
            
                              ],
                            ),
                          ),
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
                      },
                      child: Text('حفظ'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ) );
  }
}
