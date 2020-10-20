import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdatePassword extends StatefulWidget {
  @override
  _UpdatePasswordState createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String email = "";

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmail();
  }
  Future updatePassword() async {
    var url_login = "http://192.168.1.69/login.php";
    var url_update_password = "http://192.168.1.69/updatePassword.php";
    var response = await http.post(url_login, body: {
      "email": email,
      "password":_oldPasswordController.text,
    });
    var data = json.decode(response.body).toString().trim();
    if (data == "Success") {
      var res = await http.post(url_update_password, body: {
        "email": email,
        "password":_newPasswordController.text,
      });
      var data_p = json.decode(res.body).toString().trim();
      if(data_p =="Success"){
        Navigator.pop(context, true);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Une erreur s'est produite.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Mettre à jour le mot de passe",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Ancien mot de passe",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _oldPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.grey),
                  ),
                  validator: (value) {
                    return value.isEmpty
                        ? "Donnez l'ancien mot de passe."
                        : null;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      "Nouveau mot de passe",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _newPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                  return value.length < 8
                      ? "Le mot de passe doit avoir au moins 8 caractères"
                      : null;
                },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Text(
                      "Confirmer le nouveau mot de passe",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w300,
                          color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0,
                ),
                TextFormField(
                  controller: _confirmNewPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: Icon(
                    Icons.lock_open_rounded,
                    color: Colors.grey,
                  )),
                    validator: (value) {
                      return value != _newPasswordController.text
                          ? "Les mots de passe ne correspondent pas."
                          : null;
                    },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Confirmer",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        onPressed: () async {
                          updatePassword();
                        })
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
