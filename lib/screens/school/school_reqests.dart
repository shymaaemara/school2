import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../auth/Logo.dart';
import '../model/request_model.dart';
import '../model/user_model.dart';
import 'School_details.dart';
class SchoolRequests extends StatefulWidget {
 final  String schoolName;
  const SchoolRequests({super.key, required this.schoolName});

  @override
  State<SchoolRequests> createState() => _SchoolRequestsState();
}

class _SchoolRequestsState extends State<SchoolRequests> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Requests> requestsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getUserData();
    fetchRequests();
  }

  @override
  void fetchRequests() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("requests").child("${widget.schoolName}");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Requests p = Requests.fromJson(event.snapshot.value);
      requestsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
    });
  }

  late Users currentUser;



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
          title: Center(child: Text(' طلبات العميل',style: TextStyle(fontSize: 25,color: Colors.black))),
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
        backgroundColor: Colors.green[400],),
          body: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: requestsList.length,
                itemBuilder: (context,i){
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15, bottom: 10),
                              child: Column(children: [
                                Image.network(
                                    '${requestsList[i].imageUrl.toString()}',
                                    height: 150),


                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'اسم الطالب :     ${requestsList[i].name.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),



                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '  تاريخ الميلاد:    ${requestsList[i].birthday.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '  العنوان:     ${requestsList[i].address.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '  العمر:     ${requestsList[i].age.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '  رقم التلفون:   ${requestsList[i].phone.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      '  حاله التقديم:   ${requestsList[i].discrption.toString()}',
                                      style: TextStyle(fontSize: 17),
                                    )),
                                SizedBox(
                                  height: 10,
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  onTap: () async {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                            super.widget));
                                    FirebaseDatabase.instance
                                        .reference()
                                        .child('requests')
                                        .child('${widget.schoolName}')
                                        .child(
                                        '${requestsList[i].id.toString()}')
                                        .remove();
                                  },
                                  child: Icon(Icons.delete,
                                      color: Color.fromARGB(255, 122, 122, 122)),
                                ),
                              //  MaterialButton(
                               //   color: Colors.green[400],
                               //   onPressed: (){

                                //    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                //      return SchoolDetails(schoolName: '${currentUser.fullName}',);
                                 //   }));
                                //  },child: Text("الرد",style: TextStyle(
                                //,  color: Colors.white,fontSize: 15
                              //q  )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                      ],
                    ),
                  );
            }),
          ),
        ) );
  }
}
