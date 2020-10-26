import 'package:testcrud_mysql/models/Users.dart';
import 'package:http/http.dart' as http;

class UsersService {

  static const ADD_URL = "http://192.168.1.69/register.php";

  //fonction d'ajout utilisateur
  Future<String> addUser(Users users) async {
    final response = await http.post(ADD_URL, body: users.toJsonAdd());
    if(response.statusCode == 200){
      print("response : "+response.body);
      return response.body;
    }else{
      return response.body;
    }
  }

}