import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/admin/Add_school.dart';
import 'package:untitled10/screens/model/school_model.dart';

import '../auth/Logo.dart';
class AdminSchools extends StatefulWidget {
  const AdminSchools({super.key});

  @override
  State<AdminSchools> createState() => _AdminSchoolsState();
}

class _AdminSchoolsState extends State<AdminSchools> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Schools> schoolList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchschools();
  }
@override

  @override
  void fetchschools() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("schools");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Schools p = Schools.fromJson(event.snapshot.value);
      schoolList.add(p);
      keyslist.add(event.snapshot.key.toString());
      print(keyslist);
      setState(() {});
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
        title:   InkWell(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (context){
              return AddSchool();
            }));
          },
          child: Container(


            child: Row(

              children: [
                Icon(Icons.add,color: Colors.deepOrangeAccent,), SizedBox(width: 5,),
                Text("اضافه مدرسه",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold,color: Colors.white),),

              ],),
          ),
        ),
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
    body:


           Container(
              width: double.infinity,
              child: GridView.builder(
                  padding: EdgeInsets.only(
                    top: 15,
                    left: 15,
                    right: 15,
                    bottom: 15
                  ),
              itemCount: schoolList.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: 5,mainAxisExtent: 250), itemBuilder: (context,i){
            return

               Card(

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                     color: Colors.deepOrangeAccent,
              
                 child: Column(children: [
                CircleAvatar(
                  radius: 37,
                  backgroundImage: NetworkImage(
                      '${schoolList[i].imageUrl.toString()}'),
                ),

                  Text(
                    '${schoolList[i].name.toString()}',
                    style:
                    TextStyle(fontSize: 18, fontWeight: FontWeight.w600,color: Colors.white),
                  ),


                   Text('${schoolList[i].email.toString()}'),
                        

                 Text(
                      'كلمة المرور: ${schoolList[i].password.toString()}'),

                        

                   Text(
                      'رقم السجل: ${schoolList[i].recordNumber.toString()}'),

                        
                Text(
                        'الهاتف: ${schoolList[i].phoneNumber.toString()}'),
                        
                Container(
                    child: Text('${schoolList[i].address.toString()}')),
                InkWell(
                  onTap: () async {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                            AdminSchools()));
                    FirebaseDatabase.instance
                        .reference()
                        .child('schools')
                        .child('${schoolList[i].id}')
                        .remove();
                  },
                  child: Icon(Icons.delete,
                      color: Color.fromARGB(255, 122, 122, 122)),
                )
              ],),

            )
          
            ;
          }
          
          )),
        ),
    );
  }
}
