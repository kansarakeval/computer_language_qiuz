import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:main_flutter_exam/screen/category/model/category_model.dart';
import 'package:main_flutter_exam/screen/quiz/controller/quiz_controller.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  QuizController controller = Get.put(QuizController());

  @override
  void initState() {
    super.initState();
    CategoryModel m1 = Get.arguments;
    controller.getQuiz(m1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                'asset/img/b1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Main content
            Obx(
                  () {
                if (controller.quizList.value == null) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (controller.randomlyList.value == null ||
                    controller.randomlyList.value!.isEmpty) {
                  return const Center(
                    child: Text("No questions available",),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${controller.randomlyList.value![controller.index.value].question}",
                          style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        buttonTile(context, "${controller.randomlyList.value![controller.index.value].option![0]}"),
                        const SizedBox(height: 10),
                        buttonTile(context, "${controller.randomlyList.value![controller.index.value].option![1]}"),
                        const SizedBox(height: 10),
                        buttonTile(context, "${controller.randomlyList.value![controller.index.value].option![2]}"),
                        const SizedBox(height: 10),
                        buttonTile(context, "${controller.randomlyList.value![controller.index.value].option![3]}"),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  InkWell buttonTile(BuildContext context, String ans) {
    return InkWell(
      onTap: () {
        controller.getResult(ans);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white.withOpacity(0.8),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 315,
              child: Text(
                ans,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
