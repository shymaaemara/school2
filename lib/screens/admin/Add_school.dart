import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled10/screens/admin/admin_home.dart';
import 'package:untitled10/screens/admin/admin_schools.dart';
class AddSchool extends StatefulWidget {
  const AddSchool({super.key});

  @override
  State<AddSchool> createState() => _AddSchoolState();
}

class _AddSchoolState extends State<AddSchool> {
  var nameController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var numberController = TextEditingController();

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

  Future pickImageFromCamera() async {
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
          body: Container(child:
    SingleChildScrollView(
    child: Column(
    children: [

    Text('صورة السجل',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepOrangeAccent)),
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
                fillColor: Colors.deepOrangeAccent,
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
                                       pickImageFromCamera();
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
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: nameController,
          decoration: InputDecoration(

            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.deepOrangeAccent, width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintText: 'الأسم',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: addressController,
          decoration: InputDecoration(

            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.red, width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintText: 'العنوان',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: emailController,
          decoration: InputDecoration(

            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.red, width: 2.0),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.deepOrange)
            ),
            hintText: 'البريد الالكترونى',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: passwordController,
          decoration: InputDecoration(

            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.red, width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintText: 'كلمة المرور',
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: phoneNumberController,
          decoration: InputDecoration(

            focusedBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.red, width: 2.0),
            ),
            border: OutlineInputBorder(),
            hintText: 'رقم الهاتف',
          ),
        ),
      ),
       ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.deepOrangeAccent,
          ),
          onPressed: () async {
            String name = nameController.text.trim();
            String address = addressController.text.trim();
            String email = emailController.text.trim();
            String role = 'مدرسه';
            String phoneNumber =
            phoneNumberController.text.trim();
            String password = passwordController.text.trim();
            String number = numberController.text.trim();

            if (name.isEmpty ||
                email.isEmpty ||
                password.isEmpty ||
                phoneNumber.isEmpty ||
                address.isEmpty || imageUrl.isEmpty) {
              CherryToast.info(
                title: Text('Please Fill all Fields'),
                actionHandler: () {},
              ).show(context);
              return;
            }

            if (password.length < 6) {
              // show error toast
              CherryToast.info(
                title: Text(
                    'Weak Password, at least 6 characters are required'),
                actionHandler: () {},
              ).show(context);

              return;
            }
            AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: 'Signing Up',
              desc: 'Please Wait.............',
              btnCancelOnPress: () {},
              btnOkOnPress: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return AdminSchools();
                }));
              },
            )..show();

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
                    .child('schools');
                String? id = userRef.push().key;

                String uid = userCredential.user!.uid;
                int dt = DateTime.now().millisecondsSinceEpoch;

                await userRef.child(id!).set({
                  'name': name,
                  'email': email,
                  'password': password,
                  'address': address,
                  'uid': uid,
                  'phoneNumber': phoneNumber,
                  'id': id,
                  'imageUrl': imageUrl,
                  'recordNumber': number,
                });

                DatabaseReference schoolRef = FirebaseDatabase
                    .instance
                    .reference()
                    .child('users');

                await schoolRef.child(uid).set({
                  'name': name,
                  'email': email,
                  'password': password,
                  'uid': uid,
                  'dt': dt,
                  'phoneNumber': phoneNumber,
                });

                FirebaseAuth.instance.signOut();
                Navigator.canPop(context)
                    ? Navigator.pop(context)
                    : null;
              } else {
                CherryToast.info(

                  title: Text('Failed'),
                  actionHandler: () {},
                ).show(context);
              }

            } on FirebaseAuthException catch (e) {

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

              CherryToast.info(
                title: Text('Something went wrong'),
                actionHandler: () {},
              ).show(context);
            }
          },
          child: Text('حفظ',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white)),
        ),

          ],),),
          )));
  }
}

