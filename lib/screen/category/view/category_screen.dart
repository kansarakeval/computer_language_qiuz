import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:main_flutter_exam/screen/category/controller/category_controller.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> with SingleTickerProviderStateMixin {
  CategoryController controller = Get.put(CategoryController());
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    controller.getCategory();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'asset/img/b1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                AppBar(
                  title: const Text("Language"),
                  centerTitle: true,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                Expanded(
                  child: Obx(
                        () => controller.categoryList.value == null
                        ? const Center(
                      child: CircularProgressIndicator(),
                    )
                        : ListView.builder(
                      itemCount: controller.categoryList.value!.length,
                      itemBuilder: (context, index) {
                        return _animatedListItem(context, controller.categoryList.value![index], index);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _animatedListItem(BuildContext context, dynamic category, int index) {
    final animation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        (1 / 20) * index,
        1.0,
        curve: Curves.easeInOut,
      ),
    ));

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return SlideTransition(
          position: animation,
          child: AnimatedOpacity(
            opacity: _animationController.value,
            duration: const Duration(milliseconds: 500),
            child: child,
          ),
        );
      },
      child: ListTile(
        onTap: () {
          Get.toNamed("quiz", arguments: category);
        },
        title: Text(
          "${category.category}",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: const Icon(Icons.navigate_next),
      ),
    );
  }
}
