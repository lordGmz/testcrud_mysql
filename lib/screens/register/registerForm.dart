import 'package:email_validator/email_validator.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testcrud_mysql/models/Users.dart';
import 'package:testcrud_mysql/services/usersService.dart';
import 'package:testcrud_mysql/utils/ourRandomString.dart';
import 'package:testcrud_mysql/utils/ourVerifyMail.dart';

class OurRegisterForm extends StatefulWidget {
  @override
  _OurRegisterFormState createState() => _OurRegisterFormState();
}

class _OurRegisterFormState extends State<OurRegisterForm> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _prenomController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  var accout_token = getRandomString(15);


  //ajout
  addUsers(Users users) async {
    var res = await UsersService().addUser(users);
    if(res == "Error"){
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
        message: "Email déjà utilisé.",
        duration: Duration(seconds: 5),
      )..show(context);
    }else{
      Navigator.pop(context, true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
                horizontal: 8.0,
              ),
              child: Text("S'Inscrire !",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 50.0,
                      fontWeight: FontWeight.w700)),
            )
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    //formulaire
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.alternate_email,
                            color: Colors.grey,
                          ),
                          hintText: "email"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: _nomController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "nom"),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: _prenomController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "prénom"),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "mot de passe"),
                      obscureText: true,
                      validator: (value) {
                        return value.length < 8
                            ? "Le mot de passe doit avoir au moins 8 caractères"
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock_open),
                          hintText: "confirmer le mot de passe"),
                      obscureText: true,
                      validator: (value) {
                        return value != _passwordController.text
                            ? "Les mots de passe ne correspondent pas."
                            : null;
                      },
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    //boutton de connexion
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RaisedButton(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 100),
                            child: Text(
                              "Enregistrer",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          onPressed: () {
                            // signIn(true);
                            registerUser(true);
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  //fonction de validation des champs d'inscription
  registerUser(bool exists) {
    hideKeyboard();
    //testons si le champs de mail est vide
    if (_emailController.text != null &&
        _emailController.text != "" &&
        EmailValidator.validate(_emailController.text)) {
      //testons si le champs nom est vide
      if (_nomController.text != null && _nomController.text != "") {
        //testons si le champs prenom est vide
        if (_prenomController.text != null && _prenomController.text != "") {
          //testons si le champs de mdp est vide
          if (_passwordController.text != null &&
              _passwordController.text != "") {
            //test si le champs de confirmation de mdp est vide
            if (_confirmPasswordController.text != null &&
                _confirmPasswordController.text != "") {
              if (_passwordController.text == _confirmPasswordController.text) {
                //fonction de connexion
                if (exists) {
                  if(_nomController.text.isNotEmpty){
                    Users users = Users(
                      email: _emailController.text,
                      nom: _nomController.text,
                      prenom: _prenomController.text,
                      password: _passwordController.text,
                      role: "client",
                      imageUrl: "vide",
                      account_token: accout_token,
                      account_state: "0",
                    );
                    setState(() {
                      sendMail(accout_token, _emailController.text);
                    });
                    addUsers(users);
                  }
                }
                //fin fonction
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
                  message: "Les mot de passe ne correspondent pas.",
                  duration: Duration(seconds: 5),
                )..show(context);
              }
              //
            } else {
              //
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
                message: "Confirmez le mot de passe.",
                duration: Duration(seconds: 5),
              )..show(context);
            }
          } else {
            //
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
              message: "Entrez un mot de passe.",
              duration: Duration(seconds: 5),
            )..show(context);
          }
        } else {
          //
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
            message: "Le prénom ne peut pas être vide.",
            duration: Duration(seconds: 5),
          )..show(context);
        }
      } else {
        //
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
          message: "Le nom ne peut pas être vide.",
          duration: Duration(seconds: 5),
        )..show(context);
      }
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
        message: "Veuillez saisir une addresse mail valide.",
        duration: Duration(seconds: 5),
      )..show(context);
    }
  }

  //cacher le clavier
  hideKeyboard() {
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
