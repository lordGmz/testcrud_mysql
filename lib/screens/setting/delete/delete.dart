import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:testcrud_mysql/screens/login/loginPage.dart';

class DeleteAccount extends StatefulWidget {
  @override
  _DeleteAccountState createState() => _DeleteAccountState();
}

class _DeleteAccountState extends State<DeleteAccount> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
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

  Future deleteAccount() async {
    var url_login = "http://192.168.1.69/login.php";
    var url_delete_account = "http://192.168.1.69/deleteUser.php";
    var response = await http.post(url_login, body: {
      "email": email,
      "password": _passwordController.text,
    });
    var data = json.decode(response.body).toString().trim();
    if (data == "Success") {
      var res = await http.post(url_delete_account, body: {
        "email": email,
      });
      var data_p = json.decode(res.body).toString().trim();
      if (data_p == "Success") {
        Fluttertoast.showToast(
            msg: "Votre compte a été supprimé.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => OurLoginPage()),
            (route) => false);
      }
    } else {
      Fluttertoast.showToast(
          msg: "Une erreur s'est produite.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Supprimer votre compte",
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.w300, color: Colors.red),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Entrez votre mot de passe pour procéder à la suppression.",
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w300,
                        color: Colors.red),
                  )
                ],
              ),
              SizedBox(
                height: 5.0,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock, color: Colors.grey),
                ),
                validator: (val) {
                  return val.isEmpty
                      ? "Ce champs ne peut pas être vide."
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
                      color: Colors.red,
                      onPressed: () async {
                        Alert(
                          context: context,
                          type: AlertType.warning,
                          title: "Supprimer votre compte ?",
                          desc:
                              "Votre compte sera supprimé, toutes vos données seront effacées. Voulez vous vraiment continuer ?",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Valider",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800),
                              ),
                              onPressed: () {
                                deleteAccount();
                              },
                              width: 120,
                              color: Colors.red,
                            )
                          ],
                        ).show();
                      })
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
