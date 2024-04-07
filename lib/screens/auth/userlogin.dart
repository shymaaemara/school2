import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:untitled10/screens/auth/Sighup.dart';
import 'package:untitled10/screens/user/user_school.dart';

import '../user/UserHome.dart';
class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
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
          body: Container(child: ListView(children: [
            Image.asset("images/5439.jpg_wh1200.jpg"),


            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [

                  Text(
                    'تسجيل دخول',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'ElMessiri',
                        fontWeight: FontWeight.w600),
                  ),
                  Container(
                    height: 10,
                  ),
                  SizedBox(

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
                          borderSide:
                          BorderSide(width: 1.0, color: Colors.green),
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
                            borderSide:
                            BorderSide(width: 1.0, color: Colors.green),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide:
                            BorderSide(width: 1.0, color: Colors.green),
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
                    height: 30,
                  ),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25), // <-- Radius
                      ),
                    ),
                    child: Text(
                      'سجل دخول',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Marhey',
                      ),
                    ),
                    onPressed: () async {
                      var email = emailController.text.trim();
                      var password = passwordController.text.trim();

                      if (email.isEmpty || password.isEmpty) {
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
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.rightSlide,
                        title: 'Logging In',
                        desc: 'Please Wait.............',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return UserSchool();
                          }));
                        },
                      )..show();


                      try {
                        FirebaseAuth auth = FirebaseAuth.instance;
                        UserCredential userCredential =
                        await auth.signInWithEmailAndPassword(
                            email: email, password: password);

                        if (userCredential.user != null) {


                        }
                      } on FirebaseAuthException catch (e) {

                        if (e.code == 'user-not-found') {
                          MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position: MotionToastPosition.center,
                              description: Text("user not found"))
                              .show(context);
                          return;
                        } else if (e.code == 'wrong-password') {
                          MotionToast(
                              primaryColor: Colors.blue,
                              width: 300,
                              height: 50,
                              position: MotionToastPosition.center,
                              description:
                              Text("wrong email or password"))
                              .show(context);

                          return;
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
                        print(e);


                      }
                    },
                  ),
Container(height: 20,),
         InkWell(
             onTap: (){
               Navigator.of(context).push(MaterialPageRoute(builder: (context){
                 return Sighup();
               }));
             },
             child: Container(child: Text(" لانشاء حساب",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),))
                ],
              ),
            ),

          ]),


          ),),
        ) ;
  }
}
