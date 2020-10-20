import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testcrud_mysql/screens/login/loginForm.dart';

class OurLoginPage extends StatelessWidget {
  var now = DateTime.now().hour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Text(
                      now < 12 ? "Bonjour" : "Bonsoir",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 50,
                          color: Colors.black),
                    ),
                  ),
                  Text(
                    ".",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                        color: Colors.green),
                  ),
                  Text(
                    ".",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                        color: Colors.black),
                  ),
                  Text(
                    ".",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 50,
                        color: Colors.green),
                  ),
                ],
              ),

            ],
          ),
          Container(
            padding: EdgeInsets.all(20.0),
            child: OurLoginForm(),
          )
        ],
      ),
    );
  }
}
