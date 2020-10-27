import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testcrud_mysql/models/Categories.dart';
import 'package:testcrud_mysql/services/categoriesService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OurCategory extends StatefulWidget {
  @override
  _OurCategoryState createState() => _OurCategoryState();
}

class _OurCategoryState extends State<OurCategory> {
  TextEditingController _categoryNameController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  List data = [];

  String email = "";

  Future<List> getAllCategories() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
    });
    final response = await http.get(
        'http://192.168.1.69/categories/all_categories.php?email=' + email);
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
      print(data);
      return data;
    } else {
      print("error");
    }
  }

  //add category function
  addCat(Categories categories) async {
    var res = await CategoriesServices().addCategory(categories, email);
    if (res == "Error") {
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
        message: "Cette catégorie existe déjà.",
        duration: Duration(seconds: 2),
      )..show(context);
    } else {
      setState(() {
          getAllCategories();
          _categoryNameController.text = "";
      });
      Fluttertoast.showToast(
          msg: "Catégorie ajoutée !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

 Future deleteCat(String i) async{
   var urlDeleteCat = "http://192.168.1.69/categories/delete_category.php";
   var res = await http.post(urlDeleteCat, body: {
     "id": i,
   });
   var dataP = json.decode(res.body).toString().trim();
   if (dataP == "Success") {
     setState(() {
       getAllCategories();
     });
     Fluttertoast.showToast(
         msg: "Catégorie supprimée.",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.black45,
         textColor: Colors.white,
         fontSize: 10.0);
   }else {
     Fluttertoast.showToast(
         msg: "Une erreur s'est produite.",
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor: Colors.black45,
         textColor: Colors.white,
         fontSize: 16.0);
   }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Mes catégories de produit",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: EdgeInsets.only(left: 10.0, right: 10.0),
                      child: TextFormField(
                        controller: _categoryNameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.category_outlined,
                              color: Colors.grey,
                            ),
                            hintText: "nouvelle catégorie"),
                        validator: (val) {
                          return val.isEmpty
                              ? "Entrez un nom de catégorie"
                              : null;
                        },
                      ),
                    )),
              ),
              Container(
                padding: EdgeInsets.only(right: 10.0),
                child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      "Enregistrer",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.green,
                    onPressed: () {
                      Categories cat = Categories(
                        category_name: _categoryNameController.text,
                      );
                      addCat(cat);
                    }),
              )
            ],
          ),
          Expanded(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text(data[index]['category_name']),
                    trailing: RaisedButton(
                        elevation: 0.0,
                        color: Colors.transparent,
                        child: Icon(Icons.delete_rounded),
                        onPressed: () {
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "Supprimer cette catégorie?",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Oui",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800),
                                ),
                                onPressed: () {
                                  deleteCat(data[index]['id']);
                                  Navigator.pop(context);
                                },
                                width: 120,
                                color: Colors.red,
                              )
                            ],
                          ).show();

                        }),
                  );
                },
              ))
        ],
      ),
    );
  }
}
