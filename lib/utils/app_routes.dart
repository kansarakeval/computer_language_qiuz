import 'package:flutter/material.dart';
import 'package:main_flutter_exam/screen/category/view/category_screen.dart';
import 'package:main_flutter_exam/screen/quiz/view/quiz_screen.dart';
import 'package:main_flutter_exam/screen/result/view/result_screen.dart';
import 'package:main_flutter_exam/screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> app_routes = {
  '/': (context) => const SplashScreen(),
  'category': (context) => const CategoryScreen(),
  'quiz': (context) => const QuizScreen(),
  'result': (context) => const ResultScreen(),
};
