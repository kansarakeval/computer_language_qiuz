import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_flutter_exam/utils/share_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool? introStatus;

  @override
  void initState() {
    super.initState();
    createdata();

    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
    );

    controller.forward();

    Future.delayed(
      const Duration(seconds: 3),
          () {
        Get.offAllNamed(introStatus == false || introStatus == null ? 'signIn' : 'category');
      },
    );
  }

  void createdata() async {
    ShareHelper shr = ShareHelper();
    introStatus = await shr.getLoginStatus();

  }

  @override
  void dispose() {
    controller.dispose();
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
                'asset/img/s1.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Animated logo
            Center(
              child: FadeTransition(
                opacity: animation,
                child: Image.asset(
                  "asset/img/l1.png",
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
