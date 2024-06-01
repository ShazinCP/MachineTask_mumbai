import 'package:flutter/material.dart';
import 'package:mumbai_machinetask/controller/auth_controller.dart';
import 'package:mumbai_machinetask/helper/colors.dart';
import 'package:mumbai_machinetask/services/auth_services.dart';
import 'package:mumbai_machinetask/view/widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  void Function()? onTap;
  RegisterScreen({super.key, required this.onTap});

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
                controller: provider.registerEmailController,
                hintText: "email...",
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
              ),
              TextFieldWidget(
                controller: provider.registerPasswordController,
                hintText: "password...",
                obscureText: false,
              ),
              TextFieldWidget(
                controller: provider.confirmPasswordController,
                hintText: "Confirm password...",
                obscureText: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?  ",
                      style: TextStyle(color: cGreyColor, fontSize: 13),
                    ),
                    TextButton(
                      onPressed: onTap,
                      child: Text(
                        "Login now",
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
                    register(context);
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
                      'Register',
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

  void register(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context, listen: false);
    final auth = AuthServices();
    if (provider.registerPasswordController.text ==
        provider.confirmPasswordController.text) {
      try {
        auth.signUpWithEmailPassword(
          provider.registerEmailController.text,
          provider.registerPasswordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Password don't match!"),
        ),
      );
    }
  }
}
