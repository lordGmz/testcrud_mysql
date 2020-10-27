import 'package:testcrud_mysql/models/Products.dart';
import 'package:http/http.dart' as http;

class ProductsServices{
  static const ADD_URL = "http://192.168.1.69/products/insert_product.php?email=";

  //fonction d'ajout categorie
  Future<String> addProduct(Products products, String email) async {
    final response = await http.post(ADD_URL+email, body: products.toJsonAdd());
    if(response.statusCode == 200){
      print("response : "+response.body);
      return response.body;
    }else{
      return response.body;
    }
  }
}