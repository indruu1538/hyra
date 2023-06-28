
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:himi/screens/driver_home.dart';
import 'package:himi/screens/driver_reg.dart';
import 'package:himi/screens/forgot_password.dart';
import 'package:himi/screens/home.dart';

import '../utils/color_utils.dart';

class DriverSignIn extends StatefulWidget {
  const DriverSignIn({Key? key}) : super(key: key);

  @override
  State<DriverSignIn> createState() => _DriverSignInState();
}

class _DriverSignInState extends State<DriverSignIn> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors:[
          hexStringToColor("0a0804"),
          hexStringToColor("18140a"),
          hexStringToColor("252010"),

        ],begin: Alignment.topCenter,end: Alignment.bottomCenter
        )),
        child:Form(
          key: _formkey,
          child: SingleChildScrollView(
            child: Padding(padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height*0.2, 20,0),
              child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0, 20, 0),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 0.0),
                            child:  Image.asset(
                              'assets/images/HIRE.png',
                              width: 500,
                              height: 180,
                            ),
                          ),
                          SizedBox(height: 10,),

                          const SizedBox(
                            height: 30,
                          ),
                          FractionallySizedBox(
                              widthFactor: 1.0,
                              child: Material(
                                  elevation: 18,
                                  color: Colors.transparent,
                                  shadowColor: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'value is empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: _emailController,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15.0),
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        contentPadding: const EdgeInsets.symmetric(
                                            vertical: 0.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: const Padding(
                                          padding: EdgeInsets.all(0.0),
                                          child: Icon(
                                            Icons.person_2_outlined,
                                            color: Colors.grey,size: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ))),
                          const SizedBox(
                            height: 30,
                          ),
                          FractionallySizedBox(
                              widthFactor: 1.0,
                              child: Material(
                                  elevation: 18,
                                  color: Colors.transparent,
                                  shadowColor: Colors.black,
                                  borderRadius: BorderRadius.circular(20),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'value is empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      controller: _passwordController,
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(fontSize: 15.0),
                                      obscureText: !_passwordVisible,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius:
                                              BorderRadius.circular(10)),
                                          contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 0.0),
                                          filled: true,
                                          fillColor: Colors.white,
                                          prefixIcon: const Padding(
                                            padding: EdgeInsets.all(0.0),
                                            child: Icon(
                                              Icons.lock_outline,
                                              color: Colors.grey,size: 18,
                                            ),
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _passwordVisible
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                              color: Colors.grey,
                                              size: 18,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _passwordVisible =
                                                !_passwordVisible;
                                              });
                                            },
                                          )),
                                    ),
                                  ))),
                          const SizedBox(
                            height: .5,
                          ),
                          Material(

                              elevation: 30,
                              color: Colors.transparent,
                              shadowColor: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 35),
                                child: TextButton(
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const ForgotPass()));
                                    },
                                    child: const Expanded(
                                      child: Align(
                                        alignment:Alignment.centerRight,
                                        child: Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                              color: Colors.white,fontWeight: FontWeight.w300,
                                              fontSize: 14),
                                        ),
                                      ),
                                    )),
                              )),
                          const SizedBox(
                            height: .5,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0,right: 20),
                              child: Material(
                                elevation:8,
                                color: Colors.transparent,
                                shadowColor:const Color.fromARGB(255, 63, 62, 62),
                                borderRadius: BorderRadius.circular(20),
                                child: ElevatedButton(
                                    onPressed: () {
                                      FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).
                                      then((value) {Navigator.push(context, MaterialPageRoute(builder: (context)=>const DriverHome()));}).
                                      onError((error, stackTrace){
                                        print("Error in Driver Sign in${error.toString()}");
                                      });


                                    },
                                    child: const Text('LOGIN',style: TextStyle(color: Colors.white),),
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                              side: const BorderSide(color:Colors.black87),
                                            )))),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const DriverReg() ));

                          },
                              child:const Center(child: Text('Dont have an account? Register',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w300),))),

                        ],
                      ),
                    ),
                  ] ),
            ),
          ),
        )));
  }
}
