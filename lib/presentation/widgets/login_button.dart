import 'package:flutter/material.dart';

import '../../main.dart';
import '../../service/auth_service.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () async {
          if (!formKey.currentState!.validate()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Somthing went wrong'),
              ),
            );
          } else {
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: ((context) => const Center(
                      child: CircularProgressIndicator(),
                    )));

            await AuthService().loginWithEmailandPassword(
                emailController.text.trim(), passwordController.text);

            myNavigatorKey.currentState!.popUntil((route) => route.isFirst);
          }
        },
        child: Container(
          height: 50,
          width: 350,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(15)),
          child: const Center(
            child: Text(
              'Login',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
