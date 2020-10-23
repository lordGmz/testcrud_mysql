import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcrud_mysql/screens/login/loginPage.dart';
import 'package:testcrud_mysql/screens/setting/settingPage.dart';
import 'package:http/http.dart' as http;

class OurHomePage extends StatefulWidget {
  @override
  _OurHomePageState createState() => _OurHomePageState();
}

class _OurHomePageState extends State<OurHomePage> {
  String email = "";
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  List data = [];

  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
    });
  }

  Future<List> fetchData() async {
    final response = await http.get('http://192.168.1.69/getuser.php?email='+email);
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
      //print(data);
      return data;
    }else{
      print("error");
    }
  }


  Future logout(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    Fluttertoast.showToast(
        msg: "Vous êtes à présent hors ligne.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => OurLoginPage()),
        (route) => false);

  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 0.0,
      key: _drawerKey,
      appBar: AppBar(
        title: Text("Accueil"),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.menu_rounded),
          onPressed: (){
            fetchData();
            _drawerKey.currentState.openDrawer();
            },
        ),
      ),
      drawer: new Drawer(

        child: ListView(
          children: <Widget>[

            new DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.green,
                  Colors.greenAccent,
                  Colors.greenAccent,
                  Colors.green,
                ]),
              ),
              child: Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        child: data.length>0  && data[0]["imageUrl"]!="vide" ? Image.network("http://192.168.1.69/profile_photos/"+data[0]["imageUrl"],
                            height: 75, width: 75) : Image.asset("assets/avatar.jpg", height: 75, width: 75,),
                      ),
                    ),
                    Text(
                      data.length>0 ? data[0]["nom"]+" "+data[0]["prenom"] : "",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
            new ListTile(
              title: new Text('Mes abonnements'),
              trailing: Icon(
                Icons.people_outline,
                color: Colors.green,
              ),
              //en appuyant sur notes on iras sur sa page
              onTap: () {
              },
            ),
            new Divider(
              color: Colors.black45,
              height: 0.50,
            ),
            new ListTile(
              title: new Text('Paramètres'),
              trailing: Icon(
                Icons.settings,
                color: Colors.green,
              ),
              //en appuyant sur notes on iras sur sa page
              onTap: () {
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) =>
                            new OurSettingPage()));
              },
            ),
            new Divider(
              color: Colors.black45,
              height: 0.50,
            ),
            new ListTile(
              title: new Text('Déconnexion'),
              trailing: Icon(
                Icons.exit_to_app,
                color: Colors.green,
              ),
              //en appuyant sur notes on iras sur sa page
              onTap: () async {
                logout(context);
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Page d'accueil",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),
        ],
      ),
      /*floatingActionButton: Container(
        height: 100,
        width: 100,
        child: FloatingActionButton(
          elevation: 10.0,
          onPressed: () {
            // Add your onPressed code here!
          },
          child: new Container(
              width: 100,
              height: 100,
              child: new Image.asset("assets/scan.png")),
          backgroundColor: Colors.red,
        ),
      ),*/
    );
  }
}
