import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:himi/screens/driver_home.dart';


import '../utils/color_utils.dart';
import '../utils/show_snackbar.dart';
class DriverReg extends StatefulWidget {
  const DriverReg({Key? key}) : super(key: key);

  @override
  State<DriverReg> createState() => _DriverRegState();
}

class _DriverRegState extends State<DriverReg> {
  final _formkey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  bool _passwordVisible = false;
  final _aboutController=TextEditingController();
  final _placeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  var name ="";
  var imageurl ="";
  File ?image;
  UploadTask?uploadTask;
  var imageUrl="";

  PlatformFile?pickedFile;
  UploadTask?uploadTaskP;
  @override

  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _placeController.dispose();
    _aboutController.dispose();
    super.dispose();
  }
  void selectImage()async{
    image=await pickImage(context);
    setState(() {

    });
  }
  Future signUp()async{
    FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);

    print("+++++++++++++++++++++${_emailController.text}");
    addDriverDetails(_usernameController.text,
        _emailController.text,
        _phoneController.text,
         _aboutController.text,
      _placeController.text,
      imageurl,
      imageUrl,
    );
  }
  Future addDriverDetails(String userName, String email,String phone, String about,place, imageurl,imageUrl)async{
    print(email);
    print(userName);
    print(phone);
    print(place);
    print(about);
    print("+++++++++++++++++++++++++++");
    await FirebaseFirestore.instance.collection('Drivers').add({
      'username': userName,
      'email': email,
      'phone':phone,
      'about':about,
      'place':place,
      'imgUrl':imageUrl,
      'DocUrl':imageurl
    }).then((value) => print("Driver Added"))
        .catchError((error) => print("Failed to add user:++++++++++++++++++ $error"));
  }
  Future BrowseFile()async{
    final result=await FilePicker.platform.pickFiles();
    if (result==null) return;
    setState(() {
      pickedFile=result.files.first;
    });



  }
  Future UploadFile()async{
    final path ='DriverDocuments/${pickedFile!.name}';
    final file=File(pickedFile!.path!);
    final ref = FirebaseStorage.instance.ref().child(path);

  uploadTask= ref.putFile(file);


   final snapShot=await uploadTask!.whenComplete(() {});
   final urlDownload= await snapShot.ref.getDownloadURL();
   imageurl = urlDownload;
   print('Download link $urlDownload');



  }
  Future UploadImage()async{
    // final path ='ProfilePic/${imageurl.trim()}';
    final file=File(image!.path!);
    final ref = FirebaseStorage.instance.ref().child('DriverProfilePic').child(_usernameController.text+'.jpg');
    uploadTaskP= ref.putFile(file);
    final snapShot=await uploadTaskP!.whenComplete(() {});
    final urlDownload= await snapShot.ref.getDownloadURL();
    imageUrl = urlDownload;
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
                        controller: _placeController,
                        textAlign: TextAlign.left,
                        style: const TextStyle(fontSize: 15.0),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          hintText: 'Place',
                          contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.place,size: 18,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(

                      child: Padding(
                        padding: const EdgeInsets.only(left:30,right: 30),
                        child: TextFormField(

                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'value is empty';
                            } else {
                              return null;
                            }
                          },
                          controller: _aboutController,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 15.0),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(

                                borderRadius: BorderRadius.circular(10),),
                            hintText:
                                'write something about your self.',
                            isDense: true,
                            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),

                          //  contentPadding: const EdgeInsets.symmetric(vertical: 0.0),
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.self_improvement,size: 18,
                                color: Colors.grey,
                              ),
                            ),

                          ),
                          maxLines: 5,
                          minLines: 3,
                        ),
                      ),
                    ),

                    const      SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left:30.0),

                          child: Container(
                              height: 160,
                              width:130,

                              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(20)),
                              child:
                              const  Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top:8.0),
                                    child: Text('Upload Certificates',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w300),),
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left:8.0,right: 90),
                                        child: Icon(Icons.flag_circle),
                                      ),


                                    ],
                                  )

                                ],
                              )

                          ),),




                        Padding(
                          padding: const EdgeInsets.only(right:30.0),
                          child: Container(

                            height: 160,
                            width:90,
                            decoration: BoxDecoration(color:Colors.transparent ,borderRadius: BorderRadius.circular(20)),
                            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    height: 60,
                                    child: ElevatedButton(onPressed: (){
                                      BrowseFile();

                                    }, child: Text('BROWSE',style: TextStyle(fontSize:13),))),
                                SizedBox(height: 30,),
                                SizedBox(
                                    height: 60,
                                    child: ElevatedButton(onPressed: (){
                                      if(pickedFile!=null){
                                        UploadImage();
                                        UploadFile();
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                        content: Text("File uploaded"),
                                      ));
                                      // signUp().onError((error, stackTrace) {print("Error ${error.toString()}");});
                                      // UploadFile();
                                      }else{
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Choose a file'),));
                                      }



                                    }, child: Text('UPLOAD',style: TextStyle(fontSize:13),))),
                              ],
                            ),




                          ),
                        ),


                      ],
                    ),
                    const      SizedBox(height: 20,),
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

                                signUp().then((value){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const DriverHome()));
                                }).onError((error, stackTrace) {
                                  print("Error ${error.toString()}");
                                  // UploadFile();
                                });
                                // FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text).then((value){
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                                // }).onError((error, stackTrace) {
                                //   print("Error ${error.toString()}");
                                // });


                              },
                              child:  Text('SIGN UP',style: TextStyle(color: Colors.white),),
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
  // Widget buildProgress()=>StreamBuilder<TaskSnapshot>(stream: uploadTask?.snapshotEvents, builder: (context,snapShot){
  //   if(snapShot.hasData){
  //     final data=snapShot.data!;
  //     double progress=data.bytesTransferred/data.totalBytes;
  //     return SizedBox(
  //       height: 50,
  //       child:Stack(fit: StackFit.expand,
  //       children: [
  //         LinearProgressIndicator(
  //           value: progress,
  //           backgroundColor: Colors.white,
  //           color: Colors.green,
  //
  //         ),
  //         Center(
  //            child: Text('${(100*progress).roundToDouble()}%',
  //            style: TextStyle(color: Colors.white),)
  //         ),
  //       ],
  //       ),
  //     );
  //   }
  //   else{
  //     return const SizedBox(height: 50,);
  //   }
  // });
}
