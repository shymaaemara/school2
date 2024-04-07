import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:untitled10/screens/model/school_model.dart';
import 'package:untitled10/screens/school/School_details.dart';
import 'package:untitled10/screens/user/send_reqest.dart';
import 'package:untitled10/screens/user/user_details.dart';

import '../auth/Logo.dart';
class UserSchool extends StatefulWidget {
  const UserSchool({super.key});

  @override
  State<UserSchool> createState() => _UserSchoolState();
}

class _UserSchoolState extends State<UserSchool> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Schools> schoolList = [];

  List<String> keyslist = [];
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchCenters();
  }

  @override
  void fetchCenters() async {
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
        textDirection: TextDirection.rtl,
        child:
           Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.green[400],
              title: Text('بحث',style: TextStyle(color: Colors.white),),
              actions: [
                IconButton(onPressed: (){
                  showSearch(context: context, delegate: Customsearch(list:schoolList ));
                }, icon: Icon(Icons.search))
              ],
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
                    child: Icon(Icons.exit_to_app,color: Colors.white,))
            ),
            body: Container(
              width: double.infinity,
              child: ListView.builder(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 15,
                  right: 15,
                  bottom: 15,
                ),

                itemCount: schoolList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return UserDetails(
                          schoolName:
                          '${schoolList[index].name.toString()}',
                        );
                      }));
                    },
                    child: Card(
                      color: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Column(children: [
                        Image.network('${schoolList[index].imageUrl.toString()}', height:100),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                            '${schoolList[index].name.toString()}',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Text(
                              'رقم السجل: ${schoolList[index].recordNumber.toString()}'),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                                'الهاتف: ${schoolList[index].phoneNumber.toString()}')),
                        SizedBox(
                          height: 9,
                        ),
                        Container(
                            child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                    '${schoolList[index].address.toString()}'))),

                      ]),
                    ),
                  );
                },

              ),
            ),
          ),

      );
  }
}

class Customsearch extends SearchDelegate{
List  list;
Customsearch({required this.list});
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query="";
      }, icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("data");

  }

  @override
  Widget buildSuggestions(BuildContext context) {

    List   filterschoolList=query.isEmpty?list:

    list .where((element) => element.address!.contains(query) ).toList();


    return
        ListView.builder(
            itemCount: filterschoolList.length,
            itemBuilder: (context,i){
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return UserDetails(
                      schoolName:
                      '${filterschoolList[i].name.toString()}',
                    );
                  }));
                },
                child: Card(
                  color: Colors.deepOrangeAccent,
                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(children: [
                    Image.network('${filterschoolList[i].imageUrl.toString()}', height:100),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '${filterschoolList[i].name.toString()}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                          'رقم السجل: ${filterschoolList[i].recordNumber.toString()}'),
                    ),
                    SizedBox(
                      height: 9,
                    ),
                    FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                            'الهاتف: ${filterschoolList[i].phoneNumber.toString()}')),
                    SizedBox(
                      height: 9,
                    ),
                    Container(
                        child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text(
                                '${filterschoolList[i].address.toString()}'))),

                  ]),
                ),
              );;
            });}


    }

