import 'package:flutter/material.dart';
import 'package:testcrud_mysql/screens/register/registerForm.dart';

class OurRegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      BackButton(),
                    ],
                  ),
                  SizedBox(height: 40.0,),
                  //Appel au formulaire d'inscription
                  OurRegisterForm(),
                ],
              )
          )
        ],
      ),
    );
  }
}
