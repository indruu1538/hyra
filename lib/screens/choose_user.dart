import 'package:flutter/material.dart';
import 'package:himi/screens/driver_reg.dart';
import 'package:himi/screens/driver_signin.dart';
import 'package:himi/screens/signin_screen.dart';
import 'package:himi/screens/signup_screen.dart';

import '../utils/color_utils.dart';
class ChooseUser extends StatefulWidget {
  const ChooseUser({Key? key}) : super(key: key);

  @override
  State<ChooseUser> createState() => _ChooseUserState();
}

class _ChooseUserState extends State<ChooseUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Container(
        width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: BoxDecoration(gradient: LinearGradient(colors:[
    hexStringToColor("0a0804"),
    hexStringToColor("18140a"),
    hexStringToColor("252010"),

    ],begin: Alignment.topCenter,end: Alignment.bottomCenter
    )),
     child: Column(
          children: [SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:30,right: 30,top: 80),
              child:
              Material(
                  elevation: 15,
                  color: Colors.transparent,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                      child: Text(
                        '',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600),
                      ))),),
            const SizedBox(height: 50),

            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                  color:  Colors.transparent,
                  borderRadius: BorderRadius.circular(21),
                  border: Border.all(
                      width: 2,
                      color: Colors.white12
                  ),
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 31,
                        color: Colors.black87,
                        spreadRadius: 6
                    ),
                  ]

              ),
               child: IconButton(onPressed: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>const SignInScreen() ));

               }, icon:Image.asset('assets/images/pass.png'),color: Colors.white,iconSize: 50,)

            ),
            Padding(
              padding: const EdgeInsets.only(left:30,right: 30,top: 10),
              child:
              Material(
                  elevation: 15,
                  color: Colors.transparent,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                      child: Text(
                        'User',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ))),),
           SizedBox(height: 30,),
           // const SizedBox(height: 80),
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                    width: 2,
                    color: Colors.white12
                ),
                boxShadow: const [
                  BoxShadow(
                      blurRadius: 31,
                      color: Colors.black87,
                      spreadRadius: 6
                  )
                ],

              ),

                child: IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const DriverSignIn() ));

                }, icon:Image.asset('assets/images/driver.png'),color: Colors.white,iconSize: 50,)
            ),
            Padding(
              padding: const EdgeInsets.only(left:30,right: 30,top: 10),
              child:
              Material(
                  elevation: 15,
                  color: Colors.transparent,
                  shadowColor: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  child: const Center(
                      child: Text(
                        'Driver',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold),
                      ))),),
          ]),


    )

    );
  }
}
