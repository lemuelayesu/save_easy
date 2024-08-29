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
  bool _isObscured = true;

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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        } else if (value.split(' ').length < 2) {
                          return 'Please enter at least two names';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your phone number';
                        } else if (!value.startsWith('0') ||
                            value.length != 10) {
                          return 'Enter a valid 10-digit phone number. Start with 0';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: _isObscured,
                      expands: false,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Iconsax.key),
                        suffixIcon: IconButton(
                          icon: _isObscured
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          //Icon: Icon(Icons.visibility_off_outlined),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        } else if (!RegExp(
                                r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]+$')
                            .hasMatch(value)) {
                          return 'Password must contain at least one uppercase, lowercase, number, and symbol';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: _isObscured,
                      expands: false,
                      controller: confirmController,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        prefixIcon: const Icon(Iconsax.key),
                        suffixIcon: IconButton(
                          icon: _isObscured
                              ? const Icon(Icons.visibility)
                              : const Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                          //Icon: Icon(Icons.visibility_off_outlined),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
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
                          if (formKey.currentState!.validate()) {
                            try {
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
                              setState(() {
                                isPressed = false;
                              });
                              log('$error');
                              showCustomSnackbar('Error: $error', context);
                            }
                          }
                        },
                        child: isPressed
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: color.surface,
                                ),
                              )
                            : Text(
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
                          child: const Text('Login'),
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
