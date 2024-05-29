import 'package:get/get.dart';
import 'package:main_flutter_exam/screen/category/model/category_model.dart';
import 'package:main_flutter_exam/utils/api_helper.dart';

class CategoryController extends GetxController{
  Rxn<List<CategoryModel>> categoryList = Rxn<List<CategoryModel>>();

  Future<void> getCategory() async {
    List<CategoryModel>? list = await ApiHelper.apiHelper.categoryApi();
    categoryList.value = list;
  }

}