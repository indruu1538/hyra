import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:himi/screens/home.dart';

import '../utils/color_utils.dart';
import '../utils/show_snackbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   final _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
   bool _passwordVisible = false;
   final FirebaseAuth _auth=FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
   var imageUrl ="";
   File ?image;
   UploadTask?uploadTask;

  @override
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
   void selectImage()async{
     image=await pickImage(context);
     setState(() {

     });
   }
  Future signUp()async{
    _auth.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

  print("+++++++++++++++++++++${_emailController.text}");
   addUserDetails(_usernameController.text,
       _emailController.text,
       _phoneController.text,
       imageUrl
   );
  }
  Future addUserDetails(String userName, String email,String phone,imageUrl)async{
    final User? user=_auth.currentUser;
    final _uid=user!.uid;
    print(email);
    print(userName);
    print(phone);
    print(imageUrl);
    print("+++++++++++++++++++++++++++");
    await FirebaseFirestore.instance.collection('users').doc(_uid).set({
      'id':_uid,
      'username': userName,
      'email': email,
      'phone':phone,
      'imageUrl':imageUrl
    }).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())))
        .catchError((error) => print("Failed to add user:++++++++++++++++++ $error"));
  }
  Future UploadImage()async{
   // final path ='ProfilePic/${imageurl.trim()}';
    final file=File(image!.path!);
    final ref = FirebaseStorage.instance.ref().child('ProfilePic').child(_usernameController.text+'.jpg');
    uploadTask= ref.putFile(file);
    final snapShot=await uploadTask!.whenComplete(() {});
    final urlDownload= await snapShot.ref.getDownloadURL();
    imageUrl = urlDownload;
    signUp();
    print('Download link $urlDownload');
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
      body: Container(
         width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(gradient: LinearGradient(colors:[
          hexStringToColor("0a0804"),
          hexStringToColor("18140a"),
          hexStringToColor("252010"),
          ],begin: Alignment.topCenter,end: Alignment.bottomCenter
          )),

          child:  Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Padding(
                padding:  EdgeInsets.all(8.0),
                child: SafeArea(
                  child: Column(
                    children: <Widget>[
                      Padding(
                    padding: const EdgeInsets.only(left:30,right: 30),
                    child: 
                Material(
                    elevation: 15,
                    color: Colors.transparent,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: const Center(
                        child: Text(
                      'REGISTRATION',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold),
                    ))),),
                 const   SizedBox(height: 40,),
                      InkWell(
                        onTap: () =>selectImage(),
                        child: image == null ? const CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 50,
                          child: Icon(Icons.account_circle, size: 50,
                            color: Colors.white,),


                        ) : CircleAvatar(
                          backgroundImage: FileImage(image!),
                          radius: 50,
                        ),

                      ),

                      const   SizedBox(height: 40,),
                     Padding(
                       padding: const EdgeInsets.only(left: 30,right: 30),
                       child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'value is empty';
                          } else {
                            return null;
                          }
                        },
                        controller: _usernameController,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                              hintText: 'Username',
                          contentPadding:const EdgeInsets.symmetric(vertical: 0.0),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person_2_outlined,size: 18,
                              color: Colors.grey,
                            ), // icon is 48px widget.
                          ),
                        ),
                               ),
                     ),
                  
                   const  SizedBox(
                  height: 20,
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
                    style: const TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Email Id',
                      contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.mail_outline_outlined,size: 18,
                          color: Colors.grey,
                        ), 
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left:30,right: 30),
                  child: Material(
                    elevation: 8,
                    color: Colors.transparent,
                    shadowColor: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'value is empty';
                        } else {
                          return null;
                        }
                      },
                      controller: _passwordController,
                      obscureText: !_passwordVisible,
                      textAlign: TextAlign.left,
                      style: const TextStyle(fontSize: 15.0),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                            hintText: 'Password',
                        contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: const Padding(
                          padding: EdgeInsets.all(0.0),
                          child: Icon(
                            Icons.lock_outline_rounded,size: 18,
                            color: Colors.grey,
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
                    ),
                  ),
                


                const SizedBox(
                  height: 20,
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
                    controller: _phoneController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 15.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                          hintText: ' Enter phone number',
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
                            Icons.phone,size: 18,
                            color: Colors.grey,
                          ), // icon is 48px widget.
                        ),
                      ),
                      suffixIcon: _phoneController.text.length >9  ? Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,color: Colors.green
                        ),
                        child: const Icon(Icons.done,
                          color: Colors.white,
                          size: 20,
                        ),
                      ):null,
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
                                    onPressed: () {
                                      if(image!=null){
                                        UploadImage();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Profile picture updated"),
                                            ));
                                        // signUp().onError((error, stackTrace) {print("Error ${error.toString()}");});
                                        // UploadFile();
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Choose a file'),));
                                      }



                                    
                                    },
                                    child:  Text('SignUp',style: TextStyle(color: Colors.white),),
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
                      const      SizedBox(height: 20,),
                      // SizedBox(
                      //   width: double.maxFinite,
                      //   height: 45,
                      //   child: Padding(
                      //     padding: const EdgeInsets.only(left:30.0,right: 30),
                      //     child: Material(
                      //       elevation:8,
                      //       color: Colors.transparent,
                      //       shadowColor:const Color.fromARGB(255, 63, 62, 62),
                      //       borderRadius: BorderRadius.circular(20),
                      //       child: ElevatedButton(
                      //           onPressed: () {
                      //             signUp().then((value){
                      //               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                      //             }).onError((error, stackTrace) {
                      //               print("Error ${error.toString()}");
                      //             });
                      //
                      //
                      //           },
                      //           child:  Text('SIGN UP',style: TextStyle(color: Colors.white),),
                      //           style: ButtonStyle(
                      //               shape: MaterialStateProperty.all<
                      //                   RoundedRectangleBorder>(
                      //                   RoundedRectangleBorder(
                      //                     borderRadius: BorderRadius.circular(15),
                      //                     side: const BorderSide(color:Colors.blueGrey),
                      //                   )))),
                      //     ),
                      //   ),
                      // ),
                         const SizedBox(height: 30,)
                          
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),


    );
  }

}