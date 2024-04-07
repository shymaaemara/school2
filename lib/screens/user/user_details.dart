import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/user/send_reqest.dart';

import '../model/details_model.dart';
class UserDetails extends StatefulWidget {
  final  String schoolName;
  const UserDetails({super.key, required this.schoolName});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Details> detailslList = [];
  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchDetails();
  }

  @override
  void fetchDetails() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("details").child("${widget.schoolName}");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Details p = Details.fromJson(event.snapshot.value);
      detailslList.add(p);
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
      ),
      body: Container(
            width: double.infinity,
        child: Column(
          children: [

            Image.asset("images/image.jpg"),
            SizedBox(
              height: 15,
            ),
            Container(height: 20,),
            Center(child: Text("اهلا بيك في مدرستنا ",style: TextStyle(color: Colors.black,fontSize: 25))),
            Container(height: 20,),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),

                padding: EdgeInsets.only(
                  top: 20,
                  left: 15,
                  right: 15,
                  bottom: 15,
                ),

                itemCount:detailslList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){

                    },
                    child: Card(

                      color: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(15.0),

                      ),
                      child: Column(children: [


                        SizedBox(
                          height: 9,
                        ),
                        Center(child: Text("المصروفات",style: TextStyle(color: Colors.white,fontSize: 20)),),
                        Container(height: 20,),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                              'المرحله الابتدائيه: ${detailslList[index].money1.toString()}',style: TextStyle(color: Colors.white,fontSize: 20),),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                              'المرحله الاعداديه: ${detailslList[index].money2.toString()}',style: TextStyle(color: Colors.white,fontSize: 20)),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                              'المرحله الثانويه: ${detailslList[index].money3.toString()}',style: TextStyle(color: Colors.white,fontSize: 20)),
                        ),
                        Container(height: 20,),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '${detailslList[index].condtion.toString()}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        Container(height: 20,),
                        ConstrainedBox(
                          constraints:
                          BoxConstraints.tightFor(width: 90, height: 37),
                          child: ElevatedButton(

                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[400]
                            ),
                            onPressed: () async {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                    return SendReqest(

                                      schoolName:
                                      '${widget.schoolName}',
                                    );
                                  }));
                            },
                            child: Text('طلب',style: TextStyle(color: Colors.white),),
                          ),

                        ),
                        SizedBox(
                          height: 9,
                        ),
                      ]),
                    ),
                  );
                },

              ),
            ),
          ],
        ),
      ),
    ));
  }
}
