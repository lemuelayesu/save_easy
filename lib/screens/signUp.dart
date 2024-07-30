import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:save_easy/screens/home.dart';
import 'package:save_easy/screens/logIn.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
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
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      expands: false,
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
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Homepage();
                              },
                            ),
                          );
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
