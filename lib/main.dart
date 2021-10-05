import 'package:crud/pages/AddTodo.dart';
import 'package:crud/pages/HomePage.dart';
import 'package:crud/pages/SignInPage.dart';
import 'package:crud/services/Auth_Services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/material.dart';
import 'package:crud/pages/SignUpPage.dart';
import '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AuthClass authClass = AuthClass();
  Widget currentPage = SignUpPage();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  checkLogin() async {
    String tokne = await authClass.getToken();
    print(tokne);
    if (tokne != null)
      setState(() {
        currentPage = HomePage();
      });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
