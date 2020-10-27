import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:testcrud_mysql/models/Products.dart';
import 'package:testcrud_mysql/services/productsServices.dart';

class OurProductPage extends StatefulWidget {
  @override
  _OurProductPageState createState() => _OurProductPageState();
}

class _OurProductPageState extends State<OurProductPage> {
  TextEditingController _productNameController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  List data = [];
  List dataP = [];
  String _idCategory;

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

  //add product function
  addProd(Products products) async {
    var res = await ProductsServices().addProduct(products, email);
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
        message: "Une erreur s'est produite.",
        duration: Duration(seconds: 2),
      )..show(context);
    } else {
      setState(() {
        getAllProducts();
        _productNameController.text = "";
      });
      Fluttertoast.showToast(
          msg: "Produit ajoutée !",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black45,
          textColor: Colors.white,
          fontSize: 10.0);
    }
  }

  Future<List> getAllProducts() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences.getString('email');
    });
    final response = await http
        .get('http://192.168.1.69/products/all_products.php?email=' + email);
    if (response.statusCode == 200) {
      setState(() {
        dataP = json.decode(response.body);
      });
      print(dataP);
      return dataP;
    } else {
      print("error");
    }
  }


  Future deleteProd(String i) async{
    var urlDeleteCat = "http://192.168.1.69/products/delete_product.php";
    var res = await http.post(urlDeleteCat, body: {
      "id": i,
    });
    var dataP = json.decode(res.body).toString().trim();
    if (dataP == "Success") {
      setState(() {
        getAllProducts();
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

    super.initState();
    getAllCategories();
    getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Mes produits",
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w300, color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Padding(
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(5.0),
                        child: DropdownButton(
                          isExpanded: true,
                          items: data?.map((item) {
                            return new DropdownMenuItem(
                              child: new Text(item['category_name']),
                              value: item['id'].toString(),
                            );
                          })?.toList() ??
                              [],
                          value: _idCategory,
                          iconSize: 18,
                          icon: Icon(Icons.arrow_circle_down_outlined),
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          hint: Text('Sélectionnez une catégorie'),
                          onChanged: (value) {
                            setState(() {
                              _idCategory = value;
                              print(value);
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      TextFormField(
                        controller: _productNameController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.bar_chart,
                              color: Colors.grey,
                            ),
                            hintText: "nouveau produit"),
                        validator: (val) {
                          return val.isEmpty
                              ? "Entrez un nom de produit"
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ButtonTheme(
                        minWidth: double.infinity,
                        child: FlatButton(
                          padding: EdgeInsets.all(15.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              "Enregistrer",
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                            color: Colors.green,
                            onPressed: () {
                              Products prod = Products(
                                product_name: _productNameController.text,
                                id_category: _idCategory,
                              );
                              addProd(prod);
                            }),
                      )
                    ],
                  ))),

          Expanded(
              child: ListView.builder(
                itemCount: dataP.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    contentPadding: EdgeInsets.all(10.0),
                    title: Text(dataP[index]['product_name']),
                    subtitle: Text(dataP[index]['category_name']),
                    trailing: RaisedButton(
                        elevation: 0.0,
                        color: Colors.transparent,
                        child: Icon(Icons.delete_rounded),
                        onPressed: () {
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "Supprimer ce produit?",
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
                                  deleteProd(dataP[index]['id']);
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
/*TextFormField(
  controller: _productNameController,
  decoration: InputDecoration(
  prefixIcon: Icon(
  Icons.category_outlined,
  color: Colors.grey,
  ),
  hintText: "nouveau produit"),
  validator: (val) {
  return val.isEmpty
  ? "Entrez un nom de produit"
      : null;
  },
  ),*/
/*
  DropdownButton(
  items: data?.map((item) {
  return new DropdownMenuItem(
  child: new Text(item['category_name']),
  value: item['id'].toString(),
  );
  })?.toList() ??
  [],
  value: _idCategory,
  iconSize: 30,
  icon: (null),
  style: TextStyle(
  color: Colors.black54,
  fontSize: 16,
  ),
  hint: Text('Sélectionnez une catégorie'),
  onChanged: (value) {
  setState(() {
  _idCategory = value;
  print(value);
  });
  },
  ),*/
}
