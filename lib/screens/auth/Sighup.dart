import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:progress_dialog_fork/progress_dialog_fork.dart';

import '../user/UserHome.dart';
class Sighup extends StatefulWidget {
  const Sighup({super.key});

  @override
  State<Sighup> createState() => _SighupState();
}

class _SighupState extends State<Sighup> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();
  var iDController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,
        child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[400],

          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(

              child: Column(children: [
                Text(
                  'انشاء حساب',
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'ElMessiri',
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15
                ),
                SizedBox(
                  height: 65,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.text_fields,
                        color: Colors.green,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.green,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            width: 1.0, color: Colors.green),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'الأسم',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25
                ),
                SizedBox(
                  height: 65,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.green,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            width: 1.0, color: Colors.green),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'رقم الهاتف',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 25
                ),
                SizedBox(
                  height: 65,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: iDController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.green,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            width: 1.0, color: Colors.green),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'الرقم القومى',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: 65,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.green,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            width: 1.0, color: Colors.green),
                      ),
                      border: OutlineInputBorder(),
                      hintText: 'البريد الألكترونى',
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Cairo',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25
                ),
                SizedBox(
                  height: 65,
                  child: TextField(
                    style: TextStyle(color: Colors.black),
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.password,
                          color: Colors.green,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(
                              width: 1.0, color: Colors.green),
                        ),
                        border: OutlineInputBorder(),
                        hintText: 'كلمة المرور',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Cairo',
                        )),
                  ),

                ),
                SizedBox(
              height: 50,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                      width: 200, height: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25), // <-- Radius
                      ),
                    ),
                    child: Text(
                      'انشاء ',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Marhey',
                      ),
                    ),
                    onPressed: () async {
                      var name = nameController.text.trim();
                      var phoneNumber =
                      phoneNumberController.text.trim();
                      var email = emailController.text.trim();
                      var password = passwordController.text.trim();
                      var iD = iDController.text.trim();

                      if (name.isEmpty ||
                          email.isEmpty ||
                          password.isEmpty ||
                          phoneNumber.isEmpty ||
                          iD.isEmpty) {
                        MotionToast(
                            primaryColor: Colors.blue,
                            width: 300,
                            height: 50,
                            position: MotionToastPosition.center,
                            description:
                            Text("please fill all fields"))
                            .show(context);

                        return;
                      }

                      if (password.length < 6) {
                        // show error toast
                        MotionToast(
                            primaryColor: Colors.blue,
                            width: 300,
                            height: 50,
                            position: MotionToastPosition.center,
                            description: Text(
                                "Weak Password, at least 6 characters are required"))
                            .show(context);

                        return;
                      }

                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Logging In',
                        desc: 'Please Wait.............',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return UserHome();
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
                            'password': password,
                            'uid': uid,
                            'dt': dt,
                            'iD': iD,
                            'phoneNumber': phoneNumber,
                          });

                          Navigator.canPop(context)
                              ? Navigator.pop(context)
                              : null;
                        } else {
                          MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position:
                              MotionToastPosition.center,
                              description: Text("failed"))
                              .show(context);
                        }

                      } on FirebaseAuthException catch (e) {

                        if (e.code == 'email-already-in-use') {
                          MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position:
                              MotionToastPosition.center,
                              description:
                              Text("email is already exist"))
                              .show(context);
                        } else if (e.code == 'weak-password') {
                          MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position:
                              MotionToastPosition.center,
                              description:
                              Text("password is weak"))
                              .show(context);
                        }
                      } catch (e) {

                        MotionToast(
                            primaryColor: Colors.blue,
                            width: 300,
                            height: 50,
                            position: MotionToastPosition.center,
                            description:
                            Text("something went wrong"))
                            .show(context);
                      }
                    },
                  ),
                ),
              ],
              ),
            ),
          ),
            ),

        );
  }
}
