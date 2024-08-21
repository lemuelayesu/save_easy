import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:save_easy/models/user.dart';
import 'package:save_easy/screens/home.dart';
import 'package:save_easy/screens/log_in.dart';
import 'package:save_easy/services/auth_service.dart';
import 'package:uuid/uuid.dart';

import '../consts/snackbar.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool isPressed = false;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ColorScheme color = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Create your account',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "New User",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        prefixIcon: Icon(Iconsax.user),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      controller: nameController,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      expands: false,
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: "E-Mail",
                        prefixIcon: Icon(Iconsax.direct),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      expands: false,
                      controller: phoneController,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        prefixIcon: Icon(Iconsax.call),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      expands: false,
                      controller: passwordController,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        prefixIcon: Icon(Iconsax.key),
                        suffixIcon: IconButton(
                          onPressed: null,
                          icon: Icon(Iconsax.eye_slash),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      expands: false,
                      controller: confirmController,
                      decoration: const InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: Icon(Iconsax.key),
                        suffixIcon: IconButton(
                          onPressed: null,
                          icon: Icon(Iconsax.eye_slash),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      height: 54,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: WidgetStateProperty.all(0),
                          backgroundColor:
                              WidgetStateProperty.all(color.primary),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                        onPressed: () async {
                          try {
                            if (formKey.currentState!.validate()) {}

                            setState(() {
                              isPressed = true;
                            });

                            String name = nameController.text;
                            String email = emailController.text;
                            String number = phoneController.text;
                            String password = passwordController.text;

                            User user = User(
                              fullName: name,
                              email: email,
                              phoneNumber: number,
                              uid: const Uuid().v4(),
                            );

                            await AuthService.signUp(user, password, context);
                            showCustomSnackbar('Signed Up', context);

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Homepage();
                                },
                              ),
                            );

                            setState(() {
                              isPressed = false;
                            });
                          } catch (error) {
                            log('$error');
                            showCustomSnackbar('Error: $error', context);
                          }
                        },
                        child: Text(
                          "Create Account",
                          style: TextStyle(
                            color: color.surface,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Login();
                                },
                              ),
                            );
                          },
                          child: isPressed
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: color.surface,
                                  ),
                                )
                              : const Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
