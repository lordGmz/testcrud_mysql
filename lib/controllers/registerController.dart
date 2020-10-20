import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterController{
  Future register (String email_user, String nom_user, String prenom_user, String password_user) async{
    var url = "http://192.168.1.69/register.php";
    var response = await http.post(url,body:{
      "email_user" : email_user,
      "nom_user" : nom_user,
      "prenom_user" : prenom_user,
      "password_user" : password_user
    }
    );
    var data = json.decode(response.body);
    return data;
  }
}