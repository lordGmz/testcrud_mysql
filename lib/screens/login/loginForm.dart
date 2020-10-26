import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcrud_mysql/screens/home/home.dart';
import 'package:testcrud_mysql/screens/register/registerPage.dart';
import 'package:http/http.dart' as http;

class OurLoginForm extends StatefulWidget {
  @override
  _OurLoginFormState createState() => _OurLoginFormState();
}

class _OurLoginFormState extends State<OurLoginForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  Future login() async {
    var url = "http://192.168.1.69/login.php";
    var response = await http.post(url, body: {
      "email": _emailController.text,
      "password": _passwordController.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data == "Success") {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('email', _emailController.text);
      Fluttertoast.showToast(
          msg: "Bienvenue !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OurHomePage()), (route) => false);
    } else {
      Flushbar(
        icon: Icon(
          Icons.error_outline,
          size: 28.0,
          color: Colors.red[300],
        ),
        margin: EdgeInsets.all(8),
        isDismissible: true,
        borderRadius: 8,
        title: "Oops !",
        message: "Infos incorrects ou compte non vérifié. Consultez votre boîte mail.",
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 8.0,
            ),
            child: Text(
              "Se connecter",
              style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold),
            ),
          ),

          //formulaire
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.alternate_email,
                  color: Colors.grey,
                ),
                hintText: "email"),
            validator: (val) {
              return EmailValidator.validate(_emailController.text)
                  ? null
                  : "Entrez un mail valide";
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.lock_outline,
                  color: Colors.grey,
                ),
                hintText: "mot de passe"),
            obscureText: true,
            validator: (val) {
              return val.isEmpty ? "Entez un mot de passe" : null;
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          //boutton de connexion
          RaisedButton(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: Text(
                "Connexion",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.0,
                ),
              ),
            ),
            onPressed: () {
              // signIn(true);
              login();
            },
          ),
          SizedBox(
            height: 10.0,
          ),
          //_googleButton(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pas de compte ?",
                style: TextStyle(fontSize: 10.0, color: Colors.black),
              ),
              FlatButton(
                child: Text(
                  "Inscrivez-vous.",
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.green,
                  ),
                ),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                padding: EdgeInsets.only(left: 10),
                onPressed: () async {
                  //route vers la page d'inscription
                  bool res = await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => OurRegisterPage()));
                  if (res != null && res == true) {
                    Flushbar(
                      icon: Icon(
                        Icons.verified,
                        size: 28.0,
                        color: Colors.green[300],
                      ),
                      margin: EdgeInsets.all(8),
                      borderRadius: 8,
                      title: "Connectez-Vous !",
                      message: "Compte créé avec succès.",
                      duration: Duration(seconds: 5),
                    )..show(context);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
