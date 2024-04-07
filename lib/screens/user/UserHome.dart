import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/user/user_school.dart';

import '../auth/Logo.dart';
class UserHome extends StatefulWidget {
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[400],
            title: Center(child: Text('الصفحة الرئيسية',style: TextStyle(fontSize: 20,color: Colors.white))),
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
                  child: Icon(Icons.exit_to_app,color: Colors.white,))),


          body: Container(child: ListView(
children: [ Image.asset("images/image.jpg"),

  Container(height: 20,),
  Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight:Radius.circular(50),bottomLeft: Radius.circular(50),bottomRight:Radius.circular(50)  ),
      color: Colors.deepOrangeAccent
    ),
    child: SingleChildScrollView(
    child: Column(children: [
      Container(

        height: 150,),
      Container(
        decoration: BoxDecoration(),
        child: Row(children: [
          Container(width: 110,),
          InkWell(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return UserSchool();
              }));
            },
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.green[400],
                    borderRadius: BorderRadius.circular(100)
                ),
                height: 150,
                width: 150,
                child: Center(child: Text("المدارس",style: TextStyle(fontSize: 20,color: Colors.white),)),),
            ),
          ),
          Container(height: 100,),

        ],),

      ),
      Container(height: 130,),
    ],),
  ),)
 ],


          ),),
        ) );
  }
}
