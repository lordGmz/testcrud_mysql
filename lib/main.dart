import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcrud_mysql/screens/home/home.dart';
import 'package:testcrud_mysql/screens/login/loginPage.dart';
import 'package:testcrud_mysql/utils/ourTheme.dart';
import 'package:flutter_session/flutter_session.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  String email = preferences.getString('email');
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: OurTheme().buildTheme(),
    home: email == null ? OurLoginPage() : OurHomePage(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: OurTheme().buildTheme(),
      home: OurLoginPage(),
    );
  }
}
