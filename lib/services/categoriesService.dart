import 'package:testcrud_mysql/models/Categories.dart';
import 'package:http/http.dart' as http;

class CategoriesServices{
  static const ADD_URL = "http://192.168.1.69/categories/insert_category.php?email=";

  //fonction d'ajout categorie
  Future<String> addCategory(Categories categories, String email) async {
    final response = await http.post(ADD_URL+email, body: categories.toJsonAdd());
    if(response.statusCode == 200){
      print("response : "+response.body);
      return response.body;
    }else{
      return response.body;
    }
  }
}