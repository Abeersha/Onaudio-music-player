

import 'package:audio3/splash_screen.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}
void permission(){
  Permission.storage.request();
  
  }

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  

  @override
  Widget build(BuildContext context) {
    permission();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
       
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }

}

