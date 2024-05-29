import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:main_flutter_exam/screen/category/model/category_model.dart';
import 'package:main_flutter_exam/screen/quiz/model/quiz_model.dart';

class ApiHelper{
  static ApiHelper apiHelper=ApiHelper._();

  ApiHelper._();

  //category
  Future<List<CategoryModel>?> categoryApi() async {
    String apiLink = "http://192.168.2.11/larening%20quiz/api/creadapi.php";
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
    String apiLink = "http://192.168.2.11/larening%20quiz/api/readapi.php";
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
}