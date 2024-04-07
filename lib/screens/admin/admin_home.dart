import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/admin/admin_schools.dart';
import 'package:untitled10/screens/auth/Logo.dart';

import '../auth/Adminlogin.dart';
class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,child:
      Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green[400],
          title: Center(child: Text('الصفحة الرئيسية',style: TextStyle(color: Colors.white),)),
        leading: InkWell(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('تأكيد'),
                      content: Text(
                          'هل انت متأكد من تسجيل الخروج'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            FirebaseAuth.instance
                                .signOut();
                            Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                              return Logo();
                            }));
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
            child: Icon(Icons.exit_to_app,color: Colors.white,)),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          child: ListView(
        children: [
          Container(

            child: Image.asset("images/OIP (5).jpg",fit: BoxFit.fill,),),
          Container(height: 10,),



        Container(height: 100,),
        Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight:Radius.circular(50),bottomLeft: Radius.circular(50),bottomRight:Radius.circular(50)  ),
                color: Colors.deepOrangeAccent
            ),
          child:Column(children: [
            InkWell(
              onTap: (){

                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return AdminSchools();
                }));
              },
              child: Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight:Radius.circular(50),bottomLeft: Radius.circular(50),bottomRight:Radius.circular(50)  ),
                      color: Colors.green[400]
                  ),
                height: 200,
                  width: 200,
                  padding: EdgeInsets.all(30),

                  child: Row(

                    children: [
                      Icon(Icons.arrow_back_ios_new,color: Colors.deepOrangeAccent,), SizedBox(width: 20,),
                      Text("المدارس",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),

                    ],
                  )),
            ),
          ],)
        ),
    ]))));
  }
}
