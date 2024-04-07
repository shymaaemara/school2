import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../model/school_model.dart';
class SchoolSchools extends StatefulWidget {
  final String schoolName;
  const SchoolSchools({super.key, required this.schoolName});

  @override
  State<SchoolSchools> createState() => _SchoolSchoolsState();
}

class _SchoolSchoolsState extends State<SchoolSchools> {
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
    base = database.reference().child("schools").child("${widget.schoolName}");
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
        Scaffold(

          appBar: AppBar(
            backgroundColor: Colors.green[400],
          ),
          body: Container(
            child: ListView.builder(
                itemCount: schoolList.length,

                itemBuilder: (context,i){


    return Card(
    color: Colors.redAccent[100],
    shape: RoundedRectangleBorder(

    borderRadius: BorderRadius.circular(15.0),
    ),
    child: Column(children: [
    Image.network('${schoolList[i].imageUrl.toString()}', height:100),
    FittedBox(
    fit: BoxFit.fitWidth,
    child: Text(
    '${schoolList[i].name.toString()}',
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
    'رقم السجل: ${schoolList[i].recordNumber.toString()}'),
    ),
    SizedBox(
    height: 9,
    ),
    FittedBox(
    fit: BoxFit.fitWidth,
    child: Text(
    'الهاتف: ${schoolList[i].phoneNumber.toString()}')),
    SizedBox(
    height: 9,
    ),
    Container(
    child: FittedBox(
    fit: BoxFit.fitWidth,
    child: Text(
    '${schoolList[i].address.toString()}'))),
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
    return SchoolSchools(
    schoolName:
    '${schoolList[i].name.toString()}',
    );
    }));
    },
    child: Container(

        child: Text('اضافه تفاصيل',style: TextStyle(color: Colors.white),)),
    ),
    ),
    ]),
    );
            }),
          ),
        );
  }
}
