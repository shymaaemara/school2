import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/school/SchoolHome.dart';

import '../model/user_model.dart';
class SchoolDetails extends StatefulWidget {
  final String schoolName;
  const SchoolDetails({super.key, required this.schoolName});

  @override
  State<SchoolDetails> createState() => _SchoolDetailsState();
}

class _SchoolDetailsState extends State<SchoolDetails> {
  var dateController = TextEditingController();
  var money1Controller = TextEditingController();
  var money2Controller = TextEditingController();
  var money3Controller = TextEditingController();
  var condtionController = TextEditingController();
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
          ),
          body: Container(
            padding: EdgeInsets.all(10),
         child:   ListView(children: [
           Image.asset("images/image.jpg"),
           Container(height: 20,),
           Container(child: Text("المصروفات",style: TextStyle(fontSize: 15),),),
           Container(height: 20,),
           TextField(
           keyboardType: TextInputType.text,
           controller: money1Controller,
           decoration: InputDecoration(

             focusedBorder: OutlineInputBorder(
               borderSide:
               BorderSide(color: Colors.redAccent, width: 2.0),
             ),
             border: OutlineInputBorder(),
             hintText: 'المرحله الابتدائيه ',
           ),
         ),
           Container(height: 20,),
           TextField(
             keyboardType: TextInputType.text,
             controller: money2Controller,
             decoration: InputDecoration(

               focusedBorder: OutlineInputBorder(
                 borderSide:
                 BorderSide(color: Colors.redAccent, width: 2.0),
               ),
               border: OutlineInputBorder(),
               hintText: 'المرحله الاعداديه',
             ),
           ),
           Container(height: 20,),
           TextField(
             keyboardType: TextInputType.text,
             controller: money3Controller,
             decoration: InputDecoration(

               focusedBorder: OutlineInputBorder(
                 borderSide:
                 BorderSide(color: Colors.redAccent, width: 2.0),
               ),
               border: OutlineInputBorder(),
               hintText: 'المرحله الثانويه ',
             ),
           ),
          SizedBox(height: 20),
          SizedBox(
            height: 65,
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 5,
              controller: condtionController,
              decoration: InputDecoration(

                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.red, width: 2.0),
                ),
                border: OutlineInputBorder(),
                hintText: 'شروط التقديم',
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
                String money1 =
                money1Controller.text.trim();
                String money2 = money2Controller.text.trim();
                String money3 = money3Controller.text.trim();
                String condtion = condtionController.text.trim();

                if (
                money1.isEmpty ||
                    money2.isEmpty||
                    money3.isEmpty||
                    condtion.isEmpty 
                    ) {
                  CherryToast.info(
                    title: Text('ادخل جميع الحقول'),
                    actionHandler: () {},
                  ).show(context);
                  return;
                }

                User? user = FirebaseAuth.instance.currentUser;

                if (user != null) {
                  String? uid = user?.uid;

                  DatabaseReference companyRef = FirebaseDatabase
                      .instance
                      .reference()
                      .child('details')
                      .child('${widget.schoolName}');

                  String? id = companyRef.push().key;

                  await companyRef.child(id!).set({
                    'id': id,

                    'money1': money1,
                    'money2': money2,
                    'money3': money3,
                    'condtion': condtion,

                    'userName': currentUser.fullName,
                    'userPhone': currentUser.phoneNumber,
                    
                  });
                }
                Widget remindButton = TextButton(
                  style: TextButton.styleFrom(

                  ),
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return SchoolHome();
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

        
    
    
     
]
    ))


        )  );
  }
}
