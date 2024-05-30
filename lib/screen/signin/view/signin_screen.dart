import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:main_flutter_exam/utils/api_helper.dart';
import 'package:main_flutter_exam/utils/share_helper.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Image.asset('asset/img/Login-pana.png', height: 200),
              // Placeholder for logo
              const SizedBox(height: 40),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () async {
                  ShareHelper shr = ShareHelper();
                  Map log = await shr.getEmailPassword();

                  if (emailController.text == log['email'] &&
                      passwordController.text == log['password']) {
                    await shr.setLoginLogout(true);
                    final response = await ApiHelper.apiHelper.signIn(
                      emailController.text,
                      passwordController.text,
                    );
                    Get.offAllNamed('category');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Email and password invalid")));
                  }
                },
                // async {
                //   final response = await ApiHelper.apiHelper.signIn(
                //     emailController.text,
                //     passwordController.text,
                //   );
                //   Get.offAllNamed('category');
                // },
                child: const Text('Sign In'),
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  Get.toNamed('signUp');
                },
                child: const Text(
                  "Create new account? Sign Up",
                  style: TextStyle(
                      color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
