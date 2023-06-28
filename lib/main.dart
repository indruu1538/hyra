import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:himi/screens/signin_screen.dart';
import 'package:himi/screens/splash.dart';

void main()async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'himi',
      theme: ThemeData(
        primarySwatch: Colors.green,
      
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
       // useMaterial3: true,
      ),
      home:const SplashScreen() ,
    );
  }
}
