import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:main_flutter_exam/screen/category/model/category_model.dart';
import 'package:main_flutter_exam/screen/quiz/model/quiz_model.dart';

class ApiHelper {
  static ApiHelper apiHelper = ApiHelper._();

  ApiHelper._();

  //category
  Future<List<CategoryModel>?> categoryApi() async {
    //String apiLink = "http://192.168.2.11/larening%20quiz/api/creadapi.php";
    String apiLink = "http://192.168.31.177/larening%20quiz/api/creadapi.php";
    var response = await http.get(Uri.parse(apiLink));

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      List<CategoryModel> categoryList =
          json.map((e) => CategoryModel.mapToModel(e)).toList();
      return categoryList;
    } else {
      return null;
    }
  }

  //quiz
  Future<List<QuizModel>?> quizApi() async {
    //String apiLink = "http://192.168.2.11/larening%20quiz/api/readapi.php";
    String apiLink = "http://192.168.31.177/larening%20quiz/api/readapi.php";
    var response = await http.get(Uri.parse(apiLink));

    if (response.statusCode == 200) {
      List json = jsonDecode(response.body);
      List<QuizModel> quizList =
          json.map((e) => QuizModel.mapToModel(e)).toList();
      return quizList;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>> signUp(
      String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.31.177/larening%20quiz/user/signup.php'),
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final response = await http.post(
      Uri.parse('http://192.168.31.177/larening%20quiz/user/signin.php'),
      body: {
        'email': email,
        'password': password,
      },
    );
    return jsonDecode(response.body);
  }


  Future<void> logout() async {
    await http.post(
      Uri.parse('http://192.168.31.177/lARENING%20QUIZ/user/logout.php'),
    );
  }
}
