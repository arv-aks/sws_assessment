import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:sws_assessment/application/auth_controller.dart';
import 'package:sws_assessment/presentation/home_page.dart';
import 'package:sws_assessment/presentation/widgets/custom_loading.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Login'), elevation: 0.0),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Login via Google or Apple',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginButton(
                  icon: FontAwesomeIcons.google,
                  onPressed: () async {
                    await controller.signInWithGoogle().then((value) {
                      if (value) {
                        Get.offAll(const HomePage());
                      }
                    });
                  },
                ),
                const SizedBox(width: 20),
                LoginButton(
                  icon: FontAwesomeIcons.apple,
                  onPressed: ()  {
                     controller.signInWithApple();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(() => Visibility(
                  visible: controller.isLoading.value,
                  child: const CustomLoading(),
                ))
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  final IconData icon;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(width: 0.5, color: Colors.black45)),
          child: Icon(icon),
        ));
  }
}
