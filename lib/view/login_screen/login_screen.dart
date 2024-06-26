import 'package:flutter/material.dart';
import 'package:mumbai_machinetask/controller/auth_controller.dart';
import 'package:mumbai_machinetask/helper/colors.dart';
import 'package:mumbai_machinetask/services/auth_services.dart';
import 'package:mumbai_machinetask/view/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  void Function()? onTap;
  LoginScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, provider, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height / 28),
              const Text(
                "Taskify",
                style: TextStyle(
                  color: cWhiteColor,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 7,
                ),
              ),
              const SizedBox(height: 30),
              TextFieldWidget(
                controller: provider.loginEmailController,
                hintText: "email...",
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFieldWidget(
                controller: provider.loginPasswordController,
                hintText: "password...",
                obscureText: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Doesn't have an account?",
                      style: TextStyle(color: cGreyColor, fontSize: 13),
                    ),
                    TextButton(
                      onPressed: onTap,
                      child: Text(
                        "Register now",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: cGreyColor400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height / 15),
              SizedBox(
                width: 300,
                child: ElevatedButton(
                  onPressed: () {
                    login(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: cCyanColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: cWhiteColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void login(BuildContext context) async {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final authService = AuthServices();

    try {
      await authService.signInWithEmailPassword(
          provider.loginEmailController.text,
          provider.loginPasswordController.text);
    } catch (e) {
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }
}
