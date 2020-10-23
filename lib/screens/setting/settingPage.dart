import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testcrud_mysql/screens/setting/password/updatePassword.dart';
import 'package:testcrud_mysql/screens/setting/profile/profile.dart';
import 'package:testcrud_mysql/screens/setting/usernames/updateUserNames.dart';
import 'delete/delete.dart';

class OurSettingPage extends StatefulWidget {
  @override
  _OurSettingPageState createState() => _OurSettingPageState();
}

class _OurSettingPageState extends State<OurSettingPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            "Paramètres du compte",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                color: Colors.black),
          ),
        ),
        body: GridView.count(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: EdgeInsets.all(10),
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
          children: <Widget>[
            ListTile(
              title: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        "Nom & Prénom",
                        style: TextStyle(
                          fontWeight: FontWeight.w200,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.person_outline,
                      size: 50,
                    )
                  ],
                ),
              ),
              onTap: () async {
                bool res = await Navigator.push(
                    context,
                    // Create the SelectionScreen in the next step.
                    MaterialPageRoute(builder: (context) => UpdateUserNames()));
                if (res != null && res == true) {
                  Flushbar(
                    message: "Votre profil a été mis à jour.",
                    duration: Duration(seconds: 3),
                  )..show(context);
                }
              },
            ),
            ListTile(
              title: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Mot de passe",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.lock_outline,
                        size: 50,
                      )
                    ],
                  )),
              onTap: () async {
                bool res = await Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new UpdatePassword()));
                if (res != null && res == true) {
                  Flushbar(
                    icon: Icon(
                      Icons.verified_outlined,
                      size: 28.0,
                      color: Colors.green[300],
                    ),
                    margin: EdgeInsets.all(8),
                    isDismissible: true,
                    borderRadius: 8,
                    title: "Succès",
                    message: "Votre mot de passe a été mis à jour.",
                    duration: Duration(seconds: 3),
                  )..show(context);
                }
              },
            ),
            ListTile(
              title: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.white,
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Photo de profil",
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 15.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.account_circle,
                        color: Colors.black,
                        size: 50,
                      )
                    ],
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                        new OurProfileImage()));
              },
            ),
            ListTile(
              title: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Colors.red,
                  elevation: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Supprimer",
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.delete_forever,
                        color: Colors.white,
                        size: 50,
                      )
                    ],
                  )),
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new DeleteAccount()));
              },
            ),
          ],
        ));
  }
}

//
//class OurSettingPage extends StatelessWidget {
//  //declaration of image variable
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//        appBar: AppBar(
//          elevation: 0,
//          backgroundColor: Colors.transparent,
//          title: Text(
//            "Paramètres du compte",
//            style: TextStyle(
//                fontSize: 20.0,
//                fontWeight: FontWeight.w300,
//                color: Colors.black),
//          ),
//        ),
//        body: GridView.count(
//          scrollDirection: Axis.vertical,
//          shrinkWrap: true,
//          padding: EdgeInsets.all(10),
//          crossAxisCount: 2,
//          crossAxisSpacing: 15,
//          mainAxisSpacing: 15,
//          children: <Widget>[
//            ListTile(
//              title: Card(
//                shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(20)),
//                color: Colors.white,
//                elevation: 5,
//                child: Column(
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: [
//                    Container(
//                      alignment: Alignment.center,
//                      padding: EdgeInsets.all(10.0),
//                      child: Text(
//                        "Nom & Prénom",
//                        style: TextStyle(
//                          fontWeight: FontWeight.w200,
//                          fontSize: 15.0,
//                        ),
//                      ),
//                    ),
//                    Icon(
//                      Icons.person_outline,
//                      size: 50,
//                    )
//                  ],
//                ),
//              ),
//              onTap: () async {
//                bool res = await Navigator.push(
//                    context,
//                    // Create the SelectionScreen in the next step.
//                    MaterialPageRoute(builder: (context) => UpdateUserNames()));
//                if (res != null && res == true) {
//                  Flushbar(
//                    message: "Votre profil a été mis à jour.",
//                    duration: Duration(seconds: 3),
//                  )..show(context);
//                }
//              },
//            ),
//            ListTile(
//              title: Card(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(20)),
//                  color: Colors.white,
//                  elevation: 5,
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Container(
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.all(10.0),
//                        child: Text(
//                          "Mot de passe",
//                          style: TextStyle(
//                            fontWeight: FontWeight.w200,
//                            fontSize: 15.0,
//                          ),
//                        ),
//                      ),
//                      Icon(
//                        Icons.lock_outline,
//                        size: 50,
//                      )
//                    ],
//                  )),
//              onTap: () async {
//                bool res = await Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (BuildContext context) =>
//                            new UpdatePassword()));
//                if (res != null && res == true) {
//                  Flushbar(
//                    icon: Icon(
//                      Icons.verified_outlined,
//                      size: 28.0,
//                      color: Colors.green[300],
//                    ),
//                    margin: EdgeInsets.all(8),
//                    isDismissible: true,
//                    borderRadius: 8,
//                    title: "Succès",
//                    message: "Votre mot de passe a été mis à jour.",
//                    duration: Duration(seconds: 3),
//                  )..show(context);
//                }
//              },
//            ),
//            ListTile(
//              title: Card(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(20)),
//                  color: Colors.white,
//                  elevation: 5,
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Container(
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.all(10.0),
//                        child: Text(
//                          "Photo de profil",
//                          style: TextStyle(
//                            fontWeight: FontWeight.w200,
//                            fontSize: 15.0,
//                            color: Colors.black,
//                          ),
//                        ),
//                      ),
//                      Icon(
//                        Icons.account_circle,
//                        color: Colors.black,
//                        size: 50,
//                      )
//                    ],
//                  )),
//              onTap: () {
//
//              },
//            ),
//            ListTile(
//              title: Card(
//                  shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(20)),
//                  color: Colors.red,
//                  elevation: 5,
//                  child: Column(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: [
//                      Container(
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.all(10.0),
//                        child: Text(
//                          "Supprimer",
//                          style: TextStyle(
//                            fontWeight: FontWeight.w400,
//                            fontSize: 15.0,
//                            color: Colors.white,
//                          ),
//                        ),
//                      ),
//                      Icon(
//                        Icons.delete_forever,
//                        color: Colors.white,
//                        size: 50,
//                      )
//                    ],
//                  )),
//              onTap: () {
//                Navigator.push(
//                    context,
//                    new MaterialPageRoute(
//                        builder: (BuildContext context) =>
//                        new DeleteAccount()));
//              },
//            ),
//          ],
//        ));
//  }
//}
