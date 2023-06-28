import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:himi/navigation_drawer/my_header_drawer.dart';
import 'package:himi/screens/signin_screen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:himi/utils/color_utils.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  var currentPage = DrawerSections.dashboard;
  final _searchController = TextEditingController();
  String searchQuery='';
  List<DocumentSnapshot>searchResult=[];
  final FirebaseFirestore firestore=FirebaseFirestore.instance;
  final _userStrem=FirebaseFirestore.instance.collection('Drivers').snapshots();
  File ?image;
  UploadTask?uploadTask;

  final FirebaseAuth _auth =FirebaseAuth.instance;
    String _uid="";
   String _userName="";
   String _email="";
  String _phoneNo="";
  String _ImgUrl="";
  void searchInFirestore()async{
    QuerySnapshot querySnapshot=await firestore.collection('Drivers').where('place',isEqualTo:searchQuery).get();
    setState(() {
      searchResult=querySnapshot.docs;
    });
  }


  void GetData() async{
    User? user= _auth.currentUser;
    _uid=user!.uid;
    final DocumentSnapshot userDoc=
    await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    setState(() {
      _userName=userDoc.get('username');
     // print(_userName);
      _email=userDoc.get('email');
      _phoneNo=userDoc.get('phone');
      _ImgUrl=userDoc.get('imgUrl');

    });


  }

  @override
  Widget build(BuildContext context) {
    GetData();
    return Scaffold(

        drawer:Drawer(
child:SingleChildScrollView(
  child:   Container(
    child: Column(
      children: [
        MyHeaderDrawer(),
        MyDrawerList(),
      ],
    ),
  ),
),
        ),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
        height: MediaQuery
            .of(context)
            .size
            .height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("0a0804"),
              hexStringToColor("18140a"),
              hexStringToColor("252010"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const   SizedBox(height: 50,),

              Padding(
                padding: const EdgeInsets.only(left:60,right: 30,top: 30),
                child: SizedBox(
                  height: 50,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'value is empty';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value){
                      setState(() {
                        searchQuery=value;
                      });
                      searchInFirestore();

                    },
                    controller: _searchController,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),

                      hintText: 'Search......',
                      contentPadding: const EdgeInsets.only(left: 20),
                      filled: true,
                      fillColor: Colors.white,
                      suffixIcon:  Padding(
                        padding: EdgeInsets.all(8.0),
                        child: IconButton(icon:Icon(
                          Icons.search,size: 18,
                          color: Colors.grey,
                        ), onPressed: () {_searchController.clear();  },)
                      ),
                    ),
                  ),
                ),
              ),
              // ListView.builder(itemCount:searchResult.length,
              //     itemBuilder: (context,index){
              //   var documentData=searchResult[index].data() as Map<String,dynamic>;
              //   var fieldName=documentData['place']as String?;
              //   return ListTile(
              //     title: Text(fieldName??''),
              //   );
              // //     }),

              const   SizedBox(height: 40,),

              Center(
                child: ElevatedButton(
                  child: const Text('LogOut'),
                  onPressed: () {
                    _auth.signOut().then((value) {
                      // Navigator.pop(context);
                     Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignInScreen()));
                    });
                  },
                ),
              ),
              Text(_userName ??'',style: TextStyle(color: Colors.white),),

           SizedBox(
             height: 50,
             child: ListView.builder(
                 itemCount: 6,
                 itemBuilder: (BuildContext context,int index){
               return Text('data',style: TextStyle(color: Colors.white),);;
             }),
           )


            ],

          ),
        ),

      ),

      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Color(0xFF252010),
        color: Colors.white,
        animationDuration: Duration(milliseconds: 300),
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          CurvedNavigationBarItem(child: Icon(Icons.home), label: 'Home'),
          CurvedNavigationBarItem(child: Icon(Icons.people), label: 'People'),
          CurvedNavigationBarItem(
              child: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );

  }
  Widget MyDrawerList(){
    return Container(
      padding: EdgeInsets.only(
        top: 15,),
      child: Column(
        children: [
          menuItem(1,"Dashboard",Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2,"Notifications",Icons.notifications_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(3,"Messages",Icons.message_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          Divider(),
          menuItem(4,"Help",Icons.help_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(5,"Settings",Icons.settings_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          Divider(),
          menuItem(6,"Logout",Icons.logout_outlined,
              currentPage == DrawerSections.dashboard ? true : false),

        ],
      ),
    );
  }
  Widget menuItem(int id, String title, IconData icon, bool selected){
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
          onTap: (){
            Navigator.pop(context);
            setState(() {
              if(id == 1) {
                currentPage = DrawerSections.dashboard;
              }else if(id == 2) {
                currentPage = DrawerSections.notifications;
              }else if(id == 3) {
                currentPage = DrawerSections.messages;
              } else if(id == 4) {
                currentPage = DrawerSections.help;
              }else if(id == 5) {
                currentPage = DrawerSections.settings;
              }else if(id == 6) {
                currentPage = DrawerSections.help;
              }
            });
          },
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(
              children: [
                Expanded(
                  child:  Icon(
                    icon,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }




}

class HelpPage {
}

class MessagesPage {
}

class SettingsPage {
}

class NotificationsPage {
}



enum DrawerSections{
  dashboard,
  notifications,
  messages,
  help,
  settings,
}

