import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_flutter_exam/utils/app_routes.dart';

void main(){
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: app_routes,
    )
  );
}