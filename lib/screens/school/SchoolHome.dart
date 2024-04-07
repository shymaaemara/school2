import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/school/School_details.dart';
import 'package:untitled10/screens/school/School_schools.dart';
import 'package:untitled10/screens/school/school_reqests.dart';

import '../auth/Logo.dart';
import '../model/user_model.dart';
class SchoolHome extends StatefulWidget {
  const SchoolHome({super.key});

  @override
  State<SchoolHome> createState() => _SchoolHomeState();
}

class _SchoolHomeState extends State<SchoolHome> {
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

        body: Container(
          child: ListView(
            children: [
              Image.asset("images/yellow-architecture-school_2334089.png!bw700"),
             Container(
               padding: EdgeInsets.all(15),
               decoration: BoxDecoration(
                   borderRadius: BorderRadius.only(topLeft: Radius.circular(50),topRight:Radius.circular(50),bottomLeft: Radius.circular(50),bottomRight:Radius.circular(50)  ),
                   color: Colors.deepOrange[100]
               ),
               child: SingleChildScrollView(child: Column(children: [
                 Container(height: 20,),
               Container(
                 decoration: BoxDecoration(),
                 child: Row(children: [
                   Container(width: 20,),
                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                         return SchoolDetails(schoolName: '${currentUser.fullName}',);
                       }));
                     },
                     child: Container(
                       decoration: BoxDecoration(
                           color: Colors.green[400],
                           borderRadius: BorderRadius.circular(50)
                       ),
                       height: 150,
                       width: 150,
                       child: Center(child: Text("التفاصيل",style: TextStyle(fontSize: 20,color: Colors.white),)),),
                   ),
                   Container(width: 40,),
                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(MaterialPageRoute(builder: (context){
                         return SchoolRequests(schoolName: '${currentUser.fullName}',);
                       }));
                     },
                     child: Container(
                       decoration: BoxDecoration(
                           color: Colors.green[400],
                           borderRadius: BorderRadius.circular(50)
                       ),
                       height: 150,
                       width: 150,
                       child: Center(child: Text("طلبات العميل",style: TextStyle(fontSize: 20,color: Colors.white),)),),
                   )
                 ],),
               ),
                 Container(height: 100,),
             ],),),)
                ],),
              ),




        ) );
  }
}
