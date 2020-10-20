import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UsernamesUpdate extends StatefulWidget {
  @override
  _UsernamesUpdateState createState() => _UsernamesUpdateState();
}

class _UsernamesUpdateState extends State<UsernamesUpdate> {
  bool loading = false;
  StreamSubscription streamListener;
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
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

  @override
  void dispose() {
    // TODO: implement dispose
    streamListener.cancel();
    super.dispose();
  }

  Future update() async {
    var url = "http://192.168.1.69/update.php";
    var response = await http.post(url, body: {
      "email": email,
      "nom":_nomController.text,
      "prenom":_prenomController.text
    });
    var data = json.decode(response.body).toString().trim();
    if (data == "Success") {
      Navigator.pop(context, true);
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
            "Mettre à jour nom & prénom",
            style: TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w300,
                color: Colors.black),
          ),
        ),
        body: Container(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Nom",
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
                controller: _nomController,
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Text(
                    "Prénom",
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
                controller: _prenomController,
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
                          "Modifier",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      onPressed: () {
                        validation(true);
                      })
                ],
              )
            ],
          ),
        ));
  }

  validation(bool exists) {
    hideKeyboard();
    //testons si le champs de mail est vide
    if (_nomController.text != null && _nomController.text != "") {
      if (_prenomController.text != null && _prenomController.text != "") {
        if (exists) {
          update();
        }
      } else {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text("Veuillez saisir un prénom valide."),
          duration: Duration(seconds: 2),
        ));
      }
    } else {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Veuillez saisir un nom valide."),
        duration: Duration(seconds: 2),
      ));
    }
  }

  //cacher le clavier
  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
