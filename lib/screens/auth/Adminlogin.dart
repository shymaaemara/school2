import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:untitled10/screens/admin/admin_schools.dart';

import '../admin/admin_home.dart';
class Adminlogin extends StatefulWidget {
  const Adminlogin({super.key});

  @override
  State<Adminlogin> createState() => _AdminloginState();
}

class _AdminloginState extends State<Adminlogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,child:
        Scaffold(  appBar: AppBar(
          backgroundColor: Colors.green[400],
        ),
        body:
          Container(child:
            ListView(children: [
              Image.asset("images/R (1).jpg"),
              Container(height: 30,),
           Container(
             padding: EdgeInsets.all(20),
             child: Column(children: [
             TextField(
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
                   BorderSide(width: 1.0, color: Colors.red),
                 ),
                 border: OutlineInputBorder(),
                 hintText: 'البريد الألكترونى',
                 hintStyle: TextStyle(
                   color: Colors.black,
                   fontFamily: 'Cairo',
                 ),
               ),
             ),
             Container(height: 10,),
             TextField(
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
             )
           ],),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(

                  padding: EdgeInsets.symmetric(vertical: 20,horizontal: 100),
                  shape: RoundedRectangleBorder(


                      borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.redAccent[100],
                  onPressed: ()async{

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

                    if (email != 'admin@gmail.com') {
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

                    if (password != '123456789') {
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

                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.rightSlide,
                      title: 'Logging In',
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
                  },child: Text(" د خول ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.green)),),
              ),
              Container(height: 20,),
            ],)

            ,),
        ));
  }
}
