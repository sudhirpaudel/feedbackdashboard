// ignore_for_file: unused_import

import 'package:feedbackdashboard/dashboard.dart';
import 'package:feedbackdashboard/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCRkdiutWArqCKN6fg3QNOMlZzVefD4E5Y",
        appId: "1:526251298409:web:35ee0a16a5aa78f0dbdcf8",
        messagingSenderId: "526251298409",
        projectId: "feedbackandcomplains",
        storageBucket: "feedbackandcomplains.appspot.com",
      ),
    );
  } else {
    Firebase.initializeApp();
  }

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
