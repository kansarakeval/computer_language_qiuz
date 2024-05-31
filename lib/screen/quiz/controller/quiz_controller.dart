import 'dart:async';
import 'package:get/get.dart';
import 'package:main_flutter_exam/screen/quiz/model/quiz_model.dart';
import 'package:main_flutter_exam/utils/api_helper.dart';
import '../../category/model/category_model.dart';

class QuizController extends GetxController {
  Rxn<List<QuizModel>> quizList = Rxn<List<QuizModel>>();
  RxInt index = 0.obs;
  Rxn<List<RandomlyModel>> randomlyList = Rxn();
  RxInt checkAns = 1.obs;
  RxInt timeLeft = 20.obs;
  Timer? timer;
  CategoryModel? selectedCategory;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }


  Future<void> getQuiz(CategoryModel category) async {
    selectedCategory = category;
    List<QuizModel>? list = await ApiHelper.apiHelper.quizApi();
    quizList.value = list?.where((element) => element.category == category.id).toList();
    randomData();
  }

  void randomData() {
    if (quizList.value != null && quizList.value!.isNotEmpty) {
      List<RandomlyModel> result = [];
      for (QuizModel q1 in quizList.value!) {
        List allOption = [q1.A, q1.B, q1.C, q1.D];
        allOption.shuffle();

        RandomlyModel r1 = RandomlyModel(
          question: q1.qus,
          correct_answer: q1.A,
          option: allOption,
        );
        result.add(r1);
      }
      randomlyList.value = result;
    } else {
      randomlyList.value = [];
    }
    update();
    startTimer();
  }

  void startTimer() {
    timeLeft.value = 20;
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    if (index.value < randomlyList.value!.length - 1) {
      index++;
      startTimer();
    } else {
      Get.offAllNamed("result");
      timer?.cancel();
    }
  }

  void getResult(String answer) {
    if (randomlyList.value != null && randomlyList.value!.isNotEmpty) {
      if (answer == randomlyList.value![index.value].correct_answer) {
        checkAns.value++;
      }
      nextQuestion();
    }
  }
}
