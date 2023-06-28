import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/color_utils.dart';
class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override

  void dispose(){
    _emailController.dispose();
    super.dispose();
  }
  Future passwordReset() async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _emailController.text.trim());
      showDialog(context: context,
          builder: (context){ return
            // ShowSnackBar(context, "Password reset link is sent! Check your email");
            AlertDialog(
              content: Text('Password reset link is sent! Check your email.'),
            );


          });


    } on FirebaseAuthException catch(e){
      // print(e);
      showDialog(context: context, builder: (context)
      {
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent,
          elevation: 0,
          // title:const Text('Sign Up',style: TextStyle(fontSize: 24,
          // fontWeight: FontWeight.normal),),
        ),
      body:Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: LinearGradient(colors:[
        hexStringToColor("0a0804"),
        hexStringToColor("18140a"),
        hexStringToColor("252010"),

      ],begin: Alignment.topCenter,end: Alignment.bottomCenter
      )),
    child:Form(
    key: _formkey,child: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.all(8.0),
          child: SafeArea(
            child: Column(
                children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: new Image.asset('assets/images/lock.png',width: 200,height: 150,),
            ),
            Padding(
            padding: const EdgeInsets.only(left:30,right: 30,top:1),
            child:
            Material(
                elevation: 15,
                color: Colors.transparent,
                shadowColor: Colors.black,
                borderRadius: BorderRadius.circular(10),
                child: const Center(
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ))),),
                  const SizedBox(
                    height: 20,
                  ),
          const Padding(
             padding: EdgeInsets.only(right: 40,left: 40),
             child: Center(
               child: Text(
                 'Add your email id . We will send you a verification code',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.normal),
                ),
             ),
           ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left:30,right: 30),
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
                      style: const TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: ' Email Id',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),

                        ),
                        contentPadding:const EdgeInsets.symmetric(vertical: 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Container(
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.email,size: 20,
                              color: Colors.grey,
                            ), // icon is 48px widget.
                          ),
                        ),
                      ),
                    ),

                  ),
                  const      SizedBox(height: 30,),
                  SizedBox(
                    width: double.maxFinite,
                    height: 45,
                    child: Padding(
                      padding: const EdgeInsets.only(left:30.0,right: 30),
                      child: Material(
                        elevation:8,
                        color: Colors.transparent,
                        shadowColor:const Color.fromARGB(255, 63, 62, 62),
                        borderRadius: BorderRadius.circular(20),
                        child: ElevatedButton(
                            onPressed: () { passwordReset();
                              // FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value){
                               // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                           //   }).onError((error, stackTrace) {
                             //   print("Error ${error.toString()}");
                             // });


                            },
                            child:  Text('Reset password',style: TextStyle(color: Colors.white),),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(color:Colors.blueGrey),
                                    )))),
                      ),
                    ),
                  ),
    ])))))));
  }
}
