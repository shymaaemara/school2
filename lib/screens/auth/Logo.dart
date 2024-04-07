import 'package:flutter/material.dart';
import 'package:untitled10/screens/auth/Adminlogin.dart';
import 'package:untitled10/screens/auth/school_login.dart';
import 'package:untitled10/screens/auth/userlogin.dart';
class Logo extends StatefulWidget {
  const Logo({super.key});

  @override
  State<Logo> createState() => _LogoState();
}

class _LogoState extends State<Logo> {
  @override
  Widget build(BuildContext context) {
    return
      Directionality(
        textDirection: TextDirection.rtl,child:
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.green[400],
          ),
              body: Container(child: 
                ListView(children: [
                  Container(child: 
                    Image.asset("images/R (1).jpg"),

                    ),
                  Container(height: 100,),
                Column(children: [  MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 10,horizontal: 100),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                  color: Colors.blue[100],
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return UserLogin();
                    }));

                  },child: Text("العميل",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),
                  Container(height: 20,),
                  MaterialButton(

                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 100),
                    shape: RoundedRectangleBorder(

                      
                        borderRadius: BorderRadius.circular(20)
                    ),
                    color: Colors.redAccent[100],
                    onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return SchoolLogin();
                      }));
                    },child: Text("المدرسه ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),),
                  Container(height: 20,),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    color: Colors.green,
                    onPressed: (){

                      Navigator.of(context).push(MaterialPageRoute(builder: (context){
                        return Adminlogin();
                      }));
                    },child: Text("مدير النظام",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),)],)
                ],)
                ,),
        ));
  }
}
