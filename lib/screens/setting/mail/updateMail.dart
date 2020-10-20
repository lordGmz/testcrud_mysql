import 'package:flutter/material.dart';

class UpdateMail extends StatefulWidget {
  @override
  _UpdateMailState createState() => _UpdateMailState();
}

class _UpdateMailState extends State<UpdateMail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Mettre à jour le mail",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: Colors.black),
          ),
        )
    );
  }
}
